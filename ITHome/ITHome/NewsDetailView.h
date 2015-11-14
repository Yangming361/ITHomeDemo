//
//  NewsDetailView.h
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@class NewsDetailModel;
@interface NewsDetailView : UIView

@property(nonatomic,strong)NewsDetailModel *newsDetailModel;
@property(nonatomic,strong)NewsModel *newsModel;

+ (id)newsDetailView;

@end
