//
//  MTBarChartView.m
//  MTChartDemo
//
//  Created by long on 6/29/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "MTBarChartView.h"

#define MTBarChartViewHeight  (self.bounds.size.height)
#define MTBarChartViewWidth   (self.bounds.size.width)

@interface MTBarChartView ()

@property (nonatomic, strong) NSMutableArray *gradientBarArrays; // bars CAGradientLayer

@property (nonatomic, strong) CAShapeLayer *xLayer; // x轴
@property (nonatomic, strong) CAShapeLayer *yLayer;  // y轴

@property (nonatomic, strong) NSMutableArray *xTextLayers;  // x轴 下的文本CATextLayer

@property (nonatomic, strong) NSMutableArray *yTextLayers;  // y轴 边的文本CATextLayer

@property (nonatomic, strong) CALayer *markTextLayer;  //标记文字
@property (nonatomic, strong) CALayer *markContainerLayer;
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

-(NSString *)versions{
    return @"V1.0.0";
}
#pragma mark -------------------
#pragma mark - Private Method

- (void)setupDefualtValuse{
    _chartMarginTop = 50;
    _chartMarginBottom = 50;
    _chartMarginLeft = 50;
    _chartMarginRight = 50;
    _mtBarChartViewDirction = MTBarChartViewDirectinsUP;
    _maxBarYValue = MTBarChartViewHeight - _chartMarginTop - _chartMarginBottom;
    _normalBarOpacity = 0.6;
    _selectBarOpacity = 1.0;
    _selectIndex = -1;
    _normalBarColor = @[(__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor redColor].CGColor];
    _selectBarColor = @[(__bridge id)[UIColor orangeColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
    _barSpace = 20;
    _barWidth = 15;
    _barsPercent = @[@0.3,@0.6,@0.7,@0.5,@0.9,@0.5,@0.2];
    
    _gradientBarArrays = [NSMutableArray array];
    _xTextLayers = [NSMutableArray array];
    _yTextLayers = [NSMutableArray array];
    
    _isShow_xAxis = YES;

    _axisColor = [UIColor magentaColor];
    _axisLineWidth = 2.0f;
    _xAxisStartPoint = CGPointMake(30,  MTBarChartViewHeight-_chartMarginBottom);
    _xAxisEndPoint = CGPointMake( MTBarChartViewWidth -  _xAxisStartPoint.x ,_xAxisStartPoint.y);
    _isShow_yAxis = YES;

    _yAxisStartPoint = _xAxisStartPoint;
    _yAxisEndPoint = CGPointMake(_yAxisStartPoint.x, 50);
    
    _xAxisTextFont = [UIFont systemFontOfSize:11];
    _xAxisTextColor = [UIColor whiteColor];
    _xAxisMarkTextColor = [UIColor orangeColor];
    _xAxisTextGap = 15;
    _yAxisTextColor = [UIColor redColor];
    _yAxisTextFont = _xAxisTextFont;
    _yAxisTextGap = 10;
    _yAxisTextDistance = 35;
    
    _isShowBarMarkTitle = NO;
    _barMarkFont = [UIFont systemFontOfSize:10];
    _barMarkTitleColor = [UIColor whiteColor];
    _markTitleToBarDistance = 15;
    
}


/**
 *   创建柱状图
 */
- (void)createBarChart{
    
    CGFloat gradX = 0;
    CGFloat gradY = MTBarChartViewHeight - _chartMarginBottom;
    for (int i = 0; i < _barsPercent.count; i++) {
       CAGradientLayer *gradientLayer = [CAGradientLayer layer];
       CGFloat barHeight = _maxBarYValue * [_barsPercent[i] floatValue];
       gradientLayer.bounds = CGRectMake(0, 0, _barWidth, barHeight);
       gradientLayer.anchorPoint = CGPointMake(0, 1);
       gradX = _chartMarginLeft + i*_barWidth + i*_barSpace;
       gradientLayer.position = CGPointMake(gradX,gradY);
       gradientLayer.colors = _normalBarColor;
       gradientLayer.startPoint = CGPointMake(0.5, 0);
       gradientLayer.endPoint = CGPointMake(0.5, 1);
       gradientLayer.opacity = _normalBarOpacity;
        if (i == _selectIndex) {
            gradientLayer.opacity = _selectBarOpacity;
            gradientLayer.colors = _selectBarColor;
        }
        
       [self.layer addSublayer:gradientLayer];
       [_gradientBarArrays addObject:gradientLayer];
    }
    
}

/**
 *  创建xy轴
 */
- (void)createAxisChart{
    // 创建x轴
    if (!_isShow_xAxis) {
        return;
    }
//    if(!_xLayer){
//        _xLayer =
//        [self.layer addSublayer:_xLayer];
//    }
    
    _xLayer = [CAShapeLayer layer];
    UIBezierPath *xPath = [UIBezierPath bezierPath];
    [xPath moveToPoint:_xAxisStartPoint];
    [xPath addLineToPoint:_xAxisEndPoint];
    _xLayer.path = xPath.CGPath;
    _xLayer.strokeColor = _axisColor.CGColor;
    _xLayer.lineWidth = _axisLineWidth;
    [self.layer addSublayer:_xLayer];
    
    // 创建y轴
    if(!_isShow_yAxis)
        return;
    if (!_yLayer) {
        _yLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_yLayer];
    }
    
//    [xPath moveToPoint:_yAxisStartPoint];
//    [xPath addLineToPoint:_yAxisEndPoint];
//    _xLayer.path = xPath.CGPath;
    UIBezierPath *yPath = [UIBezierPath bezierPath];
    [yPath moveToPoint:_yAxisStartPoint];
    [yPath addLineToPoint:_yAxisEndPoint];
    _yLayer.path = yPath.CGPath;
    _yLayer.strokeColor = _axisColor.CGColor;
    _yLayer.lineWidth = _axisLineWidth;
    
    
}

/**
 *  创建坐标轴周围显示文字
 */
- (void)createAxisTtiles{
    
    // x 轴方向的文字
    
    for (int i = 0; i < _xTitleArray.count; i++) {
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.foregroundColor = _xAxisTextColor.CGColor;
        if (i == _selectIndex) {
            textLayer.foregroundColor = _xAxisMarkTextColor.CGColor;
        }
        textLayer.string = _xTitleArray[i];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.font = (__bridge CFTypeRef _Nullable)(_xAxisTextFont.fontName);
        textLayer.fontSize = _xAxisTextFont.pointSize;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.bounds = CGRectMake(0, 0, 30, 16);
        if (_barsPercent.count > i) {
            CAGradientLayer *layer = _gradientBarArrays[i];
            textLayer.position = CGPointMake(layer.position.x+_barWidth/2, layer.position.y+_xAxisTextGap);
        }
        
        [self.layer addSublayer:textLayer];
        [_xTextLayers addObject:textLayer];
    }
    
    
    // y 轴方向的文字
    
    for (int i = 0; i < _yTitleArray.count; i++) {
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.foregroundColor = _yAxisTextColor.CGColor;

        textLayer.string = _yTitleArray[i];
        textLayer.font = (__bridge CFTypeRef _Nullable)(_yAxisTextFont.fontName);
        textLayer.fontSize = _yAxisTextFont.pointSize;
        textLayer.alignmentMode = kCAAlignmentCenter;
        textLayer.bounds = CGRectMake(0, 0, 30, 16);
  
        CGFloat  textLayerX = _yAxisStartPoint.x - _xAxisTextGap;
        CGFloat  textLayerY = _yAxisStartPoint.y - _yAxisTextDistance*(i+1);
        textLayer.position = CGPointMake(textLayerX, textLayerY);
        [self.layer addSublayer:textLayer];
        [_yTextLayers addObject:textLayer];
    }
}


/**
 *  清除所有绘图
 */
- (void)cleanupAllChart{
    
    
    for (CALayer *layer in _gradientBarArrays) {
        [layer removeFromSuperlayer];
    }
    
    [_gradientBarArrays removeAllObjects];
    
    for (CALayer *layer in _xTextLayers) {
        [layer removeFromSuperlayer];
    }
    [_xTextLayers removeAllObjects];
    
    for (CALayer *layer in _yTextLayers) {
        [layer removeFromSuperlayer];
    }
    [_yTextLayers removeAllObjects];
    
    [_markContainerLayer removeFromSuperlayer];
    [_markTextLayer removeFromSuperlayer];
    
    [_xLayer removeFromSuperlayer];
    [_xLayer removeFromSuperlayer];
    
}

/**
 *  创建标记文本
 */
- (void)createMarklayer{
    
    if (!_isShowBarMarkTitle) return;
    if (_selectIndex<0) {
        return;
    }
    
//    if(!_markTextLayer){
//        _markTextLayer = [CALayer layer];
//        [self.layer addSublayer:_markTextLayer];
//    }
    if (_barMarkTitleArray.count > _selectIndex&&_barsPercent.count > _selectIndex) {
     
        NSString *markTitle = _barMarkTitleArray[_selectIndex];
        CALayer *barLayer = _gradientBarArrays[_selectIndex];
        CGPoint point = CGPointMake(barLayer.position.x+_barWidth/2, barLayer.position.y - _maxBarYValue*[_barsPercent[_selectIndex] floatValue]-_markTitleToBarDistance);
        _markTextLayer = [CALayer layer];
        _markTextLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"mark_icon"].CGImage);
        _markTextLayer.bounds = CGRectMake(0, 0, 35, 20);
        _markTextLayer.position = point;
        [self.layer addSublayer:_markTextLayer];
        CATextLayer *textLayer = [CATextLayer layer];
        textLayer.string = markTitle;
        textLayer.bounds = CGRectMake(0, 0, 30, 16);
        textLayer.position = _markTextLayer.position;
        textLayer.foregroundColor = _barMarkTitleColor.CGColor;
        textLayer.font = (__bridge CFTypeRef _Nullable)(_barMarkFont.fontName);
        textLayer.fontSize = _barMarkFont.pointSize;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.alignmentMode = kCAAlignmentCenter;
        [self.layer addSublayer:textLayer];
        _markContainerLayer = textLayer;
    }
   

}

#pragma mark -------------------
#pragma mark - Public Method

/**
 *  绘制图形
 */
- (void)drawChart{
    
    [self cleanupAllChart];
    
    [self createBarChart];
    
    [self createAxisChart];
    
    [self createAxisTtiles];
    
    [self createMarklayer];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self];
    
    CALayer *sublayer = [self.layer hitTest:touchPoint];
    
//    [self drawChart];
    if ([sublayer isKindOfClass:[CAGradientLayer class]]) {
        for (int i = 0; i < _gradientBarArrays.count; i++) {
            if ([sublayer isEqual:_gradientBarArrays[i]]) {
                _selectIndex = i;
                [self drawChart];
            }
        }
    }
}


@end
