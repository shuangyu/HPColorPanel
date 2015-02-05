//
//  HPColorPanelView.m
//  ColorPanel
//
//  Created by hupeng on 14-4-15.
//  Copyright (c) 2014年 hupeng. All rights reserved.
//

#import "HPColorPanelView.h"
@interface HPColorPanelView()
{
    UInt8 *_buffer;
    size_t _bytesPerRow;
}

- (void)analyseSourceImageView;

- (UIColor *)getColorAtPoint:(CGPoint)point;

@end

@implementation HPColorPanelView


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    
    if (_delegate && [_delegate respondsToSelector:@selector(colorPanelView:startSelectColor:atPoint:)]) {
        [_delegate colorPanelView:self startSelectColor:[self getColorAtPoint:touchPoint] atPoint:touchPoint];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    if (touchPoint.y > self.frame.size.height) {
        [self touchesEnded:touches withEvent:event];
        return;
    }

    if (_delegate && [_delegate respondsToSelector:@selector(colorPanelView:didSelectColor:atPoint:)]) {
        [_delegate colorPanelView:self didSelectColor:[self getColorAtPoint:touchPoint] atPoint:touchPoint];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    
    if (_delegate && [_delegate respondsToSelector:@selector(colorPanelView:endSelectColor:atPoint:)]) {
        [_delegate colorPanelView:self endSelectColor:[self getColorAtPoint:touchPoint] atPoint:touchPoint];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


- (id)initWithOriginPoint:(CGPoint)point
{
    CGRect frame = CGRectMake(point.x, point.y, 0, 0);
    return [self initWithFrame:frame];
}


- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!_colorSourceView) {
        _colorSourceView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_photos_color@2x.png"]];
    }
    _colorSourceView.frame = CGRectMake(0, 0, _colorSourceView.frame.size.width, _colorSourceView.frame.size.height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _colorSourceView.frame.size.width, _colorSourceView.frame.size.height);
    [self addSubview:_colorSourceView];
}

#pragma mark - private methods

- (UIColor *)getColorAtPoint:(CGPoint)point
{
    if (!_colorSourceView) {
        return nil;
    }
    
    // 做缓存节约内存
    if (!_buffer) {
        [self analyseSourceImageView];
    }
    
    UInt8* selectedBuffer;
    int y = point.y;
    int x = point.x;
    
    selectedBuffer = _buffer + y * _bytesPerRow + x * 4;
    
    UInt8 red,green,blue,alpha;
    red = *(selectedBuffer + 0);
    green = *(selectedBuffer + 1);
    blue = *(selectedBuffer + 2);
    alpha = *(selectedBuffer + 3);
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
}

- (void)analyseSourceImageView
{

    CGImageRef imageRef = _colorSourceView.image.CGImage;
    size_t bitsPerComponent;
    bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    
    size_t bitsPerPixel;
    bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    _bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace;
    colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitmapInfo;
    bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    bool shouldInterpolate;
    shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent;
    intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef dataProvider;
    dataProvider = CGImageGetDataProvider(imageRef);
    
    CFDataRef data;
    
    data = CGDataProviderCopyData(dataProvider);
    _buffer = (UInt8*)CFDataGetBytePtr(data);
}

@end
