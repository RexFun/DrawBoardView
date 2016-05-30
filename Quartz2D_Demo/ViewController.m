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
    
    // 画板
    self.drawboard = [[DrawBoard alloc] init];
    [self.view addSubview:self.drawboard];
    
    self.drawboard.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drawboard
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drawboard
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.9
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.drawboard
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    
    // 按钮-清屏
    self.btn_clear = [[UIButton alloc] init];
    [self.btn_clear setTitle:@"清屏" forState:UIControlStateNormal];
    [self.btn_clear setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btn_clear addTarget:self action:@selector(clearTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn_clear];
    
    self.btn_clear.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn_clear
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:0
                                                      constant:60]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn_clear
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:0
                                                      constant:40]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn_clear
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:0.5
                                                      constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn_clear
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.view
                                                     attribute:NSLayoutAttributeBottomMargin
                                                    multiplier:1
                                                           constant:0]];
    // 按钮-撤销
    self.btn_back = [[UIButton alloc] init];
    [self.btn_back setTitle:@"撤销" forState:UIControlStateNormal];
    [self.btn_back setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.btn_back addTarget:self action:@selector(backTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn_back];
    
    self.btn_back.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn_back
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:0
                                                           constant:60]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn_back
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0
                                                           constant:40]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn_back
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.btn_clear
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.btn_back
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1
                                                           constant:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) clearTap {
    [self.drawboard clear];
}

- (void) backTap {
    [self.drawboard back];
}
@end
