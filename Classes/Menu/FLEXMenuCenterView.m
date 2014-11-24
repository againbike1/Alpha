//
//  FLEXMenuCenterView.m
//  UICatalog
//
//  Created by Dal Rupnik on 24/11/14.
//  Copyright (c) 2014 f. All rights reserved.
//

#import "FLEXMenuCenterView.h"

@interface FLEXMenuCenterView ()

@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation FLEXMenuCenterView

#pragma mark - Getters and setters

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)setSecondaryColor:(UIColor *)secondaryColor
{
    _secondaryColor = secondaryColor;
    
    self.imageView.tintColor = secondaryColor;
}

#pragma mark - UIView

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.mainColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.secondaryColor = [UIColor whiteColor];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.imageView = [[UIImageView alloc] initWithFrame:[self rectWithPaddingPercent:0.75]];
    self.imageView.userInteractionEnabled = NO;
    self.imageView.tintColor = self.secondaryColor;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:self.imageView];
}

- (CGRect)rectWithPaddingPercent:(CGFloat)paddingPercent
{
    CGRect rect = self.bounds;
    CGRect originalRect = self.bounds;
    
    CGFloat size = 1.0 - paddingPercent;
    
    rect.size.width *= size;
    rect.size.height *= size;
    
    CGFloat paddingX = (originalRect.size.width - rect.size.width) / 2.0;
    CGFloat paddingY = (originalRect.size.height - rect.size.height) / 2.0;
    
    rect.origin.x = paddingX;
    rect.origin.y = paddingY;
    
    return rect;
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = self.mainColor;
    UIColor* color2 = self.secondaryColor;
    
    //// Group
    {
        //// Oval Drawing
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.0, 0.0, rect.size.width, rect.size.height)];
        [color setFill];
        [ovalPath fill];
        
        
        CGFloat padding = (rect.size.width - (rect.size.width * 0.83)) / 2.0;
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(padding, padding, rect.size.width * 0.83, rect.size.height * 0.83)];
        [color2 setFill];
        [oval2Path fill];
        
        padding = (rect.size.width - (rect.size.width * 0.72)) / 2.0;
        
        
        //// Oval 3 Drawing
        UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(padding, padding, rect.size.width * 0.72, rect.size.height * 0.72)];
        [color setFill];
        [oval3Path fill];
    }
}

@end
