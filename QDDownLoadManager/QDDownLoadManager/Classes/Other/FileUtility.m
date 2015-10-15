//
//  FileUtility.m
//  QDDownLoadManager
//
//  Created by MS on 15/10/15.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "FileUtility.h"

@implementation FileUtility

/**
 *  根据指定路径判断当前文件是否存在
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isExistFileWithPath:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

/**
 *  根据指定文件路径返回文件大小
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
+ (long long)fileSizeWithPath:(NSString *)path
{
    //1.获取文件属性
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    
    //2.获取文件大小
    return [attributes[NSFileSize] longLongValue];
    
}

@end
