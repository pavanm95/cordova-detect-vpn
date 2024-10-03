#import <Cordova/CDV.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface DetectVPN : CDVPlugin
- (void)isVpnEnabled:(CDVInvokedUrlCommand*)command;
@end

@implementation DetectVPN

- (void)isVpnEnabled:(CDVInvokedUrlCommand*)command {
    BOOL vpnEnabled = [self checkVPN];
    CDVPluginResult* pluginResult = nil;

    if (vpnEnabled) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (BOOL)checkVPN {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;

    BOOL vpnEnabled = NO;

    // Retrieve the current interfaces - returns 0 on success
    if (getifaddrs(&interfaces) == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            NSString* name = [NSString stringWithUTF8String:temp_addr->ifa_name];
            
            if ([name containsString:@"utun"] || [name containsString:@"ipsec"]) {
                vpnEnabled = YES;
                break;
            }

            temp_addr = temp_addr->ifa_next;
        }
    }

    // Free memory
    freeifaddrs(interfaces);
    
    return vpnEnabled;
}

@end
