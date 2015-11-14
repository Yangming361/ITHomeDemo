//
//  DownLoadNews.m
//  ITHome
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//

#import "DownLoadNews.h"
//"GDataXMLNode.h" 不能放在header.pch
#import "GDataXMLNode.h"
#import "NewsModel.h"
#import "NewsDetailModel.h"
@implementation DownLoadNews
+(id)downLoadNews
{
    return [[self alloc] init];
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(NSMutableArray *)scrollDataArray
{
    if (_scrollDataArray == nil) {
        
        _scrollDataArray = [[NSMutableArray alloc] init];
    }
    return _scrollDataArray;
}

- (NSMutableArray *)newsDetailArray
{
    if (_newsDetailArray == nil) {
        
        _newsDetailArray = [[NSMutableArray alloc] init];
    }
    return _newsDetailArray;
}

- (void)startDownLoadCellWithUrl:(NSString *)url;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseObject options:0 error:nil];
        NSArray *array = [doc nodesForXPath:@"//item" error:nil];
       // NSLog(@"array -- %ld",array.count);
        for (GDataXMLElement *e in array) {
            
            
            NSString *newsid =[[[e elementsForName:@"newsid"] firstObject] stringValue];
            
            NSString *title =[[[e elementsForName:@"title"] firstObject] stringValue];
            NSString *postdate =[[[e elementsForName:@"postdate"] firstObject] stringValue];
            NSString *image =[[[e elementsForName:@"image"] firstObject] stringValue];
            
            NSString *hitcount =[[[e elementsForName:@"hitcount"] firstObject] stringValue];
            NSString *commentcount =[[[e elementsForName:@"commentcount"] firstObject] stringValue];
            NSString *tags =[[[e elementsForName:@"tags"] firstObject] stringValue];
            
            NewsModel *model =[[NewsModel alloc] init];
            
            model.newsid = newsid;
            model.title = title;
            model.postdate = postdate;
            model.image = image;
            model.hitcount =hitcount;
            model.commentcount = commentcount;
            model.tags = tags;
            
            [self.dataArray addObject:model];
          
            
        }
        [self.delegate downLoadNewsDidEndDownLoadNewsCell];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

- (void)startDownLoadScrollViewWithUrl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseObject options:0 error:nil];
        NSArray *array = [doc nodesForXPath:@"//item" error:nil];
        for (GDataXMLElement *e in array) {
            
            NSString *link =[[[e elementsForName:@"link"] firstObject] stringValue];
            
            NSString *title =[[[e elementsForName:@"title"] firstObject] stringValue];
            NSString *image =[[[e elementsForName:@"image"] firstObject] stringValue];
            
            NewsModel *model =[[NewsModel alloc] init];
            
            model.title = title;
            model.link = link;
            model.image = image;
            
            [self.scrollDataArray addObject:model];
        }
        
        [self.delegate downLoadNewsDidEndDownLoadNewsScrollView];
        //NSLog(@"delegate %ld",self.scrollDataArray.count);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)startDownLoadNewsDetailWithUrl:(NSString *)url
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:responseObject options:0 error:nil];
        NSArray *array = [doc nodesForXPath:@"//item" error:nil];
        for (GDataXMLElement *e in array) {
            
            NSString *newssource =[[[e elementsForName:@"newssource"] firstObject] stringValue];
            NSString *newsauthor =[[[e elementsForName:@"newsauthor"] firstObject] stringValue];
            NSString *detail =[[[e elementsForName:@"detail"] firstObject] stringValue];
            NSString *edit =[[[e elementsForName:@"z"] firstObject] stringValue];
            NSString *tags =[[[e elementsForName:@"tags"] firstObject] stringValue];
            
            NewsDetailModel *model =[[NewsDetailModel alloc] init];
            model.newsauthor = newsauthor;
            model.newssource = newssource;
            model.detail = detail;
            model.edit = edit;
            model.tags = tags;
            
            [self.newsDetailArray addObject:model];
        }
       // NSLog(@"count ---%ld",self.newsDetailArray.count);
    [self.delegate downLoadNewsDidEndDownLoadNewsDetail];
            
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
