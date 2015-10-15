//
//  HTTPDownloadManager.m
//  QDDownLoadManager
//
//  Created by MS on 15/10/15.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "HTTPDownloadManager.h"
#import "HTTPDownload.h"
#import "NSURL+Addition.h"

@interface HTTPDownloadManager ()


/**
 *  下载完成列表
 */
@property (nonatomic , strong) NSMutableArray *downloadFinishLists;

/**
 *  正在下载的列表
 */
@property (nonatomic, strong) NSMutableArray *downloadingLists;

@end

@implementation HTTPDownloadManager

/**
 *  单例对象
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedManger
{
    
#if 0
    static HTTPDownloadManager *manager = nil;
    
    //对象锁
    @synchronized(self)
    {
        if (!manager)
        {
            manager = [[self alloc] init];
        }
        
        return manager;
    }
#endif
    
    static HTTPDownloadManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });

    
    return manager;
}

#pragma mark - 懒加载创建对象
- (NSMutableArray *)downloadFinishLists
{
    if (!_downloadFinishLists)
    {
        _downloadFinishLists = [NSMutableArray array];
    }
    
    return _downloadFinishLists;
}

- (NSMutableArray *)downloadingLists
{
    if (!_downloadingLists)
    {
        _downloadingLists = [NSMutableArray array];
    }
    
    return _downloadingLists;
}

/**
 *  添加下载任务
 *
 *  @param url <#url description#>
 */
- (void)addDownloadWithUrl:(NSURL *)url
{

    
    
    //1.启动下载
    HTTPDownload *download = [[HTTPDownload alloc] initWithUrl:url];
    //设置回调
    [download setDownloadFinish:^(HTTPDownload *request) {
        
        //1.当前下载从正在下载的列表里面移除
        [self.downloadingLists removeObject:request];
        //2.当前下载添加到下载完成列表里面
        [self.downloadFinishLists addObject:request];
        
    } error:^(HTTPDownload *request, NSError *error) {
        
        //1.当前下载从正在下载的列表里面移除
        [self.downloadingLists removeObject:request];
    }];
    //开始下载
    [download startDownload];
    
    //2.添加正在下载的列表
    [self.downloadingLists addObject:download];
}

/**
 *  判断是否已经下载完成
 *
 *  @return <#return value description#>
 */
- (BOOL)isExistInDownloadFinishListsWithUrl:(NSURL *)url
{
    //遍历查找
    for (HTTPDownload *download in self.downloadFinishLists)
    {
        //url存在
        if ([[download.url string] isEqualToString:[url string]])
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  判断是否正在下载
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isExistInDownloadingListsWithUrl:(NSURL *)url
{
    //遍历查找
    for (HTTPDownload *download in self.downloadingLists)
    {
        //url存在
        if ([[download.url string] isEqualToString:[url string]])
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  获取下载完成列表
 *
 *  @return <#return value description#>
 */
- (NSArray *)downloadHaveFinishLists
{
    return self.downloadFinishLists;
}

@end
