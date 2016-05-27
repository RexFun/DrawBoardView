//
//  Quartz2DView.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingBoardView : UIView
@property (nonatomic,strong)NSMutableArray *paths;

-(void)clearScreen;
@end
