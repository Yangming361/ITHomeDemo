//
//  NewsTableView.h
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsTableView;
@protocol NewsTableViewDelegate <NSObject>

- (void)newsTableViewDidSelectRow:(NewsTableView *)newsTableView indexPath:(NSIndexPath *)indexPath;

@end

@interface NewsTableView : UIView

@property(nonatomic,copy) NSArray *dataArray;
@property(nonatomic,copy)NSArray *scrollDataArray;
@property(nonatomic) BOOL isLoopScroll;
@property(nonatomic,weak) id <NewsTableViewDelegate> delegate;

+(id)newsTableView;

@end
