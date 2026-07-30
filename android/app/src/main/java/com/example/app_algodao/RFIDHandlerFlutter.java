package com.example.isoja;

import android.content.Context;
import android.util.Log;

import com.zebra.rfid.api3.ReaderDevice;
import com.zebra.scannercontrol.DCSScannerInfo;
import com.zebra.scannercontrol.FirmwareUpdateEvent;

public class RFIDHandlerFlutter extends RFIDHandler {

    public RFIDHandlerFlutter(Context androidContext, ResponseHandlerInterface callback) {
        super(androidContext, callback); // Agora passa os dois parâmetros corretamente
    }

    @Override
    public void dcssdkEventScannerDisappeared(int scannerID) {}

    @Override
    public void dcssdkEventAuxScannerAppeared(DCSScannerInfo info1, DCSScannerInfo info2) {}

    @Override
    public void dcssdkEventAuxScannerDisappeared(DCSScannerInfo info1, DCSScannerInfo info2) {}


    @Override
    public void dcssdkEventCommunicationSessionTerminated(int scannerID) {}

    @Override
    public void dcssdkEventBarcode(byte[] barcodeData, int barcodeType, int fromScannerID) {}

    @Override
    public void dcssdkEventImage(byte[] bytes, int i) {

    }

    @Override
    public void dcssdkEventVideo(byte[] bytes, int i) {

    }

    @Override
    public void dcssdkEventBinaryData(byte[] bytes, int i) {

    }

    @Override
    public void dcssdkEventFirmwareUpdate(FirmwareUpdateEvent firmwareUpdateEvent) {

    }

    @Override
    public void dcssdkEventScannerNotification(byte[] notificationData, int fromScannerID) {}

    @Override
    public void RFIDReaderAppeared(ReaderDevice readerDevice) {

    }

    @Override
    public void RFIDReaderDisappeared(ReaderDevice readerDevice) {

    }
}


