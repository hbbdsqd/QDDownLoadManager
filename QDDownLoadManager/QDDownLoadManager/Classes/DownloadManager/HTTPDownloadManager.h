//
//  HTTPDownloadManager.h
//  QDDownLoadManager
//
//  Created by MS on 15/10/15.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPDownloadManager : NSObject

/**
 *  单例对象
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedManger;

/**
 *  添加下载任务
 *
 *  @param url <#url description#>
 */
- (void)addDownloadWithUrl:(NSURL *)url;

/**
 *  判断是否已经下载完成
 *
 *  @return <#return value description#>
 */
- (BOOL)isExistInDownloadFinishListsWithUrl:(NSURL *)url;

/**
 *  判断是否正在下载
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isExistInDownloadingListsWithUrl:(NSURL *)url;

/**
 *  获取下载完成列表
 *
 *  @return <#return value description#>
 */
- (NSArray *)downloadHaveFinishLists;

@end
