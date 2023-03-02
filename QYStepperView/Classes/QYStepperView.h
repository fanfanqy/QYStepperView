//
//  TFCSNumberStepperView.h
//  TransfarShipper
//
//  Created by 范庆宇 on 2022/6/6.
//  Copyright © 2022 Transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TFCSNumberStepperViewMaxValueTriggerBlock)(NSString *maxValue);

typedef void(^TFCSNumberStepperViewValueChangeBlock)(NSString *value);

@interface QYStepperView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *writeText; //
@property (nonatomic, strong) UIView *writeTextContainerView;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) UIButton *decreaseButton;

@property(nonatomic,copy)TFCSNumberStepperViewMaxValueTriggerBlock maxValueTriggerBlock;

@property(nonatomic,copy)TFCSNumberStepperViewValueChangeBlock valueChangeBlock;

- (void)obtainTextPlaceholder:(NSString *)placeholder
                     minValue:(NSString *)minValue
                     maxValue:(NSString *)maxValue
                    stepValue:(NSString *)stepValue
                 keyboardType:(UIKeyboardType)keyboardType;

- (void)disableState;

- (void)defaultState;

- (void)resetValue:(NSString *)value;

- (void)customBecomeFirstResponser:(BOOL)become;

- (NSString *)receiveWriteText;



@end

NS_ASSUME_NONNULL_END
