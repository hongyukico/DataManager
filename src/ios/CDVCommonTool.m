//
//  CommonTool.m
//  MyFamily
//
//  Created by neo on 15/11/7.
//  Copyright © 2015年 ZYJ. All rights reserved.
//

#import "CDVCommonTool.h"

@implementation CDVCommonTool



+ (NSString *)documentsPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
    
}

+ (NSString *)fullpathOfFilename:(NSString *)filename {
    
    NSString *documentsPath = [self documentsPath];
    
    return [documentsPath stringByAppendingPathComponent:filename];
    
}



+ (int)copyFileToDocument:(NSString *)fileName
{
    NSString *appFileName = [self fullpathOfFilename:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    //判断沙盒下是否存在
    BOOL isExist = [fm fileExistsAtPath:appFileName];
    if (!isExist)   //不存在，把工程的文件复制document目录下
    {
        //获取工程中文件
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  
                                  pathForResource:fileName
                                  
                                  ofType:@""];
        //这一步实现数据库的添加，
        
        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径复制到应用程序的路径上
        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:appFileName error:nil];
        
        return cp;
    }
    else
    {
        return  -1; //已经存在
    }
}



+ (NSString *)databasePath {
    
    // 保存、存到 Document 文件夹中 的 MySqliteDB.db
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * dbPath = [path stringByAppendingPathComponent:@"MySqlite.db"];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 只执行1次的代码(这里面默认是线程安全的)
        NSLog(@" —— —— —— —— —— —— —— —— —— —— —— ——%@",path);
    });
    
    return dbPath;
}


// 删除沙盒里的文件
+ (void)deleteFile:(NSString *)dbName
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名@"MySqliteDB.db"
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:dbName];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    // 如果不存在就不做操作
    if (!blHave) {
        return;
    }
    // 如果存在就删除
    else {
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele)
        {
            NSLog(@"delete success");
        }
        else
        {
            NSLog(@"delete fail");
        }
    }
}



@end
