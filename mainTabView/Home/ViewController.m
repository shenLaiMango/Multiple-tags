//
//  ViewController.m
//  mainTabView
//
//  Created by YOU on 2017/1/5.
//  Copyright © 2017年 wws. All rights reserved.
//

#import "ViewController.h"
#import "HomeMainVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navigationItem.title = @"";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width / 2 , 50)];
    [button setTitle:@"开始" forState:UIControlStateNormal];
    [button setTitle:@"开始" forState:UIControlStateSelected];
    [button setCenter:self.view.center];
    [button addTarget:self action:@selector(TestAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:button];

    // Do any additional setup after loading the view, typically from a ni.
}
- (void)TestAction:(UIButton *)sender
{
    HomeMainVC *home = [[HomeMainVC alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
