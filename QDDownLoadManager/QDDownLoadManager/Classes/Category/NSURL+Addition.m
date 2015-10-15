//
//  NSURL+Addition.m
//  QDDownLoadManager
//
//  Created by MS on 15/10/15.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.//

#import "NSURL+Addition.h"

@implementation NSURL (Addition)

/**
 *  把url对象转化字符串
 *
 *  @return <#return value description#>
 */
- (NSString *)string
{
    return [self absoluteString];
}

@end
