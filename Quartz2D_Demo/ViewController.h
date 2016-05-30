//
//  ViewController.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawBoard.h"

@interface ViewController : UIViewController

@property (nonatomic,strong)DrawBoard *drawboard;
@property (nonatomic,strong)UIButton *btn_line;
@property (nonatomic,strong)UIButton *btn_circular;
@property (nonatomic,strong)UIButton *btn_rectangle;
@property (nonatomic,strong)UIButton *btn_clear;
@property (nonatomic,strong)UIButton *btn_back;

@end

