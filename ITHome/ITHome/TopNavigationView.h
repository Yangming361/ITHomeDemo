//
//  TopNavigationView.h
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopNavigationView;

@protocol TopNavigationViewDelegate <NSObject>

- (void)topNavigationView:(TopNavigationView *)topNavigationView tapLabelIndex:(NSInteger )index;

@end

@interface TopNavigationView : UIView

@property(nonatomic,weak) UIScrollView *scrollView;

@property(nonatomic,copy) NSArray *labTitles;

@property(nonatomic,weak) id <TopNavigationViewDelegate> delegate;

+(id)topNavigationView;

@end
