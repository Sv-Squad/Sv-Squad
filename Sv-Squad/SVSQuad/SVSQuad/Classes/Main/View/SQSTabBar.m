//
//  SQSTabBar.m
//  SVSQuad
//
//  Created by 周舟 on 19/12/14.
//  Copyright (c) 2014 zjuCom. All rights reserved.
//

#import "SQSTabBar.h"
#import "SQSTabBarButton.h"

@interface SQSTabBar()
@property (nonatomic, weak  ) SQSTabBarButton *selectedButton;
@property (nonatomic, strong) NSMutableArray  *tabBarButtons;
@property (nonatomic, weak  ) UIButton        *shootBtn;

@end


@implementation SQSTabBar

#pragma mark - Life cycle

-(NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //添加中间的shoot按钮
        UIButton *shootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shootBtn setImage:[UIImage imageNamed:@"tabbar_compose_shooting"] forState:UIControlStateNormal];
        [shootBtn setImage:[UIImage imageNamed:@"tabbar_compose_shooting"] forState:UIControlStateHighlighted];
        [shootBtn addTarget:self action:@selector(shootClick:) forControlEvents:UIControlEventTouchUpInside];
        shootBtn.bounds = CGRectMake(0, 0, 40, 40);
        [self addSubview:shootBtn];
        self.shootBtn = shootBtn;
        
        
    }
    
    return self;
}

#pragma mark - private Methods

- (void)shootClick:(UIButton *)button
{
    NSLog(@"--shooting");
    
}
/**
 *  添加底部Button，在MainTabVC中调用
 *
 *  @param item
 */
- (void)addButtonWithItems:(UITabBarItem *)item
{
   
    //1.创建按钮
    SQSTabBarButton *button = [[SQSTabBarButton alloc] init];
    [self addSubview:button];
    
    [self setupButton:button WithItem:item];
    //添加点击监听事件
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //2.添加到数组中
    [self.tabBarButtons addObject:button];
    
    //3.默认第一个选中第一个按钮
    if(self.tabBarButtons.count == 1)
    {
        [self buttonClick:button];
    }
}
/**
 *  设置SQSTabBarButton的图片和文字内容
 *
 *  @param button
 *  @param item   VC中的UITabBarItem
 */
- (void)setupButton:(SQSTabBarButton *)button WithItem:(UITabBarItem *)item
{
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setTitle:item.title forState:UIControlStateSelected];
    
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
    
    
}
/**
 *  按钮点击事件，切换主界面VC
 *
 *  @param button
 */
- (void)buttonClick:(SQSTabBarButton *)button
{
    //1.代理执行
    if ([self.delegate respondsToSelector:@selector(tabBar:didselectedButtonFrom:to:)])
    {
        [self.delegate tabBar:self didselectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    //2.设置按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
}


#pragma mark - 调整位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    //1.
    
    CGFloat shootBtnW = self.shootBtn.frame.size.width;
    //基本坐标
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    CGFloat buttonH = h;
    CGFloat buttonW = (w - shootBtnW)  / _tabBarButtons.count;
    //2.设置shootBtn位置
    self.shootBtn.center = CGPointMake(w * 0.5, h * 0.5);
    NSLog(@"-- shootBtn:%@",self.shootBtn);
    for (int i = 0; i < self.tabBarButtons.count; i ++) {
        //1.取出按钮
        SQSTabBarButton *button = self.tabBarButtons[i];
        //2.设置按钮的frame
        CGFloat buttonX = i * buttonW;
        //跳过shootBtn
        if (i >0)
        {
            buttonX += shootBtnW;
        }
        button.frame = CGRectMake(buttonX, 0, buttonW, buttonH);

        //3.
        button.tag = i;
    }

}


@end
