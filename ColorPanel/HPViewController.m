//
//  HPViewController.m
//  ColorPanel
//
//  Created by hupeng on 14-4-15.
//  Copyright (c) 2014年 hupeng. All rights reserved.
//

#import "HPViewController.h"
#import "HPColorPanelView.h"
#import "HPPopView.h"

@interface HPViewController ()<HPColorPanelViewProtocol>
{
    HPPopView *_popView;
}

@end

@implementation HPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
	HPColorPanelView *panel = [[HPColorPanelView alloc] initWithOriginPoint:CGPointMake(268, 20)];
    panel.delegate = self;
    [self.view addSubview:panel];
    
    _popView = [[[NSBundle mainBundle] loadNibNamed:@"HPPopView" owner:self options:nil] firstObject];
    _popView.hidden = true;
    [self.view addSubview:_popView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)colorPanelView:(HPColorPanelView *)panel didSelectColor:(UIColor *)color atPoint:(CGPoint)point
{
    _popView.hidden = false;
    _popView.backgroundColor = color;
    _popView.center = CGPointMake(253, point.y + panel.frame.origin.y);
}

- (void)colorPanelView:(HPColorPanelView *)panel startSelectColor:(UIColor *)color atPoint:(CGPoint)point
{
    _popView.hidden = false;
    _popView.backgroundColor = color;
    _popView.center = CGPointMake(253, point.y + panel.frame.origin.y);
}

- (void)colorPanelView:(HPColorPanelView *)panel endSelectColor:(UIColor *)color atPoint:(CGPoint)point
{
    _popView.hidden = true;
}

@end
