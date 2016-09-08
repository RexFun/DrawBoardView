//
//  ViewController.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawBoardWindow.h"

@interface ViewController : UIViewController<UAModalPanelDelegate,DrawBoardDelegate>

@property (nonatomic,strong)UIButton* btn;
@property (nonatomic,strong)UIImageView* imgView;
@property (strong, nonatomic) DrawBoardWindow* drawBoardWindow;

@end

