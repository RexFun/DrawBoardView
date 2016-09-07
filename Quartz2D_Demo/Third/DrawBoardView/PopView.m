//
//  PopView.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/6/7.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "PopView.h"

// 宏 rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define WEIGHT [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define SELECTOR_HEADER_H 30.0f
#define V_SPACING 20.0f // 上下间距
#define H_SPACING 20.0f // 左右间距

/*
 自定义单元格
 */
@implementation SelectorCell
- (id)init
{
    self = [super init];
    if (self) {
        [self initAttr];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAttr];
    }
    return self;
}

- (void) initAttr
{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.label.textColor = UIColorFromRGB(0x66B3FF);
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    //背景色
    self.contentView.backgroundColor = [UIColor whiteColor];
    //圆角
    self.layer.cornerRadius = 7;
    self.contentView.layer.cornerRadius = 7.0f;
    self.contentView.layer.borderWidth = 0.7f;
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    //阴影
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,2);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.4f;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
}

- (void) selectDone
{
    self.contentView.layer.borderWidth = 6.0f;
    self.contentView.layer.borderColor = UIColorFromRGB(0x66B3FF).CGColor;
}
- (void) deselectDone
{
    self.contentView.layer.borderWidth = 0.7f;
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
}
@end

/*
 自定义弹窗
 */
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

- (id)init
{
    self = [super init];
    if (self) {
        _curLineWidth = @"3";
        _curStrokeColor = [UIColor redColor];
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [self setHidden:YES];
        [self initCoreView];
    }
    return self;
}

- (void)initCoreView
{
    _coreView      = [[UIView alloc]init];
    _coreNorthView = [[UIView alloc]init];
    _coreSouthView = [[UIView alloc]init];
    
    [_coreView setBackgroundColor:[UIColor whiteColor]];
    [_coreView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [_coreView.layer setShadowOffset:CGSizeMake(10, 10)];
    [_coreView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    
    // 线宽数组
    _lineWidths = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:@"s1",@"title",@"3",@"val",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"s2",@"title",@"6",@"val",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"s3",@"title",@"9",@"val",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"s4",@"title",@"12",@"val",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"s5",@"title",@"15",@"val",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"s6",@"title",@"18",@"val",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:@"s7",@"title",@"21",@"val",nil], nil];
    // 颜色数组
    _strokeColors = [NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c1",@"title",[UIColor blackColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c2",@"title",[UIColor whiteColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c3",@"title",[UIColor redColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c4",@"title",[UIColor orangeColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c5",@"title",[UIColor yellowColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c6",@"title",[UIColor greenColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c7",@"title",[UIColor cyanColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c8",@"title",[UIColor magentaColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c9",@"title",[UIColor purpleColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c10",@"title",[UIColor grayColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c11",@"title",[UIColor lightGrayColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c12",@"title",[UIColor darkGrayColor],@"val",nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"c13",@"title",[UIColor brownColor],@"val",nil],
                     nil];

    // 选择器布局
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc ]init];
    flowLayout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc ]init];
    flowLayout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    flowLayout.headerReferenceSize = CGSizeMake(200, 50);

    // 线宽选择器
    _lineWidthSelector = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,0,0) collectionViewLayout:flowLayout1];
    _lineWidthSelector.backgroundColor = [UIColor whiteColor];
    [_lineWidthSelector registerClass:[SelectorCell class] forCellWithReuseIdentifier:@"cell"];//注册cell
//    [_lineWidthSelector registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];//注册header的view
    _lineWidthSelector.dataSource=self;
    _lineWidthSelector.delegate=self;
    // 颜色选择器
    _strokeColorSelector = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,0,0) collectionViewLayout:flowLayout2];
    _strokeColorSelector.backgroundColor = [UIColor whiteColor];
    [_strokeColorSelector registerClass:[SelectorCell class]forCellWithReuseIdentifier:@"cell"];//注册cell
