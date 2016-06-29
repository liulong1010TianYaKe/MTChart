//
//  MTBarChartView.h
//  MTChartDemo
//
//  Created by long on 6/29/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTBarChartView : UIView



@property (nonatomic, strong) NSArray *barsProgress;
@property (nonatomic, assign) CGFloat  barSpace;  /**< 柱与柱间的距离 */

@property (nonatomic) CGFloat maxBarYValue;    /**<  柱图的最大高度 */
@property (nonatomic) CGFloat chartMarginLeft;  /**< 图形左边距 */
@property (nonatomic) CGFloat chartMarginRight;  /**< 图形右边距 */
@property (nonatomic) CGFloat chartMarginTop;    /**< 图形上边距 */
@property (nonatomic) CGFloat chartMarginBottom; /**< 图形下边距 */

- (void)drawChart;

@end
