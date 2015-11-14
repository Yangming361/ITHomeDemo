//
//  MainViewController.m
//  ITHome
//
//  Created by qianfeng on 15/9/17.
//  Copyright (c) 2015年 ahnu. All rights reserved.
//


#import "MainViewController.h"
#import "NewsViewController.h"
#import "MainScrollView.h"
#import "TopNavigationView.h"

@interface MainViewController ()<MainScrollViewDelegate,TopNavigationViewDelegate>

@property (nonatomic,copy) NSArray *loopScrollArray;
@property(nonatomic,copy) NSArray *urlArray;
@property(nonatomic,copy) NSArray *labTitles;
@property(nonatomic,strong) NSArray *array ;
@property(nonatomic,weak) MainScrollView *mainScrollView;
@property(nonatomic,weak)TopNavigationView *topNavigationView;



@end

@implementation MainViewController

-(MainScrollView *)mainScrollView
{
    if (_mainScrollView == nil) {
        
        //注意：设置scrollView避免上下滚动！！！！！！！
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        MainScrollView *mainScrollView = [MainScrollView mainScrollView];
        [self.view addSubview:mainScrollView];
        _mainScrollView = mainScrollView;
        mainScrollView.delegate = self;
    }
    return _mainScrollView;
}
//存放顶部滚动的Lable视图
- (TopNavigationView *)topNavigationView
{
    if(_topNavigationView == nil)
    {
        TopNavigationView *topNavigationView = [TopNavigationView topNavigationView];
        [self.view addSubview:topNavigationView];
        topNavigationView.labTitles = self.labTitles;
        topNavigationView.delegate = self;
        _topNavigationView = topNavigationView;
        
    }
    return _topNavigationView;
}

-(NSArray *)loopScrollArray
{
    if (_loopScrollArray == nil) {
     
        _loopScrollArray = @[LatestScroll_URL,@"",AndroidScroll_URL,@"",@"",AppleScroll_URL,WPScroll_URL,WindowsScroll_URL];
    }
    return _loopScrollArray;
}

-(NSArray *)urlArray
{
    if (_urlArray == nil) {
        
        _urlArray = @[Latest_URL,RankList_URL,Android_URL,Phone_URL,Digital_URL,Apple_URL,WP_URL,Windows_URL];
    }
    return _urlArray;
}

-(NSArray *)labTitles
{
    if (_labTitles == nil) {
        
        _labTitles = @[@"最新",@"排行榜",@"安卓",@"手机",@"数码",@"苹果",@"WP",@"Windows"];
    }
    return _labTitles;
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addControllers];
   
    //将第一个childViewController添加到mainScrollView.scrollView上
    UITableViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.mainScrollView.scrollView.bounds;
    [self.mainScrollView setFirstView:vc.view num:self.labTitles.count];
    //顶部默认选中第一个
    UILabel *label = [self.topNavigationView.scrollView.subviews firstObject];
    label.font = [UIFont systemFontOfSize:20];

    
}

#pragma mark - 添加子控制器

- (void)addControllers
{
    for (int i =0; i<self.labTitles.count; i++) {
        
        NewsViewController *nvc = [[NewsViewController alloc] init];
        nvc.title = self.labTitles[i];
        nvc.urlString = self.urlArray[i];
        nvc.isLoopScroll = YES;
        if ([self.loopScrollArray[i] isEqualToString:@""]) {
            nvc.isLoopScroll = NO;
        }
        nvc.urlScrollLoop = self.loopScrollArray[i];
        
        [self addChildViewController:nvc];
        
    }

}

#pragma mark -TopNavigationViewDelegate-

-(void)topNavigationView:(TopNavigationView *)topNavigationView tapLabelIndex:(NSInteger)index
{
    CGFloat offSetX = index * self.mainScrollView.scrollView.frame.size.width;
    
    CGFloat offSetY = self.mainScrollView.scrollView.contentOffset.y;
    
    CGPoint offSet = CGPointMake(offSetX, offSetY);
    
    [self.mainScrollView.scrollView setContentOffset:offSet animated:YES];
    
}

#pragma mark -MainScrollViewDelegate-

- (void)mainScrollViewDidScroll:(MainScrollView *)mainScrollView scrollView:(UIScrollView *)scrollView;

{
    CGFloat value = ABS(scrollView.contentOffset.x/mainScrollView.scrollView.contentSize.width);
    
    NSUInteger leftIndex = (NSInteger)value;
    UILabel *label = (UILabel *)self.topNavigationView.scrollView.subviews[leftIndex];
    
    label.font = [UIFont systemFontOfSize:20];
}


//mainScrollView停止滑动后调用-代码导致
- (void)mainScrollViewDidEndScrollingAnimation:(MainScrollView *)mainScrollView scrollView:(UIScrollView *)scrollView;

{
    //获得索引
    NSInteger index = scrollView.contentOffset.x / mainScrollView.scrollView.width;
   
    //向topNavigationView发送通知，改变第index标签的状态
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTopNavStatus" object:nil userInfo:@{@"index":[NSNumber numberWithInteger:index]}];
    
    
    //检查第index子控制器的View有没有加到主滚动视图
     NewsViewController *news = self.childViewControllers[index];
    if (news.view.superview)
        return;
    
    news.view.frame = mainScrollView.scrollView.bounds;
    
    [self.mainScrollView.scrollView addSubview:news.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
