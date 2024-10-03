/* global cordova, module */

module.exports = {
    isVpnEnabled: function(successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "DetectVPN", "isVpnEnabled", []);
    }
};
