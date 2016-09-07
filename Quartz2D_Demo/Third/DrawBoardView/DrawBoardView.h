//
//  DrawBoardView.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/3.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawBoard.h"
#import "PopView.h"

@interface DrawBoardView : UIView<PopViewDelegate>

@property (nonatomic,strong)UIToolbar* tbar;
@property (nonatomic,strong)UIToolbar* bbar;
@property (nonatomic,strong)DrawBoard* drawBoard;
@property (nonatomic,strong)PopView* popView;
@property (nonatomic,strong)UIActivityIndicatorView* activityIndicator;

- (id)initWithTbarItemsSwitch:(NSArray*)tbarItemsSwitch;
- (id)initWithFrame:(CGRect)frame tbarItemsSwitch:(NSArray*)tbarItemsSwitch;
@end