//    [_strokeColorSelector registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];//注册header的view
    _strokeColorSelector.dataSource=self;
    _strokeColorSelector.delegate=self;
    // 取消按钮
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelTap) forControlEvents:UIControlEventTouchUpInside];
    // 确定按钮
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_confirmBtn setBackgroundColor:[UIColor whiteColor]];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(confirmTap) forControlEvents:UIControlEventTouchUpInside];
    // 分割线-竖向
    _southMidDividingLine  = [[UIView alloc]init];
    [_southMidDividingLine setBackgroundColor:[UIColor grayColor]];
    // 分割线-横向
    _southTopDividingLine  = [[UIView alloc]init];
    [_southTopDividingLine setBackgroundColor:[UIColor grayColor]];
    
    [_coreNorthView addSubview:_lineWidthSelector];
    [_coreNorthView addSubview:_strokeColorSelector];
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
    CGFloat _w = 0.0f;
    CGFloat _h = 0.0f;
    NSString *device = [[UIDevice currentDevice].model substringToIndex:4];
    if ([device isEqualToString:@"iPho"])// This is iPhone.
    {
        _w = 230.0f;
        _h = 230.0f;
    }
    else if ([device isEqualToString:@"iPad"])// This is iPad.
    {
        _w = 300.0f;
        _h = 300.0f;
    }
    // coreView
    _coreView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreView
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:nil
                                                    multiplier:0
                                                      constant:_w]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_coreView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:nil
                                                    multiplier:0
                                                      constant:_h]];
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
    // coreNorthView_lineWidthSelector
    _lineWidthSelector.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineWidthSelector
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:-10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineWidthSelector
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.5
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineWidthSelector
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineWidthSelector
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:5]];
    // coreNorthView_strokeColorSelector
    _strokeColorSelector.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_strokeColorSelector
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:-10]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_strokeColorSelector
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0.5
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_strokeColorSelector
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_strokeColorSelector
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_coreNorthView
                                                     attribute:NSLayoutAttributeBottom
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

#pragma mark- CollectionView Source Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if (collectionView == _lineWidthSelector)
    {
        num = _lineWidths.count;
    }
    else if (collectionView == _strokeColorSelector)
    {
        num = _strokeColors.count;
    }
    return num;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify=@"cell";
    SelectorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (collectionView == _lineWidthSelector)
    {
        cell.label.text = @"●";
        cell.label.font = [UIFont systemFontOfSize:[[[_lineWidths objectAtIndex:indexPath.row] objectForKey:@"val"] floatValue]*3];
        cell.val = [[_lineWidths objectAtIndex:indexPath.row] objectForKey:@"val"];
        if (_curLineWidthSelectedIndex == indexPath.row)
        {
            [cell selectDone];
        }
        else
        {
            [cell deselectDone];
        }
    }
    else if (collectionView == _strokeColorSelector)
    {
        cell.contentView.backgroundColor = [[_strokeColors objectAtIndex:indexPath.row] objectForKey:@"val"];
        cell.val = [[_strokeColors objectAtIndex:indexPath.row] objectForKey:@"val"];
        if (_curStrokeColorSelectedIndex == indexPath.row)
        {
            [cell selectDone];
        }
        else
        {
            [cell deselectDone];
        }
    }
    return cell;
}

#pragma mark- CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectorCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (collectionView == _lineWidthSelector)
    {
        _curLineWidth = cell.val;
        _curLineWidthSelectedIndex = indexPath.row;
    }
    else if (collectionView == _strokeColorSelector)
    {
        _curStrokeColor = cell.val;
        _curStrokeColorSelectedIndex = indexPath.row;
    }
    [collectionView reloadData];
}

#pragma mark- CollectionView Flow Delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width/3-H_SPACING, collectionView.bounds.size.width/3-H_SPACING);
}

/**
 * Section的上下左右边距--UIEdgeInsetsMake(上, 左, 下, 右);逆时针
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

/**
 * Section中每个Cell的上下边距
 */
- (CGFloat)collectionView: (UICollectionView *)collectionView layout: (UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex: (NSInteger)section
{
    return V_SPACING;
}

/**
 * Section中每个Cell的左右边距
 */
- (CGFloat)collectionView: (UICollectionView *)collectionView layout: (UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex: (NSInteger)section
{
    return H_SPACING;
}

/**
 * headerView的大小
 */
//- (CGSize)collectionView: (UICollectionView *)collectionView layout: (UICollectionViewLayout*)collectionViewLayout
//referenceSizeForHeaderInSection: (NSInteger)section
//{
//    return CGSizeMake(0, 30);
//}
//
//- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if (kind == UICollectionElementKindSectionHeader)
//    {//如果想要自定义header，只需要定义UICollectionReusableView的子类A，然后在该处使用，注意AIdentifier要设为注册的字符串，此处为“header”
//        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//        view.backgroundColor = [UIColor yellowColor];
//    return view;
//
//    }
//    return nil;
//}

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
