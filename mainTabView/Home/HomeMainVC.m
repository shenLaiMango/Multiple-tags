//
//  HomeMainVC.m
//  mainTabView
//
//  Created by YOU on 2017/1/5.
//  Copyright © 2017年 wws. All rights reserved.
//

#import "HomeMainVC.h"


#import "RecommendationsVC.h"
#import "SquareVC.h"
#import "NearVC.h"
@interface HomeMainVC ()<UIScrollViewDelegate>
{
    RecommendationsVC *recommendationsVc;
    SquareVC *squareVc;
    NearVC *nearVc;
    
    UIView *navView;
    UIScrollView *maincrollView;
    
    UILabel *lineLabel;
    UIButton *recommendationsButton;
    UIButton *squareButton;
    UIButton *nearButton;
}
/**
 *  控制跳转到某个tab的参数，默认为0，就是第一个tab
 */
@property (nonatomic , assign) NSInteger tagCurrentIndex;
@end

@implementation HomeMainVC

#pragma mark 
#pragma mark - 懒加载VC
- (RecommendationsVC *)recommendationsVc
{
    if (recommendationsVc == nil)
    {
        recommendationsVc = [[RecommendationsVC alloc]init];
    }
    return recommendationsVc;
}

- (SquareVC *)squareVc
{
    if (squareVc == nil)
    {
        squareVc = [[SquareVC alloc]init];
    }
    return squareVc;
}

- (NearVC *)nearVc
{
    if (nearVc == nil)
    {
        nearVc = [[NearVC alloc]init];
    }
    return nearVc;
}
#define SYScreenWidth ([UIScreen mainScreen].bounds.size.width - 30)
#pragma mark - 初始化UI
#pragma mark - 初始化 UIScrollView-UI
- (void)initScrollViewUI
{
 //scrollview
    maincrollView = [[UIScrollView alloc]init];
    [maincrollView setFrame:CGRectMake(0, 0, SYScreenWidth + 30, self.view.frame.size.height)];
//    [maincrollView setBackgroundColor:[UIColor yellowColor]];
    maincrollView.pagingEnabled = YES;
    maincrollView.delegate =self;
    [self.view addSubview: maincrollView];
    
    //VC
    NSArray *arraysVC = @[self.recommendationsVc.view,self.squareVc.view,self.nearVc.view];

    
    for (NSInteger i = 0; i < [arraysVC count]; i++)
    {
        //核心
        //三个VC的View放到maincrollView VC -->View --ScrollView
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake((SYScreenWidth+30) * i, 0,maincrollView.frame.size.width, maincrollView.frame.size.height)];
        [pageView addSubview:arraysVC[i]];
        [maincrollView addSubview:pageView];
    }
    maincrollView.contentSize = CGSizeMake((SYScreenWidth+30) * ([arraysVC count]), 0);
}
#pragma mark - 初始化 UIView-UI  button --> view --> navigationItem.titleView
- (void)initViewUI
{
    navView = [[UIView alloc]init];
    [navView setFrame:CGRectMake(0, 0, SYScreenWidth, 40)];
//    [navView setBackgroundColor:[UIColor purpleColor]];
    self.navigationItem.titleView = navView;
    NSLog(@"%f",self.navigationItem.titleView.frame.origin.x);
    
     //button 1
    recommendationsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [recommendationsButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [recommendationsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [recommendationsButton setFrame:CGRectMake(0, 0, SYScreenWidth / 3, navView.frame.size.height)];
    [recommendationsButton setTitle:@"附近" forState:UIControlStateNormal];
    [recommendationsButton.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    recommendationsButton.tag = 1;
    recommendationsButton.selected = YES;
    [recommendationsButton addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:recommendationsButton];
    
     //button 2
    squareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [squareButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [squareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [squareButton setFrame:CGRectMake(recommendationsButton.frame.origin.x + recommendationsButton.frame.size.width, recommendationsButton.frame.origin.y, SYScreenWidth / 3, navView.frame.size.height)];
    [squareButton setTitle:@"广场" forState:UIControlStateNormal];
    [squareButton.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    squareButton.tag = 2;
    squareButton.selected = YES;
    [squareButton addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:squareButton];
    
     //button 3
    nearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nearButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [nearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nearButton setFrame:CGRectMake(squareButton.frame.origin.x + squareButton.frame.size.width, squareButton.frame.origin.y, SYScreenWidth / 3, navView.frame.size.height)];
    [nearButton setTitle:@"推荐" forState:UIControlStateNormal];
    [nearButton.titleLabel setFont:[UIFont boldSystemFontOfSize:19]];
    nearButton.tag = 3;
    nearButton.selected = YES;
    [nearButton addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:nearButton];
    
    //line
    lineLabel = [[UILabel alloc]init];
    [lineLabel setFrame:CGRectMake(0, 40 - 2, SYScreenWidth / 3, 4)];
    [lineLabel setBackgroundColor:[UIColor redColor]];
    [navView addSubview:lineLabel];
}
#pragma mark -事件处理
- (void)sliderAction:(UIButton *)sender
{
    if (self.tagCurrentIndex == sender.tag)
    {
        //值相等就不走
        return;
    }
    
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        //切换scrollView到x位置 x 切换VC
        maincrollView.contentOffset = CGPointMake((SYScreenWidth+30)*(sender.tag-1), 0);
    }completion:^(BOOL finished) {
        
    }];
    
    //动画切换按钮
    [self TagAction:sender.tag];



}
//切换按钮
- (void)TagAction:(NSInteger )sender
{
    recommendationsButton.selected = NO;
    squareButton.selected = NO;
    nearButton.selected = NO;
    UIButton *senderButton = [self LabelAction:sender];
    senderButton.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
        //切换UIlabel
        lineLabel.frame = CGRectMake(senderButton.frame.origin.x, lineLabel.frame.origin.y, lineLabel.frame.size.width, lineLabel.frame.size.height);
    } completion:^(BOOL finished) {
        recommendationsButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        squareButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        nearButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        senderButton.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    }];
}
//切换视图绑定按钮
- (UIButton *)LabelAction:(NSInteger)tag
{
    if (tag == 1)
    {
        return recommendationsButton;
    }
    else if (tag == 2)
    {
        return squareButton;
    }
    else if (tag == 3)
    {
        return nearButton;
    }
    else
    {
        return nil;
    }
}

//滑动切换按钮
//滑动结束的时候获取
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    int index = contentOffSetX/(SYScreenWidth + 30) + 1;
    NSLog(@"%d",index);
    [self TagAction:index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViewUI];
    [self initScrollViewUI];
    //默认初始化按钮
    [self sliderAction:squareButton];
    // Do any additional setup after loading the view.
}



@end
