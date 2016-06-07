//
//  DrawToolPickerView.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/3.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "DrawToolPickerView.h"

#define componentCount 2
#define thickComponent 0
#define colorComponent 1
#define thickComponentWidth 165
#define colorComponentWidth 70

@implementation DrawToolPickerView

- (id)init
{
    self = [super init];
    if (self) {
        [self drawSubView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawSubView];
    }
    return self;
}

- (id)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ...
{
    self = [super initWithTitle:title
                    message:message
                    delegate:delegate
                    cancelButtonTitle:cancelButtonTitle
                    otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        [self drawSubView];
    }
    return self;
}

- (void) drawSubView
{
    _thicks = [[NSArray alloc]initWithObjects:@"细", @"中", @"粗", nil];
    _colors = [[NSArray alloc]initWithObjects:@"红", @"橙", @"黄", @"绿", @"青", @"蓝", @"紫", nil];
    
    _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    _picker.showsSelectionIndicator = YES;
    _picker.delegate = self;
    _picker.dataSource = self;
    _picker.opaque = YES;
    
    [self addSubview:_picker];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return componentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == thickComponent) {
        return [_thicks count];
    } else {
        return [_colors count];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *printString;
    if (component == thickComponent) {
        printString = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, thickComponentWidth, 45)];
        printString.text = [_thicks objectAtIndex:row];
        [printString setFont:[UIFont fontWithName:@"Georgia" size:12.0f]];
    } else {
        printString = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, colorComponentWidth, 45)];
        printString.text = [_colors objectAtIndex:row];
    }
    printString.backgroundColor = [UIColor clearColor];
    printString.textAlignment = UITextAlignmentCenter;
    
    return printString;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == thickComponent) {
        return thickComponentWidth;
    } else {
        return colorComponentWidth;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedThick = [pickerView selectedRowInComponent:thickComponent];
    _selectedColor = [pickerView selectedRowInComponent:colorComponent];
}

- (void)setFrame:(CGRect)rect {
    [super setFrame:CGRectMake(0, 0, rect.size.width, 330)];
    self.center = CGPointMake(320/2, 480/2);
}

- (void)layoutSubviews {
    _picker.frame = CGRectMake(10, 45, self.frame.size.width - 52, self.frame.size.height - 50);
    for (UIView *view in self.subviews) {
        if ([[[view class] description] isEqualToString:@"UIThreePartButton"]) {
            view.frame = CGRectMake(view.frame.origin.x, self.bounds.size.height - view.frame.size.height - 15, view.frame.size.width, view.frame.size.height);
        }
    }
}
@end
