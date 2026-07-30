package com.example.isoja;

import static com.zebra.rfid.api3.BEEPER_VOLUME.LOW_BEEP;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;

import com.zebra.rfid.api3.Antennas;
import com.zebra.rfid.api3.BatteryStatistics;
import com.zebra.rfid.api3.DeviceStatus;
import com.zebra.rfid.api3.ENUM_TRANSPORT;
import com.zebra.rfid.api3.HANDHELD_TRIGGER_EVENT_TYPE;
import com.zebra.rfid.api3.IEvents;
import com.zebra.rfid.api3.INVENTORY_STATE;
import com.zebra.rfid.api3.InvalidUsageException;
import com.zebra.rfid.api3.OperationFailureException;
import com.zebra.rfid.api3.RFIDReader;
import com.zebra.rfid.api3.RFModeTable;
import com.zebra.rfid.api3.RFModeTableEntry;
import com.zebra.rfid.api3.ReaderDevice;
import com.zebra.rfid.api3.Readers;
import com.zebra.rfid.api3.RfidEventsListener;
import com.zebra.rfid.api3.RfidReadEvents;
import com.zebra.rfid.api3.RfidStatusEvents;

import com.zebra.rfid.api3.SESSION;
import com.zebra.rfid.api3.SL_FLAG;
import com.zebra.rfid.api3.START_TRIGGER_TYPE;
import com.zebra.rfid.api3.STATUS_EVENT_TYPE;
import com.zebra.rfid.api3.STOP_TRIGGER_TYPE;
import com.zebra.rfid.api3.TagData;
import com.zebra.rfid.api3.TriggerInfo;
import com.zebra.scannercontrol.DCSSDKDefs;
import com.zebra.scannercontrol.DCSScannerInfo;
import com.zebra.scannercontrol.IDcsSdkApiDelegate;
import com.zebra.scannercontrol.SDKHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;

public abstract class RFIDHandler implements IDcsSdkApiDelegate, Readers.RFIDReaderEventHandler {

    private static final String TAG = "RFIDHandler";

    private EventChannel.EventSink eventSink;
    private Readers readers;
    private RFIDReader reader;
    private SDKHandler sdkHandler;
    private int scannerID;
    private ArrayList<DCSScannerInfo> scannerList = new ArrayList<>();
    private EventHandler eventHandler;

    private int MAX_POWER;

    private Map<String, Long> lastReadTimes = new HashMap<>();

    private Context androidContext;  // contexto Android correto
    protected ResponseHandlerInterface callback;  // interface para callbacks

    // Construtor que recebe Context e callback separadamente
    public RFIDHandler(Context androidContext, ResponseHandlerInterface callback) {
        this.androidContext = androidContext;
        this.callback = callback;
        this.eventSink = eventSink;
    }



    // ===================== READER CONFIG =====================
    private void ConfigureReader() {
        System.out.println("Entrou aqui quando iniciioiu ConfigureReader");
        Log.d(TAG, "ConfigureReader " + reader.getHostName());
        if (reader.isConnected()) {
            TriggerInfo triggerInfo = new TriggerInfo();
            triggerInfo.StartTrigger.setTriggerType(START_TRIGGER_TYPE.START_TRIGGER_TYPE_IMMEDIATE);
            triggerInfo.StopTrigger.setTriggerType(STOP_TRIGGER_TYPE.STOP_TRIGGER_TYPE_IMMEDIATE);
            try {
                if (eventHandler == null) eventHandler = new EventHandler();
                reader.Events.addEventsListener(eventHandler);
                reader.Events.setHandheldEvent(true);
                reader.Events.setTagReadEvent(true);
                reader.Events.setAttachTagDataWithReadEvent(false);



                MAX_POWER = reader.ReaderCapabilities.getTransmitPowerLevelValues().length - 1;
                //MAX_POWER = 150;

                System.out.println("Max Power sinal: " +MAX_POWER);


                Antennas.AntennaRfConfig config = reader.Config.Antennas.getAntennaRfConfig(1);
                config.setTransmitPowerIndex(5);
                config.setrfModeTableIndex(2);
                config.setTari(0);
                reader.Config.Antennas.setAntennaRfConfig(1, config);
                reader.Config.setBeeperVolume(LOW_BEEP);

                Antennas.SingulationControl s1_singulationControl = reader.Config.Antennas.getSingulationControl(1);
                s1_singulationControl.setSession(SESSION.SESSION_S0);
                s1_singulationControl.Action.setInventoryState(INVENTORY_STATE.INVENTORY_STATE_AB_FLIP);
                s1_singulationControl.Action.setSLFlag(SL_FLAG.SL_ALL);

                reader.Config.Antennas.setSingulationControl(1, s1_singulationControl);

                reader.Actions.PreFilters.deleteAll();
                reader.Config.getDeviceStatus(true,true,true);
               // System.out.printf("Bateria do Leitor: %s%n", reader.Config.getDeviceStatus(true, true, true));


            } catch (InvalidUsageException | OperationFailureException e) {
                e.printStackTrace();
            }
        }
    }



