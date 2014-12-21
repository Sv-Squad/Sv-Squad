//
//  SQSTabBarButton.m
//  SVSQuad
//
//  Created by 周舟 on 19/12/14.
//  Copyright (c) 2014 zjuCom. All rights reserved.
//

#import "SQSTabBarButton.h"

@implementation SQSTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        //文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
    }
    return self;
}

#pragma mark - 设置按钮的文字，图片位置
//内部图片的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.6;
    return CGRectMake(0, 0, imageW, imageH);
    
}
//内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.6;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY - 3;
    
    return  CGRectMake(0, titleY, titleW, titleH);
    
}
@end
