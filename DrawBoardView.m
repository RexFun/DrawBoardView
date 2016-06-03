//
//  DrawBoardView.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/3.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "DrawBoardView.h"

@implementation DrawBoardView

- (id)init
{
    self = [super init];
    if (self) {
        [self drawSubView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawSubView];
    }
    return self;
}

- (void) drawSubView
{
    // tbar
    NSMutableArray *tbarItems = [NSMutableArray array];
    [tbarItems addObject:[[UIBarButtonItem alloc]
                          initWithTitle:@"画笔"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(drawPenTap)]];
    [tbarItems addObject:[[UIBarButtonItem alloc]
                          initWithTitle:@"直线"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(drawLineTap)]];
    [tbarItems addObject:[[UIBarButtonItem alloc]
                          initWithTitle:@"圆形"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(drawCircularTap)]];
    [tbarItems addObject:[[UIBarButtonItem alloc]
                          initWithTitle:@"矩形"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(drawRectangleTap)]];
    _tbar = [[UIToolbar alloc] init];
    [_tbar setItems:tbarItems animated:YES];
    [self addSubview:_tbar];
    
    _tbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tbar
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tbar
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:35]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tbar
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tbar
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:30]];
    
    NSMutableArray *bbarItems = [NSMutableArray array];
    [bbarItems addObject:[[UIBarButtonItem alloc]
                          initWithTitle:@"清屏"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(clearTap)]];
    [bbarItems addObject:[[UIBarButtonItem alloc]
                          initWithTitle:@"撤销"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(backTap)]];
    
    // bbar
    _bbar = [[UIToolbar alloc] init];
    [_bbar setItems:bbarItems animated:YES];
    [self addSubview:_bbar];
    
    _bbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bbar
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bbar
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:35]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bbar
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bbar
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
    
    // drawBoard
    _drawBoard = [[DrawBoard alloc]init];
    [self addSubview:_drawBoard];
    
    _drawBoard.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_drawBoard
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_drawBoard
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_drawBoard
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_tbar
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_drawBoard
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_bbar
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0]];
}

- (void) drawPenTap
{
    _drawBoard.drawType = T_PEN;
}

- (void) drawLineTap
{
    _drawBoard.drawType = T_LINE;
}

- (void) drawCircularTap
{
    _drawBoard.drawType = T_CIRCULAR;
}

- (void) drawRectangleTap
{
    _drawBoard.drawType = T_RECT;
}

- (void) clearTap
{
    [_drawBoard clear];
}

- (void) backTap
{
    [_drawBoard back];
}
@end
