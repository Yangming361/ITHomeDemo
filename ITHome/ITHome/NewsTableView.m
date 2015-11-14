//
//  NewsTableView.m
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "NewsTableView.h"
#import "NewsCell.h"
#import "NewsModel.h"
@interface NewsTableView()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,weak) UIScrollView *scrollView;

@property(nonatomic,weak)UIView *headerView;

@property(nonatomic,weak) UIPageControl *pageControl;


@end
@implementation NewsTableView

-(void)setScrollDataArray:(NSArray *)scrollDataArray
{
    _scrollDataArray = scrollDataArray;
   
    [self refreshScrollView];
}

-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        
        CGFloat pageControlX = 220;
        CGFloat pageControlY = 135;
        CGFloat pageControlW = 90;
        CGFloat pageCopntolH = 10;
        
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(pageControlX,pageControlY, pageControlW, pageCopntolH)];
        
        [self.headerView addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

-(void)setDataArray:(NSArray *)dataArray
{
    if (self.isLoopScroll) {
         //当页面有滚动视图
        self.scrollView.frame = self.headerView.bounds;
    }
    _dataArray = dataArray;
    [_tableView reloadData];
    
}

-(UIView *)headerView
{
    if (_headerView == nil) {
        
        CGFloat headerX =0;
        CGFloat headerY =0;
        CGFloat headerW =self.frame.size.width;
        CGFloat headerH =150;
        
        UIView *headerView = [[UIView alloc] init];
         headerView.frame = CGRectMake(headerX, headerY, headerW, headerH);
        self.tableView.tableHeaderView = headerView;
        _headerView = headerView;
        
    }
    return _headerView;
}

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
     
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.backgroundColor = [UIColor purpleColor];
        [self.headerView addSubview:scrollView];
        _scrollView = scrollView;
        
    }
    return _scrollView;
}

- (void)refreshScrollView
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    double width = size.width;
    double height = 150;
    
    NSInteger count = self.scrollDataArray.count;
    
    //scrollView滚动图片的个数最大为6
    if (self.scrollDataArray.count>6) {
        
        count = 6;
    }
    
    for (int i=0; i<count; i++) {
        
        NewsModel *model = self.scrollDataArray[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*i, 0,width, height)];
        [imageView setImageWithURL:[NSURL URLWithString:model.image]];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 130, size.width, 20)];
        view.alpha = 0.5;
        view.backgroundColor = [UIColor blackColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 20)];
        titleLabel.font = [UIFont boldSystemFontOfSize:11];
        titleLabel.text = model.title;
        titleLabel.textColor = [UIColor whiteColor];
        [view addSubview:titleLabel];
        [imageView addSubview:view];
        
        [self.scrollView addSubview:imageView];
        
    }
  
    self.scrollView.contentSize = CGSizeMake(width * count, height);
    
     self.pageControl.numberOfPages = count;
}

+(id)newsTableView
{
   
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        
        int index = scrollView.contentOffset.x / scrollView.frame.size.width;
        self.pageControl.currentPage = index;
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NewsModel *model = self.dataArray[indexPath.row];
    
    //获得时间 2015-9-18 18:20:09
    NSString *postdateStr = model.postdate;
    
    NSRange range = [postdateStr rangeOfString:@" "];
    NSRange rangeTime = NSMakeRange(range.location+1, 5);
    NSString *timeStr = [postdateStr substringWithRange:rangeTime];
    
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.image]];
    cell.timeLabel.text = timeStr;
    cell.titleLabel.text = model.title;
    
    cell.hintLabel.text = model.hitcount;
    cell.commentLabel.text = model.commentcount;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return heightEx(80);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    [self.delegate newsTableViewDidSelectRow:self indexPath:indexPath];
    
}


-(void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame= newSuperview.bounds;
    self.tableView.frame = self.bounds;
    [self.tableView registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
   
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
