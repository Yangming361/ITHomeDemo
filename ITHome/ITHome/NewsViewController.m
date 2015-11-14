//
//  NewsViewController.m
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

//
//  NewsViewController.m
//  ITHome
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "DetailNewsViewController.h"
#import "NewsTableView.h"
//"GDataXMLNode.h" 不能放在header.pch
#import "GDataXMLNode.h"
#import "DownLoadNews.h"
@interface NewsViewController ()<DownLoadNewsDelegate,NewsTableViewDelegate>


@property(nonatomic,weak)NewsTableView *newsTableView;

@property(nonatomic,strong) DownLoadNews *downLoadNews;

@end

@implementation NewsViewController

-(DownLoadNews *)downLoadNews
{
    if (_downLoadNews == nil) {
        
       _downLoadNews = [DownLoadNews downLoadNews];
        
        _downLoadNews.delegate = self;
    }
    return _downLoadNews;
}

-(NewsTableView *)newsTableView
{
    if (_newsTableView == nil) {
        
        NewsTableView *news = [NewsTableView newsTableView];
        news.delegate = self;
        [self.view addSubview:news];
        news.isLoopScroll = self.isLoopScroll;
        _newsTableView = news;
    }
    return _newsTableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

   
    [self.downLoadNews startDownLoadCellWithUrl:self.urlString];
    
   [self.downLoadNews startDownLoadScrollViewWithUrl:self.urlScrollLoop];
}

#pragma mark -NewsTableViewDelegate点击tableView中row的回调处理-
-(void)newsTableViewDidSelectRow:(NewsTableView *)newsTableView indexPath:(NSIndexPath *)indexPath
{
        DetailNewsViewController *dnvc = [[DetailNewsViewController alloc] init];
    
        NewsModel *model = newsTableView.dataArray[indexPath.row];
    
        dnvc.newsModel = model;
    
   
        UITableViewController *tvc = (UITableViewController *)[self parentViewController];
    
        [tvc.navigationController pushViewController:dnvc animated:YES];
}

#pragma mark -DownLoadNewsDelegate下载数据完成之后回调代理-

- (void)downLoadNewsDidEndDownLoadNewsCell
{
   self.newsTableView.dataArray = self.downLoadNews.dataArray;
   
}

- (void)downLoadNewsDidEndDownLoadNewsScrollView
{
    self.newsTableView.scrollDataArray = self.downLoadNews.scrollDataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

