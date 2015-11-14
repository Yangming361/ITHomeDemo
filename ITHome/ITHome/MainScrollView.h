//
//  MainScrollView.h
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainScrollView;

@protocol MainScrollViewDelegate <NSObject>

- (void)mainScrollViewDidScroll:(MainScrollView *)mainScrollView scrollView:(UIScrollView *)scrollView;




//滚动结束后调用-代码导致
- (void)mainScrollViewDidEndScrollingAnimation:(MainScrollView *)mainScrollView scrollView:(UIScrollView *)scrollView;
;

@end

@interface MainScrollView : UIView

@property(nonatomic,weak)UIScrollView *scrollView;

@property(nonatomic,copy) NSArray *controllerArray;

@property(nonatomic,weak) id<MainScrollViewDelegate> delegate;

+ (id)mainScrollView;

- (void)setFirstView:(UIView *)view num:(NSInteger )num;

@end
