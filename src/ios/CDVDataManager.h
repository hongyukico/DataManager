//
//  CDVDataManager.h
//  HelloCordova
//
//  Created by zyj7815 on 16/10/17.
//
//

#import <Cordova/CDVPlugin.h>

@interface CDVDataManager : CDVPlugin

- (void)postData:(CDVInvokedUrlCommand *)command;

- (void)getData:(CDVInvokedUrlCommand *)command;

- (void)deleteData:(CDVInvokedUrlCommand *)command;

@end
