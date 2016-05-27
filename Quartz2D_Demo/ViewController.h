//
//  ViewController.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingBoardView.h"

@interface ViewController : UIViewController

@property (nonatomic,strong)DrawingBoardView *drawboard;
@property (nonatomic,strong)UIButton *btn_clear;

@end

