//
//  DrawBoardWindow.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/9/5.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "DrawBoardWindow.h"

@implementation DrawBoardWindow

- (id)init
{
    self = [super init];
    if (self) {
        [self initSubViews:CGRectZero];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews:frame];
    }
    return self;
}

- (void) initSubViews:(CGRect)frame
{
    // 设置 UAModelPanel 内外边距
    self.outerMarginV = 30;
    self.innerMargin = 10;
    // 初始化drawBoardView
    // 初始化方式1
//    self.drawBoardView = [[DrawBoardView alloc] init];
    // 初始化方式2
    // tbar 按钮开关组（1：显示；0：隐藏）（画笔、直线、圆形、矩形）；
    NSArray* tbarItemsSwitch = [NSArray arrayWithObjects:@"1",@"0",@"0",@"0",nil];
    _drawBoardView = [[DrawBoardView alloc] initWithTbarItemsSwitch:tbarItemsSwitch];
//    [_drawBoardView selectLineWidthAtIndex:2];
//    [_drawBoardView selectStrokeColorAtIndex:4];
    [self.contentView addSubview:_drawBoardView];
    // 布局drawBoardView
    self.drawBoardView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_drawBoardView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_drawBoardView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_drawBoardView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_drawBoardView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
}

@end
