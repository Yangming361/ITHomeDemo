//
//  DetailNewsViewController.m
//  ITHome
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "DetailNewsViewController.h"
#import "NewsDetailView.h"
#import "DownLoadNews.h"
@interface DetailNewsViewController ()<DownLoadNewsDelegate>

@property(nonatomic,weak) NewsDetailView *newsDetailView;

@property(nonatomic,strong) DownLoadNews *downLoadNews;

@property(nonatomic,copy) NSString *urlString;

@end

@implementation DetailNewsViewController

-(NSString *)urlString
{
    if (_urlString == nil) {
       // 178575
        
       //获取新闻详情url
        NSString *newsId = self.newsModel.newsid;
        NSString *str1 = [newsId substringToIndex:3];
        NSString *str2 = [newsId substringFromIndex:3];
        NSString *newStr = [NSString stringWithFormat:@"%@/%@",str1,str2];
        _urlString = [NSString stringWithFormat:NewsDetail_URL,newStr];
        
    }
    return _urlString;
}

-(DownLoadNews *)downLoadNews
{
    if (_downLoadNews == nil) {
        
        _downLoadNews = [[DownLoadNews alloc] init];
        _downLoadNews.delegate = self;
    }
    return _downLoadNews;
}

-(NewsDetailView *)newsDetailView
{
    if (_newsDetailView == nil) {
        
        NewsDetailView *newsDetailView = [[NewsDetailView alloc] init];
        [self.view addSubview:newsDetailView];
        newsDetailView.backgroundColor = [UIColor greenColor];
        _newsDetailView = newsDetailView;
        
    }
    return _newsDetailView;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.downLoadNews startDownLoadNewsDetailWithUrl:self.urlString];
    self.newsDetailView.newsModel = self.newsModel;

    
    
}

#pragma mark -DownLoadNewsDelegate-

-(void)downLoadNewsDidEndDownLoadNewsDetail
{
    self.newsDetailView.newsDetailModel = [self.downLoadNews.newsDetailArray firstObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}












/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
