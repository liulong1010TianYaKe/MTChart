//
//  ViewController.m
//  MTChartDemo
//
//  Created by long on 6/29/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "ViewController.h"
#import "MTBarChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MTBarChartView *barChartView = [[MTBarChartView alloc] initWithFrame:CGRectMake(30, 50, self.view.bounds.size.width - 60, 350)];
    barChartView.backgroundColor = [UIColor cyanColor];
//    barChartView
    [self.view addSubview:barChartView];
    barChartView.chartMarginLeft = 50;
    barChartView.selectIndex = 4;
    barChartView.xTitleArray = @[@"周天",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    barChartView.yTitleArray = @[@"SUM",@"MON",@"TUE",@"WEN",@"THU",@"FRI",@"SAT"];
    barChartView.barMarkTitleArray = @[@"2342",@"661",@"6322",@"983",@"9873",@"889",@"8821"];
    barChartView.isShowBarMarkTitle = YES;
    barChartView.markTitleToBarDistance = 15;
    [barChartView drawChart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
