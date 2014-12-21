//
//  SQSMainViewController.m
//  SVSQuad
//
//  Created by 周舟 on 19/12/14.
//  Copyright (c) 2014 zjuCom. All rights reserved.
//

#import "SQSMainViewController.h"
#import "SQSSquareViewController.h"
#import "SQSTabBar.h"
#import "SQSMineViewController.h"

@interface SQSMainViewController ()<SQSTabBarDelegate>

@property (nonatomic, weak) SQSSquareViewController *square;
@property (nonatomic, weak) SQSTabBar               *customTabBar;
@property (nonatomic, weak) SQSMineViewController   *mine;
@end

@implementation SQSMainViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置tabBar栏
    [self setupTabBar];
    //2.加载子controller
    [self setupAllChildViewControllers];
}
/**
 *  界面出现之前删除自带的tabBaritem
 *
 *  @param animated 
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    for (UIView *child in self.tabBar.subviews)
    {
       
        if ([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
}
#pragma mark - private Methods
#pragma mark - 设置tabBar栏
- (void)setupTabBar
{
    SQSTabBar *customTabBar = [[SQSTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    //TODO:添加代理
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

- (void)setupAllChildViewControllers
{
    //1.广场
    SQSSquareViewController *square = [[SQSSquareViewController alloc] init];
    square.title = @"广场";
    square.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    square.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_highlighted"];
    
    UINavigationController *nav_1 = [[UINavigationController alloc] initWithRootViewController:square];
    [self addChildViewController:nav_1];
    _square = square;
    [_customTabBar addButtonWithItems:square.tabBarItem];
    
    //2.我
    SQSMineViewController *mine = [[SQSMineViewController alloc] init];
    mine.title = @"我";
    mine.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    mine.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_highlighted"];
    
    UINavigationController *nav_2 = [[UINavigationController alloc] initWithRootViewController:mine];
    [self addChildViewController:nav_2];
    _mine = mine;
    [_customTabBar addButtonWithItems:mine.tabBarItem];
}

#pragma mark - SQSTabBar 代理方法
- (void)tabBar:(SQSTabBar *)tabBar didselectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
}

- (void)tabBarDidClickShootButton:(SQSTabBar *)tabBar
{
    NSLog(@"-- shoot");
}

@end