    public void aplicarConfiguracaoRF(int powerIndex, int rfMode, int tari, String mode) {
        try {
            Antennas.AntennaRfConfig cfg =
                    reader.Config.Antennas.getAntennaRfConfig(1);

            cfg.setTransmitPowerIndex(powerIndex);
            cfg.setrfModeTableIndex(rfMode);
            cfg.setTari(tari);

            reader.Config.Antennas.setAntennaRfConfig(1, cfg);

            Log.d("RFID", "Config aplicada: " + mode);

        } catch (Exception e) {
            Log.e("RFID", "Erro config pelo metodo channel: " + e.getMessage());
        }
    }



    // ===================== SDK SETUP =====================
    public void setupScannerSDK() {
        System.out.println("Entrou setupScannerSDK");

        if (sdkHandler == null) {
            sdkHandler = new SDKHandler(androidContext, true);
            sdkHandler.dcssdkSetDelegate(this);

            int notifications_mask =
                    DCSSDKDefs.DCSSDK_EVENT.DCSSDK_EVENT_SCANNER_APPEARANCE.value |
                            DCSSDKDefs.DCSSDK_EVENT.DCSSDK_EVENT_SCANNER_DISAPPEARANCE.value |
                            DCSSDKDefs.DCSSDK_EVENT.DCSSDK_EVENT_BARCODE.value |
                            DCSSDKDefs.DCSSDK_EVENT.DCSSDK_EVENT_SESSION_ESTABLISHMENT.value |
                            DCSSDKDefs.DCSSDK_EVENT.DCSSDK_EVENT_SESSION_TERMINATION.value;

            sdkHandler.dcssdkSubsribeForEvents(notifications_mask);
        }

        // atualiza lista de scanners
        ArrayList<DCSScannerInfo> availableScanners =
                (ArrayList<DCSScannerInfo>) sdkHandler.dcssdkGetAvailableScannersList();

        scannerList.clear();
        if (availableScanners != null) {
            scannerList.addAll(availableScanners);
        }

        // ----------------------------
        // RFID (ISOLADO DO QR)
        // ----------------------------
        if (reader == null) {
            try {
                readers = new Readers(androidContext, ENUM_TRANSPORT.BLUETOOTH);

                ArrayList<ReaderDevice> rfidReaders =
                        readers.GetAvailableRFIDReaderList();

                if (rfidReaders != null && !rfidReaders.isEmpty()) {

                    reader = rfidReaders.get(0).getRFIDReader();

                    if (!reader.isConnected()) {
                        reader.connect();
                        ConfigureReader();
                        System.out.println("RFID conectado com sucesso!");
                    }

                } else {
                    System.out.println("Nenhum RFIDReader encontrado");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // ----------------------------
        // SESSÃO DO QR (NÃO DEPENDE DO RFID)
        // ----------------------------
        if (sdkHandler != null && scannerList != null) {
            for (DCSScannerInfo device : scannerList) {

                try {
                    sdkHandler.dcssdkEstablishCommunicationSession(device.getScannerID());
                    scannerID = device.getScannerID();

                    System.out.println("Sessão QR ativa ID: " + scannerID);
                    break; // 🔥 importante: evita múltiplas sessões

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // ===================== CONNECT/DISCONNECT =====================
    private synchronized void disconnect() {
        try {
            if (reader != null) {
                if (eventHandler != null) reader.Events.removeEventsListener(eventHandler);
                if (sdkHandler != null) sdkHandler.dcssdkTerminateCommunicationSession(scannerID);
                reader.disconnect();
                callback.sendToast("Disconnecting reader");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void onNotificationReceived(String notification) {
        System.out.println("Passou onNotificationReceived");
        if (notification.contains("TriggerEvent")) {
            boolean pressed = notification.contains("TriggerValue:0"); // 0 = pressed, 1 = released
            if (eventSink != null) {
                Map<String, Object> map = new HashMap<>();
                map.put("type", "trigger");
                map.put("pressed", pressed);
                eventSink.success(map);
            }
        }
    }

    synchronized void dispose() {
        disconnect();
        if (reader != null) {
            reader = null;
            if (readers != null) {
                readers.Dispose();
                readers = null;
            }
        }
    }

    // ===================== INVENTORY =====================
    synchronized void performInventory() {
        System.out.println("Iniciando inventário...");
        try {
            reader.Actions.Inventory.perform();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    synchronized void stopInventory() {
        try {
            reader.Actions.Inventory.stop();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void scanCode() {
        System.out.println("Passou no qrcod scan");
        String in_xml = "<inArgs><scannerID>" + scannerID + "</scannerID></inArgs>";
        new MyAsyncTask(scannerID, DCSSDKDefs.DCSSDK_COMMAND_OPCODE.DCSSDK_DEVICE_PULL_TRIGGER, null)
                .execute(in_xml);
    }

    private class MyAsyncTask extends AsyncTask<String, Integer, Boolean> {
        int scannerId;
        StringBuilder outXML;
        DCSSDKDefs.DCSSDK_COMMAND_OPCODE opcode;

        public MyAsyncTask(int scannerId, DCSSDKDefs.DCSSDK_COMMAND_OPCODE opcode, StringBuilder outXML) {
            this.scannerId = scannerId;
            this.opcode = opcode;
            this.outXML = outXML;
        }

        @Override
        protected Boolean doInBackground(String... strings) {
            System.out.println("Passou aqui....");
            return executeCommand(opcode, strings[0], outXML, scannerId);
        }
    }

    public boolean executeCommand(DCSSDKDefs.DCSSDK_COMMAND_OPCODE opCode, String inXML, StringBuilder outXML, int scannerID) {
        System.out.println("Passou executeCommand" + sdkHandler.dcssdkGetAvailableScannersList());

        if (sdkHandler != null) {
            if (outXML == null) outXML = new StringBuilder();
            DCSSDKDefs.DCSSDK_RESULT result = sdkHandler.dcssdkExecuteCommandOpCodeInXMLForScanner(opCode, inXML, outXML, scannerID);
            Log.d(TAG, "execute command returned " + result.toString());
            return result == DCSSDKDefs.DCSSDK_RESULT.DCSSDK_RESULT_SUCCESS;
        }
        return false;
    }

    // ===================== EVENT HANDLER =====================
    public class EventHandler implements RfidEventsListener {
       /* @Override
        public void eventReadNotify(RfidReadEvents e) {
            System.out.println("Passou aqui no eventReadNotify" );
            TagData[] myTags = reader.Actions.getReadTags(100);

            if (myTags != null) {


                for (TagData tag : myTags) {
                    Log.d(TAG, "Tag ID: " + tag.getTagID() + " RSSI: " + tag.getPeakRSSI());
                }
                new AsyncDataUpdate().execute(myTags);
            }
        }*/

        @Override
        public void eventReadNotify(RfidReadEvents e) {
            System.out.println("📡 Passou aqui no eventReadNotify");


            // Obtém até 100 tags lidas recentemente do buffer
            TagData[] myTags = reader.Actions.getReadTags(100);

            if (myTags != null && myTags.length > 0) {
                for (TagData tag : myTags) {
                    String epc = tag.getTagID();
                    long now = System.currentTimeMillis();

                    // Verifica se a tag foi lida recentemente (ex: 2 segundos)
                    if (lastReadTimes.containsKey(epc) && now - lastReadTimes.get(epc) < 2000) {
                        continue; // Ignora duplicata recente
                    }

                    // Atualiza o último horário de leitura dessa tag
                    lastReadTimes.put(epc, now);

                    // Log local
                    Log.d("RFID", "Tag ID: " + epc + " RSSI: " + tag.getPeakRSSI());

                    // Se você quiser enviar para o Flutter:
                  /*  if (eventSink != null) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("type", "tag");
                        map.put("tagId", epc);
                        map.put("rssi", tag.getPeakRSSI());
                        map.put("timestamp", now);

                        // Garante execução na thread principal
                        new Handler(Looper.getMainLooper()).post(() -> eventSink.success(map));
                    }*/
                }
                new AsyncDataUpdate().execute(myTags);
            } else {
                // Nenhuma tag nova
                Log.d("RFID", "Nenhuma tag nova detectada.");
            }
        }

        @Override
        public void eventStatusNotify(RfidStatusEvents rfidStatusEvents) {
            System.out.println("Clicou1");

            try {
                IEvents.StatusEventData data = rfidStatusEvents.StatusEventData;

                if (data.getStatusEventType() == STATUS_EVENT_TYPE.HANDHELD_TRIGGER_EVENT) {
                    IEvents.HandheldTriggerEventData event = data.HandheldTriggerEventData;
                    HANDHELD_TRIGGER_EVENT_TYPE triggerEvent = event.getHandheldEvent();

                    System.out.println("Event teste: " + triggerEvent);

                    // 🔹 Quando o gatilho é pressionado
                    if (triggerEvent == HANDHELD_TRIGGER_EVENT_TYPE.HANDHELD_TRIGGER_PRESSED) {
                        System.out.println("▶️ Iniciando inventário...");
                        try {
                            reader.Actions.Inventory.perform();
                        } catch (InvalidUsageException | OperationFailureException e) {
                            System.err.println("❌ Erro ao iniciar inventário: " + e.getMessage());
                        }
                    }

                    // 🔹 Quando o gatilho é solto
                    else if (triggerEvent == HANDHELD_TRIGGER_EVENT_TYPE.HANDHELD_TRIGGER_RELEASED) {
                        System.out.println("🛑 Parando inventário...");
                        try {
                            reader.Actions.Inventory.stop();
                        } catch (InvalidUsageException | OperationFailureException e) {
                            System.err.println("❌ Erro ao parar inventário: " + e.getMessage());
                        }
                    }
                }

                // 🔹 Se o leitor desconectar
                else if (data.getStatusEventType() == STATUS_EVENT_TYPE.DISCONNECTION_EVENT) {
                    System.out.println("⚠️ Dispositivo desconectado");
                    disconnect();
                }

            } catch (Exception e) {
                System.err.println("⚠️ Erro no eventStatusNotify: " + e.getMessage());
                e.printStackTrace();
            }
        }


     /*  @Override
        public void eventStatusNotify(RfidStatusEvents rfidStatusEvents) {
           System.out.println("Clicou1");
            IEvents.StatusEventData data = rfidStatusEvents.StatusEventData;
            if (data.getStatusEventType() == STATUS_EVENT_TYPE.HANDHELD_TRIGGER_EVENT) {
                IEvents.HandheldTriggerEventData event = data.HandheldTriggerEventData;
                System.out.println("Event teste:" + event.getHandheldEvent());
                //callback.handleTriggerPress(event.getHandheldEvent() == HANDHELD_TRIGGER_EVENT_TYPE.HANDHELD_TRIGGER_PRESSED);
                //System.out.println("Clicou");
                try {
                    //if (event.getHandheldEvent().equals("HANDHELD_TRIGGER_PRESSED")) {

                        // Inicia leitura RFID
                        reader.Actions.Inventory.perform();
                        System.out.println("Inventário iniciado");
                    //} else {
                        // Para leitura RFID
                        reader.Actions.Inventory.stop();
                        System.out.println("🛑 Inventário parado");
                   // }
                } catch (InvalidUsageException | OperationFailureException e) {
                    e.printStackTrace();
                }
            }




            if (data.getStatusEventType() == STATUS_EVENT_TYPE.DISCONNECTION_EVENT) {
                disconnect();
            }
        }*/
    }

  /*  @Override
    public void eventStatusNotify(RfidStatusEvents rfidStatusEvents) {
        IEvents.StatusEventData data = rfidStatusEvents.StatusEventData;
        if (data.getStatusEventType() == STATUS_EVENT_TYPE.HANDHELD_TRIGGER_EVENT) {
            IEvents.HandheldTriggerEventData event = data.HandheldTriggerEventData;
            if (callback != null) {
                boolean pressed = event.getHandheldEvent() == HANDHELD_TRIGGER_EVENT_TYPE.HANDHELD_TRIGGER_PRESSED;
                callback.handleTriggerPress(pressed);
            }
        }
        if (data.getStatusEventType() == STATUS_EVENT_TYPE.DISCONNECTION_EVENT) {
            disconnect();
        }
    }*/


    public synchronized void reconnectReader() {
        new Thread(() -> {
            try {
                Log.d(TAG, "🔄 Tentando reconectar...");

                if (reader != null) {
                    try {
                        reader.disconnect();
                    } catch (Exception ignored) {}

                    reader = null;
                }

                if (readers != null) {
                    readers.Dispose();
                    readers = null;
                }

                // Recria tudo do zero (igual reiniciar app)
                readers = new Readers(androidContext, ENUM_TRANSPORT.BLUETOOTH);
                ArrayList<ReaderDevice> devices = readers.GetAvailableRFIDReaderList();

                if (devices != null && !devices.isEmpty()) {
                    reader = devices.get(0).getRFIDReader();

                    reader.connect();
                    ConfigureReader();

                    Log.d(TAG, "✅ Reconectado com sucesso");

                    // 🔥 reestabelece sessão com scanner
                    if (sdkHandler != null) {
                        for (DCSScannerInfo device : scannerList) {
                            if (device.getScannerName().contains(reader.getHostName())) {
                                sdkHandler.dcssdkEstablishCommunicationSession(device.getScannerID());
                                scannerID = device.getScannerID();
                                break;
                            }
                        }
                    }

                } else {
                    Log.e(TAG, "❌ Nenhum reader encontrado pra reconectar");
                }

            } catch (Exception e) {
                Log.e(TAG, "❌ Erro ao reconectar: " + e.getMessage());
            }
        }).start();
    }

    public boolean isConnected() {
        return reader != null && reader.isConnected();
    }

    private class AsyncDataUpdate extends AsyncTask<TagData[], Void, Void> {
        @Override
        protected Void doInBackground(TagData[]... params) {
            // System.out.println("Passou na leitura rfid");
            // System.out.println("Passou na leitura rfid" + params[0].toString());
            callback.handleTagdata(params[0]);
            return null;
        }
    }

    // ===================== SDK INTERFACE =====================
    @Override
    public void dcssdkEventScannerAppeared(DCSScannerInfo scannerInfo) {}

    public void dcssdkEventScannerDisappeared(DCSScannerInfo scannerInfo) {}
    @Override
    public void dcssdkEventAuxScannerAppeared(DCSScannerInfo info1, DCSScannerInfo info2) {}

    public void dcssdkEventAuxScannerDisappeared(DCSScannerInfo info1, DCSScannerInfo info2) {}
    @Override
    public void dcssdkEventCommunicationSessionEstablished(DCSScannerInfo scannerInfo) {}

    public void dcssdkEventCommunicationSessionTerminated(DCSScannerInfo scannerInfo) {}
    @Override
    public void dcssdkEventBarcode(byte[] barcodeData, int barcodeType, int fromScannerID) {}

    public void dcssdkEventScannerNotification(byte[] notificationData, int fromScannerID) {}

    // ===================== RESPONSE INTERFACE =====================
    public interface ResponseHandlerInterface {
        void handleTagdata(TagData[] tagData);
        void handleTriggerPress(boolean pressed);
        void barcodeData(String val);
        void sendToast(String val);
    }
}
