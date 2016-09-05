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
    self.drawBoardView = [[DrawBoardView alloc] init];
    [self.contentView addSubview:self.drawBoardView];
    
    self.drawBoardView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.drawBoardView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.drawBoardView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.drawBoardView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.drawBoardView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.contentView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
}

@end
