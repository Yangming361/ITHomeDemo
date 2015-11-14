//
//  NewsCell.h
//  ITHome
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell


@property(nonatomic,strong) UIImageView *iconImageView;

@property(nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UILabel *hintLabel;

@property(nonatomic,strong) UILabel *commentLabel;


@end
