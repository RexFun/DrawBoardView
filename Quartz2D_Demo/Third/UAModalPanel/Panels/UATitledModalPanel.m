//
//  UAModalTitledDisplayPanelView.m
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UATitledModalPanel.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_TITLE_BAR_HEIGHT	44.0f


@interface UATitledModalPanelTitleView: UIView

@end


@implementation UATitledModalPanelTitleView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"StyNavBarBackgroundIOS6"]]];
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    CGSize size = self.bounds.size;
    // Drawing code
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(currentContext, 0, size.height);
    CGContextAddLineToPoint(currentContext, size.width, size.height);
    [[UIColor colorWithWhite:.78 alpha:1.0] set];
    CGContextSetLineWidth(currentContext, 1.0f);
    CGContextStrokePath(currentContext);
}

@end

@implementation UATitledModalPanel

@synthesize titleBarHeight, titleBar, headerLabel;

- (void)dealloc {
    self.titleBar = nil;
	self.headerLabel = nil;
//    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
		self.titleBarHeight = DEFAULT_TITLE_BAR_HEIGHT;
		
//		CGFloat colors[8] = { 1, 1, 1, 1, 0, 0, 0, 1 };
//		self.titleBar = [UANoisyGradientBackground gradientWithFrame:CGRectZero
//															   style:UAGradientBackgroundStyleLinear
//															   color:colors
//															lineMode:UAGradientLineModeTopAndBottom
//														noiseOpacity:0.2
//														   blendMode:kCGBlendModeNormal];
        
        self.titleBar = [[UATitledModalPanelTitleView alloc] initWithFrame:CGRectZero];
        
        
		
		[self.roundedRect addSubview:self.titleBar];
		self.headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		self.headerLabel.font = [UIFont systemFontOfSize:24];
		self.headerLabel.backgroundColor = [UIColor clearColor];
		self.headerLabel.textColor = [UIColor blackColor];
		self.headerLabel.shadowColor = [UIColor grayColor];
		self.headerLabel.shadowOffset = CGSizeMake(0, -1);
		self.headerLabel.textAlignment = NSTextAlignmentCenter;
		[self.titleBar addSubview:self.headerLabel];
        
    }
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//
//}



- (CGRect)titleBarFrame { 
	CGRect frame = [self.roundedRect bounds];
//	return CGRectMake(frame.origin.x,
//					  frame.origin.y + self.roundedRect.layer.borderWidth,
//					  frame.size.width,
//					  self.titleBarHeight - self.roundedRect.layer.borderWidth);
	return CGRectMake(frame.origin.x,
					  frame.origin.y,
					  frame.size.width,
					  self.titleBarHeight);
}


// overriding the subclass to make room for the title bar
- (CGRect)contentViewFrame {
	CGRect titleBarFrame = [self titleBarFrame];
	CGRect roundedRectFrame = [self roundedRectFrame];
	CGFloat y = titleBarFrame.origin.y + titleBarFrame.size.height;
//	CGRect rect = CGRectMake(self.outerMargin + self.innerMargin,
//							 self.outerMargin + self.innerMargin + y,
//							 roundedRectFrame.size.width - 2*self.innerMargin,
//							 roundedRectFrame.size.height - y - 2*self.innerMargin);
	CGRect rect = CGRectMake(self.outerMarginH + self.innerMargin,
							 self.outerMarginV + self.innerMargin + y,
							 roundedRectFrame.size.width - 2 * self.innerMargin,
							 roundedRectFrame.size.height - y - 2 * self.innerMargin);
	return rect;
}


- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.titleBar.frame = [self titleBarFrame];
    CGRect f = CGRectMake(self.titleBar.frame.origin.x, self.titleBar.frame.origin.y, self.titleBar.frame.size.width , self.titleBar.frame.size.height);
    self.headerLabel.frame = f;

//    self.headerLabel.frame = self.titleBar.bounds;
}


// Overrides

- (void)showAnimationStarting {
	self.contentView.alpha = 0.0;
	self.titleBar.alpha = 0.0;
}

- (void)showAnimationFinished {
	UADebugLog(@"Fading in content for modalPanel: %@", self);
	[UIView animateWithDuration:0.2
						  delay:0.0
     //options:UIViewAnimationCurveEaseIn
                        options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 self.contentView.alpha = 1.0;
						 self.titleBar.alpha = 1.0;
					 }
					 completion:nil];
}


@end
