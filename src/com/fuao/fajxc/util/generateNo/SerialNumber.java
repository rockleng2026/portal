package com.fuao.fajxc.util.generateNo;

abstract class SerialNumber {

    public synchronized String getSerialNumber() {
        return process();
    }
    protected abstract String process();
}
