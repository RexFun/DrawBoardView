//
//  DrawToolPickerView.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/3.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawToolPickerView : UIAlertView <UIPickerViewDataSource, UIPickerViewDelegate>

@property NSArray* thicks;
@property NSArray* colors;
@property (nonatomic,strong) UIPickerView* picker;
@property int selectedThick;
@property int selectedColor;

@end
