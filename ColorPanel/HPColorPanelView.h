//
//  HPColorPanelView.h
//  ColorPanel
//
//  Created by hupeng on 14-4-15.
//  Copyright (c) 2014年 hupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HPColorPanelView;

@protocol HPColorPanelViewProtocol <NSObject>

@optional
- (void)colorPanelView:(HPColorPanelView *)panel startSelectColor:(UIColor *)color atPoint:(CGPoint)point;
- (void)colorPanelView:(HPColorPanelView *)panel didSelectColor:(UIColor *)color atPoint:(CGPoint)point;
- (void)colorPanelView:(HPColorPanelView *)panel endSelectColor:(UIColor *)color atPoint:(CGPoint)point;

@end

@interface HPColorPanelView : UIView

@property (nonatomic, strong) UIImageView *colorSourceView;
@property (nonatomic, weak) id<HPColorPanelViewProtocol> delegate;

- (id)initWithOriginPoint:(CGPoint)point;

@end
