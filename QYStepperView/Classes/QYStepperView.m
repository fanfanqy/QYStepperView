//
//  TFCSNumberStepperView.m
//  TransfarShipper
//
//  Created by 范庆宇 on 2022/6/6.
//  Copyright © 2022 Transfar. All rights reserved.
//

#import "QYStepperView.h"
#import <Masonry/Masonry.h>
#import "NSString+QYStepperView.h"
#import "UITextField+TFCSNSLimitLength.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0x00FF0000) >> 16)) / 255.0     \
green:((float)((rgbValue & 0x0000FF00) >>  8)) / 255.0     \
blue:((float)((rgbValue & 0x000000FF) >>  0)) / 255.0     \
alpha:1.0]

#define FormPlaceHolderColor UIColorFromRGB(0xB9BEC3)

#define TFC_Font_Semibold(fontSize) [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize]
#define TFC_Font_Medium(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize]

#define isEmpty(string)  [NSString tfcs_ns_isEmpty:string]

@interface QYStepperView ()

@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, strong) NSString *maxValue;
@property (nonatomic, strong) NSString *stepValue;

@end

@implementation QYStepperView

- (instancetype)init{
    if (self = [super init]) {
        self.maxValue = @"99999999.999";
        [self creatUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

#pragma mark 公共方法
- (void)defaultState
{
    self.writeText.text = nil;
    self.decreaseButton.enabled = NO;
    self.increaseButton.enabled = YES;
    self.writeText.userInteractionEnabled = YES;
    self.writeTextContainerView.backgroundColor = [UIColor whiteColor];
    
}

- (void)disableState
{
    self.writeText.text = nil;
    self.decreaseButton.enabled = NO;
    self.increaseButton.enabled = NO;
    self.writeText.userInteractionEnabled = NO;
    self.writeTextContainerView.backgroundColor = UIColorFromRGB(0xF0F0F0);
    
}

- (void)resetValue:(NSString *)value
{
    [self newValueCheck:value isButtonClick:NO];
}

- (void)customBecomeFirstResponser:(BOOL)become
{
    if (become) {
        [self.writeText becomeFirstResponder];
        
    }else {
        [self.writeText resignFirstResponder];
        
    }
}


- (NSString *)receiveWriteText
{
    return self.writeText.text;
    
}

- (void)obtainTextPlaceholder:(NSString *)placeholder
                     minValue:(NSString *)minValue
                     maxValue:(NSString *)maxValue
                    stepValue:(NSString *)stepValue
                 keyboardType:(UIKeyboardType)keyboardType
{
    self.stepValue = stepValue;
    self.writeText.keyboardType = keyboardType;
    if (!isEmpty(minValue) && minValue.floatValue > 0.0) {
        self.writeText.text = minValue;
        
    }
    self.minValue = [minValue floatValue];
    self.maxValue = maxValue;
    
    if (!isEmpty(placeholder)) {
        NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:placeholder];
        [attributedPlaceholder addAttribute:NSForegroundColorAttributeName value:FormPlaceHolderColor range:NSMakeRange(0, placeholder.length)];
        [attributedPlaceholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, placeholder.length)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [attributedPlaceholder addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, placeholder.length)];
        self.writeText.attributedPlaceholder = attributedPlaceholder;
        
    }
    
}

#pragma mark UI

- (void)creatUI{
    [self addSubview:self.writeTextContainerView];
    [self.writeTextContainerView addSubview:self.decreaseButton];
    [self.writeTextContainerView addSubview:self.writeText];
    [self.writeTextContainerView addSubview:self.increaseButton];
    
    [self.writeTextContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.equalTo(self);
        
    }];
    
    [self.decreaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.width.equalTo(@25);
        make.centerY.equalTo(self).offset(-2);
        make.top.equalTo(self).offset(-2);
        make.bottom.equalTo(self).offset(2);
        
    }];
    
    [self.writeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self.decreaseButton.mas_trailing);
        make.trailing.equalTo(self.increaseButton.mas_leading);
        
    }];
    
    [self.increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.width.equalTo(@25);
        make.centerY.equalTo(self).offset(-2);
        make.top.equalTo(self).offset(-2);
        make.bottom.equalTo(self).offset(2);
        
    }];
    
}

