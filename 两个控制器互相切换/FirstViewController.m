//
//  FirstViewController.m
//  两个控制器互相切换
//
//  Created by 镇微 on 2017/8/9.
//  Copyright © 2017年 镇微. All rights reserved.
//

#import "FirstViewController.h"
#import "CommonHtml5Controller.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.htmlUrl = @"https://www.microtown.cn/appPage/recomPage1.jsp?fromAccount=1589790";
    
}
- (IBAction)btnClickd:(UIButton *)sender
{
    CommonHtml5Controller *h5VC = [[CommonHtml5Controller alloc] init];
    h5VC.htmlUrl = @"https://www.microtown.cn/appPage/recomPage1.jsp?fromAccount=1589790";
    [self.navigationController pushViewController:h5VC animated:YES];
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
