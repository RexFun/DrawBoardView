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
        [self drawSubView:nil];
    }
    return self;
}
- (id)initWithTbarItemsSwitch:(NSArray*)tbarItemsSwitch
{
    self = [super init];
    if (self) {
        [self drawSubView:tbarItemsSwitch];
    }
    return self;
}

// initWithFrame
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawSubView:nil];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame tbarItemsSwitch:(NSArray*)tbarItemsSwitch
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawSubView:tbarItemsSwitch];
    }
    return self;
}

// drawSubView
- (void) drawSubView:(NSArray*)tbarItemsSwitch
{
    NSMutableArray *tbarItems = [NSMutableArray array];
    // tbar
    if(tbarItemsSwitch != nil)
    {
        if([[tbarItemsSwitch objectAtIndex:0] integerValue]==1)
        {
            [tbarItems addObject:[[UIBarButtonItem alloc]
                                  initWithTitle:@"画笔"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(drawPenTap)]];
        }
        if ([[tbarItemsSwitch objectAtIndex:1] integerValue]==1)
        {
            [tbarItems addObject:[[UIBarButtonItem alloc]
                                  initWithTitle:@"直线"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(drawLineTap)]];
        }
        if ([[tbarItemsSwitch objectAtIndex:2] integerValue]==1)
        {
            [tbarItems addObject:[[UIBarButtonItem alloc]
                                  initWithTitle:@"圆形"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(drawCircularTap)]];
        }
        if ([[tbarItemsSwitch objectAtIndex:3] integerValue]==1)
        {
            [tbarItems addObject:[[UIBarButtonItem alloc]
                                  initWithTitle:@"矩形"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(drawRectangleTap)]];
        }
    }
    else
    {
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
    }
    
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
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_popView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_popView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    
    // activityIndicator
    _activityIndicator = [[UIActivityIndicatorView alloc] init];
    _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityIndicator.hidesWhenStopped = YES;//停止后是否隐藏(默认为YES)
    [self addSubview:_activityIndicator];
    _activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicator
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:50]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicator
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:50]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicator
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicator
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    // 保存前弹窗
    _saveAlertView = [[UIAlertView alloc] initWithTitle:@"是否保存？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    // 重置为默认线宽和默认绘制颜色
    [self resetDefaultLineWidthAndStrokeColor];
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

# pragma 实现PopViewDelegate
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
    [_saveAlertView show];
}

- (void) selectLineWidthAtIndex:(int)index
{
    [_popView selectLineWidthAtIndex:index];
    [_drawBoard setLineWidth:[[_popView getSelectedLineWidth] floatValue]];
}

- (void) selectStrokeColorAtIndex:(int)index
{
    [_popView selectStrokeColorAtIndex:index];
    [_drawBoard setStrokeColor:[_popView getSelectedStrokeColor]];
}

- (void) resetDefaultLineWidthAndStrokeColor
{
    [self selectLineWidthAtIndex:0];
    [self selectStrokeColorAtIndex:0];
}

# pragma 实现UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.activityIndicator startAnimating];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            [_drawBoard save];
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                [self.activityIndicator stopAnimating];
            });
        });
    }
}
@end
