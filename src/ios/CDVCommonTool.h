//
//  CommonTool.h
//  MyFamily
//
//  Created by neo on 15/11/7.
//  Copyright © 2015年 ZYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDVCommonTool : NSObject


/**
 *将程序内事先建立的数据库 复制到 document中
 *@param fileName 数据库文件名
 *@return -1表示已经存在
 */
+ (int)copyFileToDocument:(NSString *)fileName;


/*!
 @brief 读取在本地的数据库地址
 @return 数据库地址
 */
+ (NSString *)databasePath;


/*!
 @brief 删除沙盒里的文件
 */
+ (void)deleteFile:(NSString *)dbName;



@end
