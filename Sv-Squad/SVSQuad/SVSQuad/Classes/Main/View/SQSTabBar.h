//
//  SQSTabBar.h
//  SVSQuad
//
//  Created by 周舟 on 19/12/14.
//  Copyright (c) 2014 zjuCom. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQSTabBar;
@protocol SQSTabBarDelegate <NSObject>

- (void)tabBar:(SQSTabBar *)tabBar didselectedButtonFrom:(int)from to:(int)to;
- (void)tabBarDidClickShootButton:(SQSTabBar *)tabBar;

@end

@interface SQSTabBar : UIView
@property (nonatomic, weak) id<SQSTabBarDelegate> delegate;
- (void)addButtonWithItems:(UITabBarItem *)item;


@end