- (void)decreaseButtonClick
{
    if (isEmpty(self.writeText.text)) {
        self.decreaseButton.enabled = NO;
        
    }else {
        if (self.writeText.text.floatValue == 0.0) {
            self.decreaseButton.enabled = NO;
            self.writeText.text = nil;
            
        }else {
            NSString *text = self.writeText.text;
            NSDecimalNumber *newDecimalNumber = [[NSDecimalNumber alloc]initWithString:text];
            NSDecimalNumber *stepNumber = [[NSDecimalNumber alloc]initWithString:self.stepValue];
            newDecimalNumber = [newDecimalNumber decimalNumberBySubtracting:stepNumber];
            
            NSString *newValue = newDecimalNumber.stringValue;
            [self newValueCheck:newValue isButtonClick:YES];
            
        }
    }
}

- (void)increaseButtonClick
{
    NSString *text = self.writeText.text;
    if (isEmpty(text)) {
//        self.writeText.text = self.stepValue;
        [self newValueCheck:self.stepValue isButtonClick:NO];
        
    }else {
        NSDecimalNumber *newDecimalNumber = [[NSDecimalNumber alloc]initWithString:text];
        NSDecimalNumber *stepNumber = [[NSDecimalNumber alloc]initWithString:self.stepValue];
        newDecimalNumber = [newDecimalNumber decimalNumberByAdding:stepNumber];
        NSString *newValue = newDecimalNumber.stringValue;
//        self.writeText.text = newValue;
        [self newValueCheck:newValue isButtonClick:NO];
        
    }
    self.decreaseButton.enabled = YES;
    
}

