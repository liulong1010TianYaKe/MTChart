//
//  MTBarChartView.h
//  MTChartDemo
//
//  Created by long on 6/29/16.
//  Copyright © 2016 long. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  柱子绘制方向
 */
typedef NS_ENUM(NSUInteger, MTBarChartViewDirectins) {
    /**
     *  向上绘制  底部对齐
     */
    MTBarChartViewDirectinsUP,
    /**
     *  向下绘制  顶部对齐
     */
    MTBarChartViewDirectinsDown,
    /**
     *  向左绘制  右部对齐
     */
    MTBarChartViewDirectinsLeft,
    /**
     *  向右绘制  左边对齐
     */
    MTBarChartViewDirectinsRight
};

@interface MTBarChartView : UIView

@property (nonatomic, strong) NSArray *barsPercent; /**< 每个柱长度百分比 值［0-1］柱的长度为 maxBarYValue＊barsPercent[i] 数组个数决定绘制柱子个数 */
@property (nonatomic, assign) CGFloat barRadius;   /**< 柱的圆角 */
@property (nonatomic, assign) CGFloat  barSpace;  /**< 柱与柱间的距离 */
@property (nonatomic, assign) CGFloat  barWidth;   /**< 柱的宽度 */
@property (nonatomic) CGFloat maxBarYValue;    /**<  柱图的最大高度 */
@property (nonatomic) CGFloat chartMarginLeft;  /**< 第一个柱子的与控件左边距 */
@property (nonatomic) CGFloat chartMarginRight;  /**< 第一个柱子的与控件右边距 */
@property (nonatomic) CGFloat chartMarginTop;    /**< 第一个柱子的与控件上边距 */
@property (nonatomic) CGFloat chartMarginBottom; /**< 第一个柱子的与控件下边距 */

/**
 *  CAGradientLayer  的颜色 绘制空间 normalBarColor selectBarColor 用(__bridge id)[UIColor greenColor].CGColor 颜色格式
 */
@property (nonatomic, strong) NSArray *normalBarColor;  /**<  柱子正常显示的颜色范围 */
@property (nonatomic, strong) NSArray *selectBarColor;  /**< 柱子选中时的颜色范围 */

@property (nonatomic, assign) CGFloat normalBarOpacity;  /**< 柱子正常显示的opacity 0-1 默认 0.7*/
@property (nonatomic, assign) CGFloat selectBarOpacity;  /**< 柱子正常显示的opacity 0-1 默认 1.0 */
@property (nonatomic,assign) NSInteger selectIndex;  /**< 标记选择了那个柱子  默认 -1 未选中*/
@property (nonatomic, strong) NSArray *barMarkTitleArray;  /**< 柱子上面标记文字 */
@property (nonatomic, assign) BOOL isShowBarMarkTitle;  /**< 是否显示标记本字 默认YES*/
@property (nonatomic, assign) CGFloat markTitleToBarDistance;  /**< 标记文字距离柱子顶部的距离 */
@property (nonatomic, strong) UIColor *barMarkTitleColor;  /**< 标记文字颜色 */
@property (nonatomic, strong) UIFont  *barMarkFont;       /**< 标记文字字体 */
@property (nonatomic, assign) BOOL  barUserInteractionEnabled;  /**< 柱子是否允许点击 */
@property (nonatomic, assign) MTBarChartViewDirectins mtBarChartViewDirction;  /**< 柱子绘制方向，默认 MTBarChartViewDirectinsUP */
/**
 *  坐标轴
 */

@property (nonatomic, assign) BOOL isShowAxisCenterTitle;  /**< 坐标轴中心是否显示文字 默认NO */
@property (nonatomic, strong) NSString *aXisCenterTitle;  /**< 坐标轴中心的文字 */
@property (nonatomic, assign) CGPoint  axisCenterTitlePoint;  /**< 坐标轴中心文字显示位置 */
@property (nonatomic, strong) UIColor *axisColor;  /**< 坐标轴的颜色 */
@property (nonatomic, assign) CGFloat axisLineWidth; /**< 坐标轴线宽 */
@property (nonatomic, assign) BOOL isShow_xAxis;  /**< 是否显示x轴, 默认YES 显示 */
@property (nonatomic, strong) NSArray *xTitleArray;   /**< x轴下的数组 */
@property (nonatomic, assign) CGFloat  xAxisTextGap;  /**< x轴文字与坐标轴的上边间隙 */
@property (nonatomic, strong) UIFont   *xAxisTextFont;  /**< x轴文字字体大小 */
@property (nonatomic, assign) UIColor  *xAxisTextColor;  /**< x轴文字颜色 */
@property (nonatomic, assign) UIColor  *xAxisMarkTextColor;  /**< x轴文字标记颜色 */
@property (nonatomic, assign) CGPoint  xAxisStartPoint; /**< x轴起点位置 */
@property (nonatomic, assign) CGPoint  xAxisEndPoint;   /**< x轴终点位置 */

@property (nonatomic, assign) BOOL isShow_yAxis;  /**< 是否显示y轴，默认NO 不显示 */
@property (nonatomic, strong) NSArray *yTitleArray;   /**< y轴下的数组 */
@property (nonatomic, assign) CGFloat  yAxisTextGap;  /**< y轴文字与坐标轴右边的间隙 */
@property (nonatomic, strong) UIFont   *yAxisTextFont;  /**< y轴文字字体大小 */
@property (nonatomic, assign) UIColor  *yAxisTextColor;  /**< y轴文字颜色 */
@property (nonatomic, assign) CGPoint  yAxisStartPoint; /**< y轴起点位置 */
@property (nonatomic, assign) CGPoint  yAxisEndPoint;   /**< y轴终点位置 */
@property (nonatomic, assign) CGFloat  yAxisTextDistance;  /**< y轴文件间的间距 */



/**
 *  版本
 */
-(NSString *)versions; 
/**
 *  绘制图形  注：每次绘制都需调用
 */
- (void)drawChart;

@end


@protocol MTBarChartViewDelegate <NSObject>

@optional
- (void)mtBarChartView:(MTBarChartView*)mtBarChartView didSelectBar:(NSInteger)selectIndex; /**< 点击选中了那个柱子 */
@end
