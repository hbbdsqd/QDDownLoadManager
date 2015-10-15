//
//  HTTPDownload.h
//  QDDownLoadManager
//
//  Created by MS on 15/10/15.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPDownload;

//请求成功的回调
typedef void(^HTTPDownloadFinishBlock)(HTTPDownload *request);
//失败回调
typedef void(^HTTPDownloadErrorBlock)(HTTPDownload *request,NSError *error);

@interface HTTPDownload : NSObject

@property (nonatomic, strong) NSURL *url;

- (id)initWithUrl:(NSURL *)url;

/**
 *  开始下载
 */
- (void)startDownload;

/**
 *  设置回调
 *
 *  @param finish 成功回调
 *  @param error  失败回调
 */
- (void)setDownloadFinish:(HTTPDownloadFinishBlock)finish error:(HTTPDownloadErrorBlock)error;

@end
