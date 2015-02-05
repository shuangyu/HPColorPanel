//
//  HPPopView.m
//  ColorPanel
//
//  Created by hupeng on 14-4-16.
//  Copyright (c) 2014年 hupeng. All rights reserved.
//

#import "HPPopView.h"
@interface HPPopView()

@property (weak, nonatomic) IBOutlet UIView *colorCell;

@end

@implementation HPPopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _colorCell.backgroundColor = backgroundColor;
}

@end
