//
//  NearVC.m
//  mainTabView
//
//  Created by YOU on 2017/1/5.
//  Copyright © 2017年 wws. All rights reserved.
//

#import "NearVC.h"

@interface NearVC ()

@end

@implementation NearVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 60, 30)];
    la.text =@"NearVC";
    [self.view addSubview:la];
    // Do any additional setup after loading the view.
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
