//
//  DownLoadNews.h
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DownLoadNews;
@protocol DownLoadNewsDelegate <NSObject>
@required
- (void)downLoadNewsDidEndDownLoadNewsCell;

- (void)downLoadNewsDidEndDownLoadNewsScrollView;

- (void)downLoadNewsDidEndDownLoadNewsDetail;

@end
@interface DownLoadNews : NSObject

@property(nonatomic,copy) NSMutableArray *dataArray;

@property(nonatomic,copy) NSMutableArray *scrollDataArray;

@property(nonatomic,copy) NSMutableArray *newsDetailArray;

@property(nonatomic,copy) NSString *urlString;

@property(nonatomic,weak) id <DownLoadNewsDelegate> delegate;

+ (id)downLoadNews;

- (void)startDownLoadCellWithUrl:(NSString *)url;

- (void)startDownLoadScrollViewWithUrl:(NSString *)url;

- (void)startDownLoadNewsDetailWithUrl:(NSString *)url;

@end
