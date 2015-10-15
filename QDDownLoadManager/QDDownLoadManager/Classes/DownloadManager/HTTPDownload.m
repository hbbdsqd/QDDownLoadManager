//
//  HTTPDownload.m
//  QDDownLoadManager
//
//  Created by MS on 15/10/15.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "HTTPDownload.h"
#import "FileUtility.h"
#import "NSString+Addition.h"
#import "NSURL+Addition.h"

@interface HTTPDownload ()
{
    
    HTTPDownloadFinishBlock _finishBlock;
    HTTPDownloadErrorBlock _errorBlock;
    
    //文件写入句柄
    NSFileHandle *_handle;
    
    /**
     *  已经下载的文件大小
     */
    long long _downloadSize;
    
    /**
     *  文件总大小
     */
    long long _fileSize;
}



@end

@implementation HTTPDownload


- (id)initWithUrl:(NSURL *)url
{
    if (self = [super init])
    {
        _url = url;
    }
    
    return self;
}

/**
 *  开始下载
 */
- (void)startDownload
{
    if (!_url)
    {
        return;
    }
    
    //文件名字
    NSString *filename = [[_url string] md5];
    
    //文件路径
    NSString *path = [self pathForCacheFilePathWithFileName:filename];
    
    //请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
    
    /*
     文件已经下载一部分了
     文件根本就没下载过
     */
    //判断是否下载一部分了。
    if ([FileUtility isExistFileWithPath:path])
    {
        //1.如果已经下载一部分，从当前位置开始下载
        _downloadSize = [FileUtility fileSizeWithPath:path];
        //2.告诉服务器从哪个地方开始下载
        /*
         bytes=500-
         */
        [request addValue:[NSString stringWithFormat:@"bytes=%lld-",_downloadSize] forHTTPHeaderField:@"Range"];
      
    }
    //本地不存在，从头开始下载
    else
    {
        //1.创建path
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    
    //创建文件写入句柄
    _handle = [NSFileHandle fileHandleForWritingAtPath:path];
    
    
    //发送异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}

/**
 *  返回当前文件路径
 *
 *  @param fileName <#fileName description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)pathForCacheFilePathWithFileName:(NSString *)fileName
{
    //获取临时目录
   // NSTemporaryDirectory()
    
    //获取沙盒里面的cache目录
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    return [cachePath stringByAppendingPathComponent:fileName];
    
}

#pragma mark - setter方法
/**
 *  设置回调
 *
 *  @param finish 成功回调
 *  @param error  失败回调
 */
- (void)setDownloadFinish:(HTTPDownloadFinishBlock)finish error:(HTTPDownloadErrorBlock)error
{
    _finishBlock = finish;
    _errorBlock = error;
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //文件总大小
    _fileSize = [response expectedContentLength] + _downloadSize;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //当前下载的文件大小
    _downloadSize += data.length;
    
    //计算进度
    float progess = (float)_downloadSize/_fileSize;
    
    NSLog(@"--- %f",progess);
    
    //在文件尾部写入，否则会覆盖原来的数据
    [_handle seekToEndOfFile];
    //写入
    [_handle writeData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   
    //成功回调
    if (_finishBlock)
    {
        _finishBlock(self);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //失败回调
    if (_errorBlock)
    {
        _errorBlock(self,error);
    }
}

@end
