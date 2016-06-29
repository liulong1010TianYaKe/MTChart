//
//  MTBarChartView.m
//  MTChartDemo
//
//  Created by long on 6/29/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "MTBarChartView.h"


@interface MTBarChartView ()

@end


@implementation MTBarChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefualtValuse];
    }
    return self;
}

#pragma mark -------------------
#pragma mark - Private Method

- (void)setupDefualtValuse{
    _chartMarginTop = 10;
    _chartMarginBottom = 10;
    _maxBarYValue = self.bounds.size.height - _chartMarginBottom - _chartMarginTop;
    _barsProgress = @[];
}


/**
 *   添加柱状图
 */
- (void)addBarChart{
    
//    for (int i = 0; i < _barsProgress.count; i++) {
       CAGradientLayer *gradientLayer = [CAGradientLayer layer];
       CGFloat gradHeight = _maxBarYValue * 0.9;
       CGFloat gradWeiht = 20;
       CGFloat gradX = 0;
       CGFloat gradY = self.bounds.size.height - _chartMarginBottom;
       gradientLayer.bounds = CGRectMake(0, 0, gradWeiht, gradHeight);
       gradientLayer.anchorPoint = CGPointMake(0, 1);
       gradientLayer.position = CGPointMake(gradX,gradY);
       gradientLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor redColor].CGColor];
       gradientLayer.startPoint = CGPointMake(0.5, 0);
       gradientLayer.endPoint = CGPointMake(0.5, 1);
       [self.layer addSublayer:gradientLayer];

//    }
    
}

- (void)cleanupAllChart{
    
}

#pragma mark -------------------
#pragma mark - Public Method

/**
 *  绘制图形
 */
- (void)drawChart{
    
    [self cleanupAllChart];
    
    [self addBarChart];
    
}

@end
