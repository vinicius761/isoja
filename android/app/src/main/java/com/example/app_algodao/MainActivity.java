package com.example.isoja;

import android.Manifest;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.zebra.rfid.api3.BatteryStatistics;
import com.zebra.rfid.api3.DeviceStatus;
import com.zebra.rfid.api3.InvalidUsageException;
import com.zebra.rfid.api3.OperationFailureException;
import com.zebra.rfid.api3.TagData;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String EVENT_CHANNEL_RFID = "com.zebra.rfid/events";
    private static final String METHOD_CHANNEL_qr = "zebra_method_channel";
    private static final String EVENT_CHANNEL_rt = "zebra_data_channel";
    private static final String DW_INTENT_ACTION = "com.example.isoja.cotton";

    private EventChannel.EventSink eventSink;
    private RFIDHandlerFlutter rfidHandler;
    private BroadcastReceiver receiver;
    private BroadcastReceiver dataWedgeReceiver;

    private static final int BLUETOOTH_PERMISSION_REQUEST_CODE = 100;
    private Map<String, Long> lastReadTimes = new HashMap<>();
    private static final long TAG_DEBOUNCE_MS = 2000;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // EVENT CHANNEL RFID
        new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), EVENT_CHANNEL_RFID)
                .setStreamHandler(new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink sink) {
                        eventSink = sink;
                        initRFIDHandler();
                        startListeningToZebraButtons();
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        eventSink = null;
                        // Removido o rfidHandler.dispose() daqui para evitar que MethodChannels falhem
                    }
                });

        // METHOD CHANNEL BARCODE (DataWedge)
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), METHOD_CHANNEL_qr)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("activateProfile")) {
                        String profileName = call.argument("profileName");
                        if (profileName != null && !profileName.isEmpty()) {
                            activateDataWedgeProfile(profileName);
                            result.success("Perfil " + profileName + " ativado.");
                        } else {
                            result.error("INVALID_NAME", "Nome do perfil inválido", null);
                        }
                    } else {
                        result.notImplemented();
                    }
                });

        // EVENT CHANNEL DATAWEDGE (Barcode)
        new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), EVENT_CHANNEL_rt)
                .setStreamHandler(new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        eventSink = events;
                        dataWedgeReceiver = new BroadcastReceiver() {
                            @Override
                            public void onReceive(Context context, Intent intent) {
                                if (intent != null && DW_INTENT_ACTION.equals(intent.getAction())) {
                                    Bundle extras = intent.getExtras();
                                    if (extras != null) {
                                        String data = extras.getString("com.symbol.datawedge.data_string");
                                        if (data != null && eventSink != null) {
                                            Map<String, Object> map = new HashMap<>();
                                            map.put("type", "Barcode");
                                            map.put("tagId", data);
                                            map.put("rssi", "");
                                            map.put("status", "0");
                                            eventSink.success(map);
                                        }
                                    }
                                }
                            }
                        };
                        IntentFilter filter = new IntentFilter();
                        filter.addAction(DW_INTENT_ACTION);
                        ContextCompat.registerReceiver(MainActivity.this, dataWedgeReceiver, filter, ContextCompat.RECEIVER_EXPORTED);
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        if (dataWedgeReceiver != null) {
                            try {
                                unregisterReceiver(dataWedgeReceiver);
                            } catch (IllegalArgumentException ignored) {}
                            dataWedgeReceiver = null;
                        }
                    }
                });

        // METHOD CHANNEL RFID METHODS
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.zebra.rfid/methods")
                .setMethodCallHandler((call, result) -> {

                    // MELHORIA: Tenta inicializar se estiver null antes de executar qualquer comando
                    if (rfidHandler == null) {
                        setupHandlerCallbacks();
                    }

                    if (rfidHandler == null) {
                        result.error("UNAVAILABLE", "RFID handler is null. Check Bluetooth permissions.", null);
                        return;
                    }

                    switch (call.method) {
                        case "reconnect":
                            rfidHandler.reconnectReader();
                            result.success("Reconnecting...");
                            break;

                        case "startInventory":
                            rfidHandler.performInventory();
                            result.success(null);
                            break;

                        case "stopInventory":
                            rfidHandler.stopInventory();
                            result.success(null);
                            break;

                        case "scanCode":
                            rfidHandler.scanCode();
                            result.success(null);
                            break;

                        case "setRfConfig":
                            try {
                                int powerIndex = call.argument("powerIndex");
                                int rfMode = call.argument("rfMode");
                                int tari = call.argument("tari");
                                String mode = call.argument("mode");
                                rfidHandler.aplicarConfiguracaoRF(powerIndex, rfMode, tari, mode);
                                Log.d("RFID_CONFIG", "--- Novos Valores de Configuração RF ---");
                                Log.d("RFID_CONFIG", "Power Index: " + powerIndex);
                                Log.d("RFID_CONFIG", "RF Mode: " + rfMode);
                                Log.d("RFID_CONFIG", "Tari: " + tari);
                                Log.d("RFID_CONFIG", "Mode: " + mode);
                                Log.d("RFID_CONFIG", "---------------------------------------");

                                // Printando via System.out (Aparece no console do VS Code / Android Studio)
                                System.out.println("Config recebida -> Power: " + powerIndex + ", Mode: " + mode);

                                result.success(null);
                            } catch (Exception e) {
                                result.error("CONFIG_ERROR", e.getMessage(), null);
                            }
                            break;

                        case "isConnected":
                                result.success(rfidHandler.isConnected());
                                // result.success(false);
                            break;

                        default:
                            result.notImplemented();
                    }
                });
    }

    private void initRFIDHandler() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_CONNECT)
                    != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this,
                        new String[]{Manifest.permission.BLUETOOTH_SCAN, Manifest.permission.BLUETOOTH_CONNECT},
                        BLUETOOTH_PERMISSION_REQUEST_CODE);
                return;
            }
        }
        setupHandlerCallbacks();
    }

    private void setupHandlerCallbacks() {
        // Evita recriar se já existir e estiver ativo
        if (rfidHandler != null) return;

        rfidHandler = new RFIDHandlerFlutter(this, new RFIDHandler.ResponseHandlerInterface() {
            @Override
            public void handleTagdata(TagData[] tagData) {
                if (eventSink != null) {
                    new Handler(Looper.getMainLooper()).post(() -> {
                        long now = System.currentTimeMillis();
                        List<Map<String, Object>> tagsToSend = new ArrayList<>();

                        for (TagData tag : tagData) {
                            if (lastReadTimes.containsKey(tag.getTagID()) && (now - lastReadTimes.get(tag.getTagID())) < TAG_DEBOUNCE_MS) {
                                continue;
                            }
                            lastReadTimes.put(tag.getTagID(), now);

                            Map<String, Object> map = new HashMap<>();
                            map.put("type", "tag");
                            map.put("tagId", tag.getTagID());
                            map.put("rssi", tag.getPeakRSSI());
                            map.put("status", "0");

                            // Adicionado à lista para o evento em lote
                            tagsToSend.add(map);
                            // Envio individual (conforme seu original)
                            eventSink.success(map);
                        }

                        if (!tagsToSend.isEmpty()) {
                            Map<String, Object> eventMap = new HashMap<>();
                            eventMap.put("type", "tag_list");
                            eventMap.put("tags", tagsToSend);
                            eventSink.success(eventMap);
                        }
                    });
                }
            }

            @Override
            public void handleTriggerPress(boolean pressed) {
                if (eventSink != null) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("type", "trigger");
                    map.put("pressed", pressed);
                    eventSink.success(map);
                }
            }

            @Override
            public void barcodeData(String val) {
                if (eventSink != null) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("type", "barcode");
                    map.put("barcode", val);
                    map.put("status", "0");
                    eventSink.success(map);
                }
            }

            @Override
            public void sendToast(String val) {
                if (eventSink != null) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("type", "toast");
                    map.put("message", val);
                    eventSink.success(map);
                }
            }
        });
        rfidHandler.setupScannerSDK();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == BLUETOOTH_PERMISSION_REQUEST_CODE) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                setupHandlerCallbacks(); // Inicializa o handler assim que a permissão é dada
            } else {
                Toast.makeText(this, "Bluetooth Permissions not granted", Toast.LENGTH_SHORT).show();
            }
        }
    }

    private void activateDataWedgeProfile(String profileName) {
        Intent i = new Intent();
        i.setAction("com.symbol.datawedge.api.ACTION");
        i.putExtra("com.symbol.datawedge.api.ACTIVATE_PROFILE", profileName);
        sendBroadcast(i);
    }

    private void startListeningToZebraButtons() {
        IntentFilter filter = new IntentFilter();
        receiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                // Lógica de botões se necessário
            }
        };
        registerReceiver(receiver, filter, Context.RECEIVER_EXPORTED);
    }

    public void StartInventory(View view) {
        if (rfidHandler != null) rfidHandler.performInventory();
    }

    public void StopInventory(View view) {
        if (rfidHandler != null) rfidHandler.stopInventory();
    }

    public void scanCode(View view) {
        if (rfidHandler != null) rfidHandler.scanCode();
    }



    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (rfidHandler != null) {
            rfidHandler.dispose();
            rfidHandler = null;
        }
        if (receiver != null) {
            unregisterReceiver(receiver);
        }
    }
}