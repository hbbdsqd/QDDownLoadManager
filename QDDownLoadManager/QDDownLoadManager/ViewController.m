//
//  ViewController.m
//  QDDownLoadManager
//
//  Created by MS on 15/10/15.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "ViewController.h"
#import "HTTPDownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     调用addDownload:开始下载之前：
     1.判断是否下载完成。
     2.判断是否正在下载。
     */
    
    NSURL *url = [NSURL URLWithString:@"http://dl_dir.qq.com/qqfile/qq/QQforMac/QQ_V2.4.1.dmg"];
    
    if ([[HTTPDownloadManager sharedManger] isExistInDownloadFinishListsWithUrl:url])
    {
        //提示
        return;
    }
    
    //启动下载
    [[HTTPDownloadManager sharedManger] addDownloadWithUrl:url];
    
}

+ (void)aa
{
    
}

- (void)test
{
    [[self class] aa];
}

- (void)downloadButtonClick
{
    //    [[HTTPDownloadManager sharedManger] addDownloadWithUrl:(NSURL *)]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
