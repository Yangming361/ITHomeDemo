//
//  MainScrollView.m
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//


#import "MainScrollView.h"

@interface MainScrollView ()<UIScrollViewDelegate>



@end

@implementation MainScrollView

-(void)setControllerArray:(NSArray *)controllerArray
{
    _controllerArray = controllerArray;
}

//用来存放childerViewController
-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
       // scrollView.userInteractionEnabled = YES;
        scrollView.pagingEnabled=YES;
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
       // self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 8, self.scrollView.frame.size.height);
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(void)setFirstView:(UIView *)view num:(NSInteger)num
{
      self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * num, self.scrollView.frame.size.height);
    [self.scrollView addSubview:view];
}

+(id)mainScrollView
{
    return [[self alloc] init];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    CGFloat selfY = 70;
    CGFloat selfX = 0;
    CGFloat selfW = newSuperview.frame.size.width;
    CGFloat selfH =  newSuperview.frame.size.height-70-49;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.scrollView.frame = self.bounds;
}


#pragma mark -UIScrollViewDelegate方法-
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate mainScrollViewDidScroll:self scrollView:scrollView];
}
//scrollView停止滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self.delegate mainScrollViewDidEndScrollingAnimation:self scrollView:scrollView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
