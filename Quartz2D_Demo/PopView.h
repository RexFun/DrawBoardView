//
//  PopView.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/7.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopViewDelegate<NSObject>
@required
- (void)getSelectedItems:(NSDictionary*)items;
@end

@interface PopView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    id <PopViewDelegate> delegate;
}
// setter
- (void)setDelegate:(id <PopViewDelegate>)_delegate;
// getter
- (id <PopViewDelegate>)delegate;

@property (nonatomic,strong) UIView* coreView;
@property (nonatomic,strong) UIView* coreNorthView;
@property (nonatomic,strong) UIView* coreSouthView;
@property (nonatomic,strong) UIButton* cancelBtn;
@property (nonatomic,strong) UIButton* confirmBtn;
@property (nonatomic,strong) UIView* southTopDividingLine;
@property (nonatomic,strong) UIView* southMidDividingLine;
@property (nonatomic,strong) UIPickerView* penAttPickerView;
@property (nonatomic,strong) NSArray* lineWidths;
@property (nonatomic,strong) NSArray* strokeColors;
@property (nonatomic,strong) id curLineWidth;
@property (nonatomic,strong) id curStrokeColor;

- (void)show;
- (void)hide;

@end
