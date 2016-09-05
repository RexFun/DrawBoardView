//
//  UAModalDisplayPanelView.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UARoundedRectView.h"

// Logging Helpers
#ifdef UAMODALVIEW_DEBUG
#define UADebugLog( s, ... ) NSLog( @"<%@:%d> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define UADebugLog( s, ... ) 
#endif

@class UAModalPanel;

@protocol UAModalPanelDelegate
@optional
- (void)willShowModalPanel:(UAModalPanel *)modalPanel;
- (void)didShowModalPanel:(UAModalPanel *)modalPanel;
- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel;
- (void)willCloseModalPanel:(UAModalPanel *)modalPanel;
- (void)didCloseModalPanel:(UAModalPanel *)modalPanel;
@end

typedef void (^UAModalDisplayPanelEvent)(UAModalPanel* panel);
typedef void (^UAModalDisplayPanelAnimationComplete)(BOOL finished);

@interface UAModalPanel : UIView {	
//	__unsafe_unretained NSObject<UAModalPanelDelegate>	*delegate;
	
	UIView		*_contentContainer;  
	UIView		*_roundedRect;       
	UIButton	*_closeButton;       
	UIView		*_contentView;       
	
	CGPoint		_startEndPoint;
	
	CGFloat		_outerMargin;        
	CGFloat		_innerMargin;
	UIColor		*_borderColor;
	CGFloat		_borderWidth;
	CGFloat		_cornerRadius;
	UIColor		*_contentColor;
	BOOL		_shouldBounce;
}

@property (nonatomic, weak) NSObject<UAModalPanelDelegate>	*delegate;

@property (nonatomic, retain) UIView		*contentContainer;  // 最下层容器
@property (nonatomic, retain) UIView		*roundedRect;       // 圆角容器
@property (nonatomic, retain) UIButton		*closeButton;       // 关闭按钮
@property (nonatomic, retain) UIView		*contentView;       // 在圆角容器上方

// Margin between edge of container frame and panel. Default = 20.0
@property (nonatomic, assign) CGFloat		outerMargin;        // roundedRect与contentContainer的间距（）
@property (nonatomic, assign) CGFloat       outerMarginH;       // 水平方向的边距（优先级大于outerMargin）
@property (nonatomic, assign) CGFloat       outerMarginV;       // 垂直方向的边跑（优先级大于outerMargin）
@property (nonatomic, assign) CGFloat       contentHeight;      // 内容视图的高度 (优先级大于outerMarginV)
// Margin between edge of panel and the content area. Default = 20.0
@property (nonatomic, assign) CGFloat		innerMargin;        // contentView与roundedRect的间距
// Border color of the panel. Default = [UIColor whiteColor]
@property (nonatomic, retain) UIColor		*borderColor;       // 边框的颜色
// Border width of the panel. Default = 1.5f
@property (nonatomic, assign) CGFloat		borderWidth;        // 边框的宽度
// Corner radius of the panel. Default = 4.0f
@property (nonatomic, assign) CGFloat		cornerRadius;       // roundedRect的圆角
// Color of the panel itself. Default = [UIColor colorWithWhite:0.0 alpha:0.8]
@property (nonatomic, retain) UIColor		*contentColor;      // 内容视图的背景颜色
// Shows the bounce animation. Default = YES
@property (nonatomic, assign) BOOL			shouldBounce;       // 是否需要回弹效果

@property (readwrite, copy)	UAModalDisplayPanelEvent onClosePressed;

- (void)show;
- (void)showFromPoint:(CGPoint)point;
- (void)hide;
- (void)hideWithOnComplete:(UAModalDisplayPanelAnimationComplete)onComplete;

- (CGRect)roundedRectFrame;
- (CGRect)closeButtonFrame;
- (CGRect)contentViewFrame;

@end
