//
//  ViewController.m
//  两个控制器互相切换
//
//  Created by 镇微 on 2017/8/9.
//  Copyright © 2017年 镇微. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

/**
 *  是否是iPhone6的屏幕
 */
#define mt_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  是否是iPhone6_Plus的屏幕
 */
#define mt_iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  是否是iPhone4的屏幕
 */
#define mt_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  是否是iPhone5的屏幕
 */
#define mt_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 屏幕的宽高 */
#define kScreen [UIScreen mainScreen]
#define kScreenWidth kScreen.bounds.size.width
#define kScreenHeight kScreen.bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) UIViewController *fristVc;

@property (nonatomic, strong) UIViewController *secondVc;

@property (nonatomic, strong) UIViewController *currentVC;

@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.titleView = [self setupSegment];
    
    self.fristVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FirstViewController"];
    ((FirstViewController *)self.fristVc).htmlUrl = @"https://www.microtown.cn/appPage/recomPage1.jsp?fromAccount=1589790";
    self.fristVc.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    [self addChildViewController:_fristVc];
    
    self.secondVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SecondViewController"];
    self.secondVc.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    [self addChildViewController:_secondVc];
    
    //设置默认控制器为fristVc
    self.currentVC = self.fristVc;
    [self.view addSubview:self.fristVc.view];
}

/**
 *  初始化segmentControl
 */
- (UISegmentedControl *)setupSegment{
    NSArray *items = @[@"理财产品", @"核心企业"];
    UISegmentedControl *sgc = [[UISegmentedControl alloc] initWithItems:items];
    if (mt_iPhone4 || mt_iPhone5) {
        [sgc setWidth:60 forSegmentAtIndex:0];
        [sgc setWidth:60 forSegmentAtIndex:1];
        NSDictionary *dic = @{
                              //1.设置字体样式:例如黑体,和字体大小
                              NSFontAttributeName:[UIFont systemFontOfSize:11]};
        [sgc setTitleTextAttributes:dic forState:UIControlStateNormal];
    }else if (mt_iPhone6) {
        [sgc setWidth:70 forSegmentAtIndex:0];
        [sgc setWidth:70 forSegmentAtIndex:1];
    }else if (mt_iPhone6_Plus) {
        [sgc setWidth:80 forSegmentAtIndex:0];
        [sgc setWidth:80 forSegmentAtIndex:1];
    }
    
    //默认选中的位置
    sgc.selectedSegmentIndex = 0;
    //监听点击
    [sgc addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    return sgc;
}

- (void)segmentChange:(UISegmentedControl *)sgc{
    //NSLog(@"%ld", sgc.selectedSegmentIndex);
    self.index = sgc.selectedSegmentIndex;
    switch (sgc.selectedSegmentIndex) {
        case 0:
            [self replaceFromOldViewController:self.secondVc toNewViewController:self.fristVc];
            break;
        case 1:
            [self replaceFromOldViewController:self.fristVc toNewViewController:self.secondVc];
            break;
        default:
            break;
    }
}
/**
 *  实现控制器的切换
 *
 *  @param oldVc 当前控制器
 *  @param newVc 要切换到的控制器
 */
- (void)replaceFromOldViewController:(UIViewController *)oldVc toNewViewController:(UIViewController *)newVc{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController    当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options              动画效果(渐变,从下往上等等,具体查看API)UIViewAnimationOptionTransitionCrossDissolve
     *  animations            转换过程中得动画
     *  completion            转换完成
     */
    [self addChildViewController:newVc];
    [self transitionFromViewController:oldVc toViewController:newVc duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newVc didMoveToParentViewController:self];
            [oldVc willMoveToParentViewController:nil];
            [oldVc removeFromParentViewController];
            self.currentVC = newVc;
        }else{
            self.currentVC = oldVc;
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
