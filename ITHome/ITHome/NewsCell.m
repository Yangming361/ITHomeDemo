//
//  NewsCell.m
//  ITHome
//
//  Created by qianfeng on 15/9/18.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "NewsCell.h"
#import "ZJScreenAdaptationMacro.h"
@implementation NewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}


- (void)creatUI
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UIView *backView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    
    _iconImageView = [backView addImageViewWithFrame:CGRectMake(5, 5, 60, 60) image:nil];
    
    _titleLabel = [backView addLabelWithFrame:CGRectMake(70, 5,size.width-75 , 50) title:nil];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:17];
    
    _timeLabel = [backView addLabelWithFrame:CGRectMake(70, 55, 50, 15) title:nil];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    //添加hint图标
    [backView addImageViewWithFrame:CGRectMake(170, 55, 15, 15) image:@"iPhone_TableViewCell_Read@2x~iphone.png"];
    
    _hintLabel = [backView addLabelWithFrame:CGRectMake(190, 55, 30, 15) title:nil];
    _hintLabel.font = [UIFont systemFontOfSize:13];
    _hintLabel.textColor = [UIColor lightGrayColor];
    
    //添加comment图标
    [backView addImageViewWithFrame:CGRectMake(250, 55, 15, 15) image:@"iPhone_TableViewCell_Reply@2x~iphone.png"];
    
    _commentLabel = [backView addLabelWithFrame:CGRectMake(270, 55, 35, 15) title:nil];
    _commentLabel.font = [UIFont systemFontOfSize:13];
    _commentLabel.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:backView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
