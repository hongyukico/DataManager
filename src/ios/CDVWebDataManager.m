//
//  CDVWebDataManager.m
//  MyFamily
//
//  Created by zyj7815 on 2016/10/25.
//  Copyright © 2016年 ZYJ. All rights reserved.
//

#import "CDVWebDataManager.h"

@implementation CDVWebDataManager

//获得plist路径
+ (NSString*)getPlistPath {
    //沙盒中的文件路径
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    NSString *plistPath =[doucumentsDirectiory stringByAppendingPathComponent:@"WebDataManager.plist"];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"plist = %@",plistPath);
    });
    return plistPath;
}


// 判断plistname的某个key是否存在
+ (BOOL)hasPlistKey:(NSString *)key {
    
    NSString *plistPath = [CDVWebDataManager getPlistPath];
    NSMutableDictionary *plistDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    if(![plistDic objectForKey:key]) {
        NSLog(@"not exists");
        return NO;
    }
    else {
        return YES;
    }
}


//判断沙盒中名为plistname的文件是否存在
+ (BOOL)isPlistFileExists {
    
    NSString *plistPath = [CDVWebDataManager getPlistPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:plistPath]== NO ) {
        NSLog(@"not exists");
        return NO;
    }else{
        return YES;
    }
}


// 根据key值删除对应计划
+ (void)removeBookWithKey:(NSString *)key {
    
    NSString *plistPath = [CDVWebDataManager getPlistPath];
    NSMutableDictionary *planDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    [planDictionary removeObjectForKey:key];
    [planDictionary writeToFile:plistPath atomically:YES]; //删除后重新写入
}


/**
 *  删除有关用户在plist中的数据
 */
+ (void)deleteUserPlistData {
    
    NSArray *plistKeyArr = [CDVWebDataManager readPlist].allKeys;
    
    for (int i = 0; i < plistKeyArr.count; i++) {
        if ([plistKeyArr[i] rangeOfString:@"id_1"].location != NSNotFound) {
            NSString *key = plistKeyArr[i];
            [CDVWebDataManager removeBookWithKey:key];
        }
    }
}


//将dictionary写入plist文件，前提：dictionary已经准备好
+ (void)writePlist:(id)data
            forKey:(NSString *)key
           success:(void (^)(void))success{
    
    if (data == nil) {
        return;
    }
    
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc]init];
    
    // 如果已存在则读取现有数据
    if ([CDVWebDataManager isPlistFileExists]) {
        plistDictionary = [CDVWebDataManager readPlist];
    }
    
    //增加一个数据（没有key代表增加，有key代表修改）
    [plistDictionary setValue:data forKey:key]; //在plistDictionary增加一个key为...的value
    
    NSString *plistPath = [CDVWebDataManager getPlistPath];
    
    if([plistDictionary writeToFile:plistPath atomically:YES]){
        NSLog(@"write ok!");
        success();
    }else{
        NSLog(@"ddd");
    }
}


+ (NSMutableDictionary *)readPlist {
    
    NSString *plistPath = [CDVWebDataManager getPlistPath];
    NSMutableDictionary *resultDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    return resultDictionary;
}

@end
