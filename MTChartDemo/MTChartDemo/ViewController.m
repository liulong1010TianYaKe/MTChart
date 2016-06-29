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
    barChartView.backgroundColor = [UIColor lightGrayColor];
//    barChartView
    [self.view addSubview:barChartView];
    [barChartView drawChart];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = CGRectMake(0, 0, 20, 200);
    gradientLayer.position = CGPointMake(60, 400-200);
    gradientLayer.anchorPoint = CGPointMake(0.5, 0);
    gradientLayer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor redColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    [self.view.layer addSublayer:gradientLayer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
