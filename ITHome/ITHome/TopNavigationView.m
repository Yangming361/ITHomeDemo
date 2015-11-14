//
//  TopNavigationView.m
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "TopNavigationView.h"

@interface TopNavigationView ()

@property(nonatomic,weak)UIImageView *backImageView;
@property(nonatomic,weak) UIView *dropView;

@end

@implementation TopNavigationView

-(UIView *)dropView
{
    if (_dropView == nil) {
        
        UIView *dropView = [[UIView alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        imageView.image = [UIImage imageNamed:@"NavigationBar_BkImage_NoLogo@2x~iphone.png"];
        [dropView addSubview:imageView];
        
        UIButton *dropButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dropButton.frame =imageView.bounds;
        [dropButton setImage:[UIImage imageNamed:@"leveyTabBar_Edit@2x~iphone.png"] forState:UIControlStateNormal];
        [dropView addSubview:dropButton];
        
        [self addSubview:dropView];
        
        _dropView = dropView;
    }
    return _dropView;
}

-(UIImageView *)backImageView
{
    if (_backImageView == nil) {
        
        UIImageView *backImageView = [[UIImageView alloc] init];
        backImageView.image = [UIImage imageNamed:@"NavigationBar_BkImage_NoLogo@2x~iphone.png"];
        [self addSubview:backImageView];
        _backImageView = backImageView;
    }
    return _backImageView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
    }
    return _scrollView;
}

- (void)setLabTitles:(NSArray *)labTitles
{
    _labTitles = labTitles;
    
    [self addLabelIntoTopNavigationView];
}

//在topNavigationView添加标签
- (void)addLabelIntoTopNavigationView
{
    //向topNavigationView添加标签
    CGFloat lbWidth = 70;
    CGFloat lbHeight = self.scrollView.frame.size.height;
    for (int i =0; i<self.labTitles.count; i++) {
        UILabel *label = [self.scrollView addLabelWithFrame:CGRectMake(lbWidth*i, 5, lbWidth, lbHeight) title:self.labTitles[i]];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15];
        label.tag = i;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealLabelTap:)]];
        label.userInteractionEnabled = YES;
    }
    self.scrollView.contentSize = CGSizeMake(lbWidth *(self.labTitles.count+1), lbHeight);
    
}

- (void)dealLabelTap:(UITapGestureRecognizer *)tap
{
        [self.delegate topNavigationView:self tapLabelIndex:tap.view.tag];

}

+(id)topNavigationView
{
    return [[self alloc] init];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    CGFloat selfX = 0;
    CGFloat selfY = 20;
    CGFloat selfW = newSuperview.frame.size.width;
    CGFloat selfH = 50;
    
    self.userInteractionEnabled = YES;
    
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backImageView.frame = self.bounds;
    self.scrollView.frame = self.bounds;
    self.dropView.frame = CGRectMake(selfW-50, 0, 50, selfH);
    
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTopNavStatus:) name:@"ChangeTopNavStatus" object:nil];
    
    
}

- (void)changeTopNavStatus:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
   // NSLog(@"%@",dict);
    
    NSInteger index = [dict[@"index"] integerValue];
    
    //滚动标题栏
    UILabel *label = (UILabel *)self.scrollView.subviews[index];
    
    CGFloat offSetX = label.center.x - self.scrollView.frame.size.width * 0.5;
    CGFloat offSetMax = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    if (offSetX<0) {
        offSetX = 0;
    }else if(offSetX>offSetMax)
    {
        offSetX = offSetMax;
    }
    
    CGPoint offSet = CGPointMake(offSetX, self.scrollView.contentOffset.y);
    
    [self.scrollView setContentOffset:offSet animated:YES];
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UILabel *temlabel = self.scrollView.subviews[idx];
        if (idx != index) {
            
            temlabel.font = [UIFont systemFontOfSize:15];
        }else
        {
            temlabel.font = [UIFont systemFontOfSize:18];
        }
    }];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
