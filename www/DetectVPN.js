/* global cordova, module */

module.exports = {
    isVPNConnected: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "DetectVPN", "isVPNConnected", []);
    }
};
