//
//  CDVWebDataManager.h
//  MyFamily
//
//  Created by zyj7815 on 2016/10/25.
//  Copyright © 2016年 ZYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDVWebDataManager : NSObject


/**
 *  获得plist路径
 */
+ (NSString*)getPlistPath;

/**
 *   判断plistname的某个key是否存在
 */
+ (BOOL)hasPlistKey:(NSString *)key;


/**
 *  根据key值删除对应计划
 */
+ (void)removeBookWithKey:(NSString *)key;

/**
 *  删除有关用户在plist中的数据(除开本地提醒的数据)
 */
+ (void)deleteUserPlistData;

/**
 *  将dictionary写入plist文件，前提：dictionary已经准备好
 */
+ (void)writePlist:(id)data
            forKey:(NSString *)key
           success:(void(^)(void))success;

/**
 *  读取plist数据
 */
+ (NSMutableDictionary *)readPlist;

@end
