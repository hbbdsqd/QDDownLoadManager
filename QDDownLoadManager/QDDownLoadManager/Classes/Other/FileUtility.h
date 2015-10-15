//
//  FileUtility.h
//  QDDownLoadManager
//
//  Created by MS on 15/10/15.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtility : NSObject

/**
 *  根据指定路径判断当前文件是否存在
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)isExistFileWithPath:(NSString *)path;

/**
 *  根据指定文件路径返回文件大小
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
+ (long long)fileSizeWithPath:(NSString *)path;

@end
