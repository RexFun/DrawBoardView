//
//  DrawBoardView.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/3.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawBoard.h"

@interface DrawBoardView : UIView

@property (nonatomic,strong)UIToolbar* tbar;
@property (nonatomic,strong)UIToolbar* bbar;
@property (nonatomic,strong)DrawBoard* drawBoard;

@end