- (void)newValueCheck:(NSString *)newValue isButtonClick:(BOOL)isButtonClick
{
    if (self.writeText.isEditing && isEmpty(newValue)) { // 空的时候也准许
        
    }else {
        // -号按钮，输入框值
        if (!isEmpty(newValue) && newValue.floatValue >= self.minValue) {
            if (newValue.floatValue > self.minValue) {
                self.decreaseButton.enabled = YES;
                
            }else {
                self.decreaseButton.enabled = NO;
                
            }
            if (!isEmpty(self.maxValue)) {
                if (newValue.floatValue >= [self.maxValue floatValue]) {
                    self.increaseButton.enabled = NO;
                    if (newValue.floatValue == self.maxValue.floatValue) {
                        self.writeText.text = newValue;
                    }
                    
                }else {
                    self.increaseButton.enabled = YES;
                    self.writeText.text = newValue;
                }
                
            }else {
                self.increaseButton.enabled = YES;
                self.writeText.text = newValue;
            }
            
            
            if (isButtonClick && newValue.floatValue == 0.0) {
                self.writeText.text = @"";
                
            }
//            else {
//                self.writeText.text = newValue;
//
//            }
            
        }else {
            self.decreaseButton.enabled = NO;
            self.increaseButton.enabled = YES;
            if (newValue.floatValue < self.minValue && self.minValue > 0.0) {
                self.writeText.text = [NSString stringWithFormat:@"%.0f",self.minValue];
                
            }else if (self.minValue > 0.0) {
                
            }else {
                self.writeText.text = @"";
                
            }
        }
    }
    if (self.valueChangeBlock) {
        self.valueChangeBlock(self.writeText.text);
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *text = textField.text;
    if (!isEmpty(text)) {
        if (text.tfcs_ns_isDoubleNumber && text.floatValue > 0.0) {
            
        }else {
            textField.text = @""; // 清空0.0（0）或0.(不合法，不是数字)
            
        }
    }
    [self newValueCheck:textField.text isButtonClick:NO];
}

- (UIView *)writeTextContainerView
{
    if (!_writeTextContainerView) {
        _writeTextContainerView = [[UIView alloc]initWithFrame:CGRectZero];
        _writeTextContainerView.layer.borderColor = UIColorFromRGB(0xEEEEEE).CGColor;
        _writeTextContainerView.layer.borderWidth = 0.5;
        _writeTextContainerView.layer.cornerRadius = 4;
        _writeTextContainerView.layer.masksToBounds = YES;
        
    }
    return _writeTextContainerView;
}

- (UIButton *)decreaseButton
{
    if (!_decreaseButton) {
        _decreaseButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _decreaseButton.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor;
        _decreaseButton.layer.borderWidth = 0.5;
        [_decreaseButton setTitle:@"-" forState:UIControlStateNormal];
        [_decreaseButton setTitleColor:UIColorFromRGB(0x1E283C) forState:UIControlStateNormal];
        [_decreaseButton setTitleColor:UIColorFromRGB(0xB9BEC3) forState:UIControlStateDisabled];
        _decreaseButton.titleLabel.font = TFC_Font_Medium(18);
        [_decreaseButton addTarget:self action:@selector(decreaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _decreaseButton.backgroundColor = UIColorFromRGB(0xEEEEEE);
        _decreaseButton.enabled = NO;
        
    }
    return _decreaseButton;
}

- (UIButton *)increaseButton
{
    if (!_increaseButton) {
        _increaseButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _increaseButton.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor;
        _increaseButton.layer.borderWidth = 0.5;
        [_increaseButton setTitle:@"+" forState:UIControlStateNormal];
        [_increaseButton setTitleColor:UIColorFromRGB(0x1E283C) forState:UIControlStateNormal];
        [_increaseButton setTitleColor:UIColorFromRGB(0xB9BEC3) forState:UIControlStateDisabled];
        _increaseButton.titleLabel.font = TFC_Font_Medium(18);
        [_increaseButton addTarget:self action:@selector(increaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _increaseButton.backgroundColor = UIColorFromRGB(0xEEEEEE);
        
    }
    return _increaseButton;
}


- (UITextField *)writeText
{
    if (!_writeText) {
        _writeText = [[UITextField alloc] initWithFrame:CGRectZero];
        _writeText.textAlignment = NSTextAlignmentCenter;
        _writeText.font = [UIFont systemFontOfSize:14];
        _writeText.textColor = UIColorFromRGB(0x3D3D3D);
        _writeText.keyboardType = UIKeyboardTypeNumberPad;
        _writeText.delegate = self;
        __weak typeof(self) weakSelf = self;
        _writeText.changeBlock = ^() {
            NSString *newValue = [NSString tfcs_ns_decimalLengthValidator:weakSelf.writeText.text decimalLength:@3];
            NSArray *componentArr = [weakSelf.maxValue componentsSeparatedByString:@"."];
            NSString *maxValueComponentFirst = componentArr.firstObject;
            if (newValue.doubleValue > [weakSelf.maxValue floatValue]) {
                NSString *equalDigitValue = [NSString tfcs_ns_subWithString:newValue length:maxValueComponentFirst.length];
                if (equalDigitValue.doubleValue <= [weakSelf.maxValue floatValue]) {
                    weakSelf.writeText.text = equalDigitValue;
                    
                }else {
                    weakSelf.writeText.text = weakSelf.maxValue;
                    
                }
                if (weakSelf.maxValueTriggerBlock) {
                    weakSelf.maxValueTriggerBlock(weakSelf.writeText.text);
                    
                }
                
            }else {
                weakSelf.writeText.text = newValue;
                
            }
            [weakSelf newValueCheck:weakSelf.writeText.text isButtonClick:NO];
            
        };
    }
    return _writeText;
    
}



@end
