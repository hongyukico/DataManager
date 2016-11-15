//
//  CDVDataManager.m
//  HelloCordova
//
//  Created by zyj7815 on 16/10/17.
//
//

#import "CDVDataManager.h"
#import "CDVWebDataManager.h"

@implementation CDVDataManager

- (void)postData:(CDVInvokedUrlCommand *)command {
    
    [self.commandDelegate runInBackground:^{
        NSDictionary *dict = command.arguments[0];
        NSString *key = dict[@"key"];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict[@"dataSource"] options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [CDVWebDataManager writePlist:jsonString forKey:key success:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                CDVPluginResult *pluginResult = nil;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
                [self.commandDelegate sendPluginResult:pluginResult
                                            callbackId:command.callbackId];
            });
        }];
    }];
}

- (void)deleteData:(CDVInvokedUrlCommand *)command {
    
    [self.commandDelegate runInBackground:^{
        
        NSString *key = command.arguments[0][@"key"];
        [CDVWebDataManager removeBookWithKey:key];
        dispatch_async(dispatch_get_main_queue(), ^{
            CDVPluginResult *pluginResult = nil;
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
            [self.commandDelegate sendPluginResult:pluginResult
                                        callbackId:command.callbackId];
        });
    }];
    
}


- (void)getData:(CDVInvokedUrlCommand *)command {
    
    
    [self.commandDelegate runInBackground:^{
        
        NSString *key = command.arguments[0][@"key"];
        NSString *plistPath = [CDVWebDataManager getPlistPath];
        NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CDVPluginResult *pluginResult = nil;
            
            if (resultDictionary[key]) {
                NSString *dataString = resultDictionary[key];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                 messageAsString:dataString];
                [self.commandDelegate sendPluginResult:pluginResult
                                            callbackId:command.callbackId];
                
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                                 messageAsString:nil];
                [self.commandDelegate sendPluginResult:pluginResult
                                            callbackId:command.callbackId];
                
            }
        });
        
    }];
    
}

@end
