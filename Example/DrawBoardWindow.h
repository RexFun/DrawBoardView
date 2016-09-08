//
//  DrawBoardWindow.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/9/5.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UATitledModalPanel.h"
#import "DrawBoardView.h"

@interface DrawBoardWindow : UATitledModalPanel<UAModalPanelDelegate>
@property (nonatomic,strong)DrawBoardView* drawBoardView;
@end
