//
//  NewsModel.h
//  ITHome
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property(nonatomic,copy) NSString *newsid;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *postdate;
@property(nonatomic,copy) NSString *image;
@property(nonatomic,copy) NSString *hitcount;
@property(nonatomic,copy) NSString *commentcount;
@property(nonatomic,copy) NSString *tags;



//@property(nonatomic,copy) NSString *title;
//
@property(nonatomic,copy) NSString *link;
//
//@property(nonatomic,copy) NSString *image;

@end
