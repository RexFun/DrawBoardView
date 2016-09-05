//
//  DrawBoardView.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/3.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "DrawBoardView.h"

@implementation DrawBoardView

// init
- (id)init
{
    self = [super init];
    if (self) {
        [self drawSubView];
    }
    return self;
}

// initWithFrame
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawSubView];
    }
    return self;
}

// drawSubView
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
    
    // bbar
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
    [bbarItems addObject:[[UIBarButtonItem alloc]
                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                          target:self
                          action:nil]];
    [bbarItems addObject:[[UIBarButtonItem alloc]
                          initWithTitle:@"保存"
                          style:UIBarButtonItemStylePlain
                          target:self
                          action:@selector(saveTap)]];
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
    // popView
    _popView = [[PopView alloc]init];
    _popView.delegate = self;
    [self addSubview:_popView];
    _popView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_popView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_popView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:0]];
}

- (void) drawPenTap
{
    _drawBoard.drawType = T_PEN;
    [_popView show];
}

- (void) drawLineTap
{
    _drawBoard.drawType = T_LINE;
    [_popView show];
}

- (void) drawCircularTap
{
    _drawBoard.drawType = T_CIRCULAR;
    [_popView show];
}

- (void) drawRectangleTap
{
    _drawBoard.drawType = T_RECT;
    [_popView show];
}

- (void)getSelectedItems:(NSDictionary *)items
{
    _drawBoard.lineWidth = [[items objectForKey:@"lineWidth"] floatValue];
    _drawBoard.strokeColor = [items objectForKey:@"strokeColor"];
}

- (void) clearTap
{
    [_drawBoard clear];
}

- (void) backTap
{
    [_drawBoard back];
}

- (void) saveTap
{
    [_drawBoard save];
}
@end
