//
//  NewsDetailView.m
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "NewsDetailView.h"
#import "NewsModel.h"
#import "NewsDetailModel.h"
@interface NewsDetailView ()<UIScrollViewDelegate,UIWebViewDelegate>

@property(nonatomic,weak) UIScrollView *scrollView;

@property(nonatomic,weak) UIWebView *webView;

@property(nonatomic,weak) UIView *topHintView;

@property(nonatomic,weak) UILabel *titleLabel;

@property(nonatomic,weak) UILabel *postDateLabel;

@property(nonatomic,weak) UILabel *sourceLabel;

@property(nonatomic,weak) UILabel *editLabel;

@property(nonatomic,weak) UIButton *commandButton;


@end

@implementation NewsDetailView

-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
        CGFloat lbX = 0;
        CGFloat lbY = 0;
        CGFloat lbW = self.width;
        CGFloat lbH = self.topHintView.frame.size.height/2;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(lbX, lbY, lbW, lbH)];
        titleLabel.numberOfLines = 0;
        [self.topHintView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)postDateLabel
{
    if (_postDateLabel == nil) {
        
        CGFloat lbX = 0;
        CGFloat lbY = 0;
        CGFloat lbW = 80;
        CGFloat lbH = self.topHintView.frame.size.height/2;
        
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(lbX, lbY, lbW, lbH)];
        [self.topHintView addSubview:dateLabel];
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.textColor = [UIColor lightGrayColor];
        _postDateLabel = dateLabel;
        
    }
    return _postDateLabel;
}

-(UILabel *)sourceLabel
{
    if (_sourceLabel == nil) {
     
        CGFloat lbX = 0;
        CGFloat lbY = 0;
        CGFloat lbW = 30;
        CGFloat lbH = self.topHintView.frame.size.height/2;
        
        UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(lbX, lbY, lbW, lbH)];
        sourceLabel.textColor = [UIColor lightGrayColor];
        sourceLabel.font = [UIFont systemFontOfSize:12];
        [self.topHintView addSubview:sourceLabel];
        _sourceLabel = sourceLabel;
    }
    return _sourceLabel;
}

-(UILabel *)editLabel
{
    if (_editLabel == nil) {
        
        CGFloat lbX = 0;
        CGFloat lbY = 0;
        CGFloat lbW = 30;
        CGFloat lbH = self.topHintView.frame.size.height/2;
        UILabel *editLabel = [[UILabel alloc] initWithFrame:CGRectMake(lbX, lbY, lbW, lbH)];
        editLabel.textColor = [UIColor lightGrayColor];
        editLabel.font = [UIFont systemFontOfSize:12];
        [self.topHintView addSubview:editLabel];
        _editLabel = editLabel;

    }
    return _editLabel;
}

-(UIButton *)commandButton
{
    if (_commandButton == nil) {
        
        CGFloat lbX = 0;
        CGFloat lbY = 0;
        CGFloat lbW = 30;
        CGFloat lbH = self.topHintView.frame.size.height/2;
        UIButton *commantButton = [UIButton buttonWithType:UIButtonTypeCustom];
        commantButton.frame = CGRectMake(lbX, lbY, lbW, lbH);
        
        [self.topHintView addSubview:commantButton];
        _commandButton = commantButton;
    }
    return _commandButton;
}

-(void)setNewsDetailModel:(NewsDetailModel *)newsDetailModel
{
    _newsDetailModel = newsDetailModel;
    
    NSString *htmlCSS = [NSString stringWithFormat:@"<body style='font-family : 微软雅黑,宋体;font-size:14;color:#0A0A0A;'>%@</body>",newsDetailModel.detail];
    [self.webView loadHTMLString:htmlCSS baseURL:nil];
}

-(void)setNewsModel:(NewsModel *)newsModel
{
    _newsModel = newsModel;
    
    
}

-(UIView *)topHintView
{
    if (_topHintView == nil) {
     
        UIView *topView = [[UIView alloc] init];
        [self.scrollView addSubview:topView];
        _topHintView = topView;
    }
    return _topHintView;
}

-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(UIWebView *)webView
{
    if (_webView == nil) {
        
        UIWebView *webView = [[UIWebView alloc] init];
        webView.delegate = self;
        [self.scrollView addSubview:webView];
        _webView = webView;
    }
    return _webView;
}
//将html里面的图片做缩放--适配手机屏幕
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    double width = _webView.frame.size.width - 10;
    NSString *js = [NSString stringWithFormat:@"var script = document.createElement('script');"
                    "script.type = 'text/javascript';"
                    "script.text = \"function ResizeImages() { "
                    "var myimg,oldwidth;"
                    "var maxwidth=%f;" //缩放系数
                    "for(i=0;i <document.images.length;i++){"
                    "myimg = document.images[i];"
                    "if(myimg.width > maxwidth){"
                    "oldwidth = myimg.width;"
                    "myimg.width = maxwidth;"
                    "myimg.height = myimg.height * (maxwidth/oldwidth)*2;"
                    "}"
                    "}"
                    "}\";"
                    "document.getElementsByTagName('head')[0].appendChild(script);",width];
    [_webView stringByEvaluatingJavaScriptFromString:js];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
}

+(id)newsDetailView
{
    return [[self alloc] init];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    self.frame = newSuperview.bounds;
  
    self.scrollView.frame = self.bounds;
     
    self.webView.frame= self.scrollView.bounds;
    self.webView.scrollView.frame = self.bounds;
    self.webView.backgroundColor = [UIColor lightGrayColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
