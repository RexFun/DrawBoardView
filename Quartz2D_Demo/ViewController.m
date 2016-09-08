//
//  ViewController.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "ViewController.h"
// 宏 rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 数字签名按钮
    self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btn setBackgroundColor:[UIColor whiteColor]];
    [self.btn setTitle:@"数字签名" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(digitSignTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    self.btn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0
                                                           constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0
                                                           constant:50]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:100]];
    
    //图像
    self.imgView = [[UIImageView alloc] init];
    //添加边框
    self.imgView.layer.borderWidth = 5.0F;
    self.imgView.layer.borderColor = UIColorFromRGB(0x66B3FF).CGColor;
    //添加四个边阴影
    self.imgView.layer.shadowColor = UIColorFromRGB(0x66B3FF).CGColor;//阴影颜色
    self.imgView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    self.imgView.layer.shadowOpacity = 0.5;//不透明度
    self.imgView.layer.shadowRadius = 10.0;//半径
    [self.view addSubview:self.imgView];
    self.imgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0.5
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.5
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imgView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.btn
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)digitSignTap
{
    NSLog(@"显示画板...");
    if (self.drawBoardWindow == nil)
    {
        self.drawBoardWindow = [[DrawBoardWindow alloc] init];
        self.drawBoardWindow.drawBoardView.drawBoard.delegate = self;
        [self.drawBoardWindow setShouldBounce:NO];
    }
    [self.view addSubview:self.drawBoardWindow];
    self.drawBoardWindow.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drawBoardWindow
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drawBoardWindow
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drawBoardWindow
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drawBoardWindow
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    [self.drawBoardWindow show];
}

#pragma mark - 画板代理
- (void) afterSave
{
    NSLog(@"点击保存后清屏...");
    [self.drawBoardWindow.drawBoardView clearTap];
    [self.drawBoardWindow hide];
}
- (void) getCurSavedImage:(UIImage*)image
{
    [self.imgView setImage:image];
}

#pragma mark - 弹出框代理
- (void)willShowModalPanel:(UAModalPanel *)modalPanel
{
    
}

- (void)didShowModalPanel:(UAModalPanel *)modalPanel
{
    
}

- (BOOL)shouldCloseModalPanel:(UAModalPanel *)modalPanel
{
    return YES;
}

- (void)willCloseModalPanel:(UAModalPanel *)modalPanel
{
    
}

- (void)didCloseModalPanel:(UAModalPanel *)modalPanel
{
    
}
@end
