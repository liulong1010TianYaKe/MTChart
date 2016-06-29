//
//  MTBar.m
//  MTChartDemo
//
//  Created by long on 6/29/16.
//  Copyright © 2016 long. All rights reserved.
//

#import "MTBar.h"

@implementation MTBar

+ (Class)layerClass{
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setup{
    CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
  
}
@end
