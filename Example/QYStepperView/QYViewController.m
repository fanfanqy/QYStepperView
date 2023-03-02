//
//  QYViewController.m
//  QYStepperView
//
//  Created by fanfanqy on 03/02/2023.
//  Copyright (c) 2023 fanfanqy. All rights reserved.
//

#import "QYViewController.h"
#import "QYStepperView.h"
#import <Masonry/Masonry.h>

@interface QYViewController ()

@end

@implementation QYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    QYStepperView *view = [[QYStepperView alloc]initWithFrame:CGRectMake(100, 100, 120, 30)];
    [view obtainTextPlaceholder:@"" minValue:@"1" maxValue:@"6" stepValue:@"1" keyboardType:UIKeyboardTypeNumberPad];
    
    // 自定义UI
//    view.writeTextContainerView.layer.borderWidth = 0.5;
//    view.writeTextContainerView.layer.borderColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0].CGColor;
//    view.writeTextContainerView.layer.cornerRadius = 4;
//
//    view.decreaseButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//    view.increaseButton.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
//
//    view.writeText.font = [UIFont systemFontOfSize:14];
//    view.writeText.textColor = [UIColor colorWithRed:61/255.0 green:61/255.0 blue:61/255.0 alpha:1.0];
//    [view.decreaseButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@25);
//    }];
//    [view.increaseButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@25);
//    }];
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
