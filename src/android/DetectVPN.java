package com.example.detectvpn;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;

import java.net.NetworkInterface;
import java.util.Collections;

public class DetectVPN extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("isVpnEnabled")) {
            boolean vpnEnabled = isVpnEnabled();
            callbackContext.success(vpnEnabled ? 1 : 0); // send 1 if VPN is enabled, 0 otherwise
            return true;
        }
        return false;
    }

    private boolean isVpnEnabled() {
        try {
            for (NetworkInterface networkInterface : Collections.list(NetworkInterface.getNetworkInterfaces())) {
                if (networkInterface.isUp() && networkInterface.getInterfaceAddresses().size() > 0) {
                    if ("tun0".equals(networkInterface.getName()) || "ppp0".equals(networkInterface.getName())) {
                        return true; // VPN is active
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
