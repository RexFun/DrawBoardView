//
//  PopView.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/7.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "PopView.h"

#define WEIGHT [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation PopView

NSDictionary* penAttPickerResult;

// setter
- (void)setDelegate:(id <PopViewDelegate>)_delegate {
    delegate = _delegate;
}
// getter
- (id <PopViewDelegate>)delegate {
    return delegate;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    self = [super init];
    if (self) {
        _curLineWidth = @"3";
        _curStrokeColor = [UIColor redColor];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
//        [self setFrame:CGRectMake(0, 0, WEIGHT, HEIGHT)];
        [self setHidden:YES];
        [self initCoreView];
    }
    return self;
}
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
////        [self setFrame:CGRectMake(0, 0, WEIGHT, HEIGHT)];
//        [self setHidden:YES];
//        [self initCoreView];
//    }
//    return self;
//}

- (void)initCoreView
{
    _coreView      = [[UIView alloc]init];
    _coreNorthView = [[UIView alloc]init];
    _coreSouthView = [[UIView alloc]init];
    
    [_coreView setBackgroundColor:[UIColor whiteColor]];
    [_coreView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [_coreView.layer setShadowOffset:CGSizeMake(10, 10)];
    [_coreView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    
    _lineWidths = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"细",@"title",@"3",@"val",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"中",@"title",@"6",@"val",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"粗",@"title",@"9",@"val",nil], nil];
    _strokeColors = [NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"红",@"title",[UIColor redColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"绿",@"title",[UIColor greenColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"蓝",@"title",[UIColor blueColor],@"val",nil], nil];

    _penAttPickerView = [[UIPickerView alloc]init];
    _penAttPickerView.delegate = self;
    _penAttPickerView.dataSource = self;
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelTap) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_confirmBtn setBackgroundColor:[UIColor whiteColor]];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmTap) forControlEvents:UIControlEventTouchUpInside];
    
    _southMidDividingLine  = [[UIView alloc]init];
    [_southMidDividingLine setBackgroundColor:[UIColor grayColor]];
    _southTopDividingLine  = [[UIView alloc]init];
    [_southTopDividingLine setBackgroundColor:[UIColor grayColor]];
    
    [_coreNorthView addSubview:_penAttPickerView];
    [_coreSouthView addSubview:_cancelBtn];
    [_coreSouthView addSubview:_confirmBtn];
    [_coreSouthView addSubview:_southMidDividingLine];
    [_coreSouthView addSubview:_southTopDividingLine];
    [_coreView addSubview:_coreNorthView];
    [_coreView addSubview:_coreSouthView];
    [self addSubview:_coreView];
    [self initConstraint];
}

- (void)initConstraint
{
    // coreView
    _coreView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.7
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.5
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    
    // coreNorthView
    _coreNorthView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreNorthView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreNorthView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.8
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreNorthView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreNorthView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0]];
    // coreNorthView_penAttPickView
    _penAttPickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_penAttPickerView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:-10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_penAttPickerView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1
                                                      constant:-10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_penAttPickerView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_penAttPickerView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    
    // coreSouthView
    _coreSouthView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreSouthView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreSouthView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.2
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreSouthView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreSouthView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreView
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
    // coreSouthView_cancelBtn
    _cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancelBtn
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.5
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancelBtn
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.99
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancelBtn
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_cancelBtn
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
    // coreSouthView_confirmBtn
    _confirmBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_confirmBtn
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0.5
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_confirmBtn
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.99
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_confirmBtn
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_confirmBtn
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
    // coreSouthView_southMidDividingLine
    _southMidDividingLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_southMidDividingLine
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:0.5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_southMidDividingLine
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.8
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_southMidDividingLine
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_southMidDividingLine
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];
    // coreSouthView_southTopDividingLine
    _southTopDividingLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_southTopDividingLine
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:-10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_southTopDividingLine
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:0.5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_southTopDividingLine
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_southTopDividingLine
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreSouthView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0]];
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 2; // 返回2表明该控件只包含2列
}

//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 如果该控件只包含一列，因此无须理会列序号参数component
    // 该方法返回teams.count，表明teams包含多少个元素，该控件就包含多少行
    if (component == 0) {
        return _lineWidths.count;
    }
    else
        return _strokeColors.count;
    
}

// UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 由于该控件只包含一列，因此无须理会列序号参数component
    // 该方法根据row参数返回teams中的元素，row参数代表列表项的编号，
    // 因此该方法表示第几个列表项，就使用teams中的第几个元素
    if (component == 0)
    {
        return [[_lineWidths objectAtIndex:row] objectForKey:@"title"];
    }
    return [[_strokeColors objectAtIndex:row] objectForKey:@"title"];
}


// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSArray *tmp = component == 0 ? _lineWidths: _strokeColors;
    if (component == 0)
    {
        _curLineWidth = [((NSDictionary*)[tmp objectAtIndex:row]) objectForKey:@"val"];
    }
    else
    {
        _curStrokeColor = [((NSDictionary*)[tmp objectAtIndex:row]) objectForKey:@"val"];
    }
}

#pragma UIPickerViewDelegate中定义的方法，该方法返回的NSString将作为
// UIPickerView中指定列的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return pickerView.bounds.size.width/2 - 5;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

// 离开view(停止触摸)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

- (void)show
{
    [self setHidden:NO];
}

- (void)hide
{
    [self setHidden:YES];
}

- (void)cancelTap
{
    [self hide];
}
- (void)confirmTap
{
    penAttPickerResult = [NSDictionary dictionaryWithObjectsAndKeys:_curLineWidth,@"lineWidth",_curStrokeColor,@"strokeColor",nil];
    [self.delegate getSelectedItems:penAttPickerResult];
    [self hide];
}
@end
