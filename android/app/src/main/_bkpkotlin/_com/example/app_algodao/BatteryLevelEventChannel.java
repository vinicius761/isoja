package com.example.isoja;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;

import io.flutter.plugin.common.EventChannel;

public class BatteryLevelEventChannel implements EventChannel.StreamHandler {
    private BroadcastReceiver chargingStateChangeReceiver;
    private final Context applicationContext;

    public BatteryLevelEventChannel(Context context) {
        this.applicationContext = context;
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        chargingStateChangeReceiver = createChargingStateChangeReceiver(events);
        applicationContext.registerReceiver(
                chargingStateChangeReceiver,
                new IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        );
    }

    @Override
    public void onCancel(Object arguments) {
        if (chargingStateChangeReceiver != null) {
            applicationContext.unregisterReceiver(chargingStateChangeReceiver);
            chargingStateChangeReceiver = null;
        }
    }

    private BroadcastReceiver createChargingStateChangeReceiver(final EventChannel.EventSink events) {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                int level = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
                int scale = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);

                if (level >= 0 && scale > 0) {
                    int batteryPct = (int) ((level * 100.0f) / scale);
                    events.success(batteryPct);
                } else {
                    events.error("UNAVAILABLE", "Battery info not available", null);
                }
            }
        };
    }
}
