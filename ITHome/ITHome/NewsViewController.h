//
//  NewsViewController.h
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController

@property(nonatomic,copy) NSString *urlString;

@property(nonatomic,copy) NSString *urlScrollLoop;

@property(nonatomic) BOOL isLoopScroll;
@end
