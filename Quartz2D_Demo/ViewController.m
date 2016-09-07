//
//  ViewController.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "ViewController.h"

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
                                                          attribute:NSLayoutAttributeCenterY
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
