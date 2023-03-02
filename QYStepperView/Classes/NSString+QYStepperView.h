//
//  NSString+QYStepperView.h
//  Pods-TFCSNumberStepperView_Example
//
//  Created by 范庆宇 on 2022/6/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QYStepperView)

+ (BOOL)tfcs_ns_isEmpty:(NSString*)string;

-(BOOL)tfcs_ns_isIntNumbers;

- (BOOL)tfcs_ns_isDoubleNumber;

+ (NSString *)tfcs_ns_decimalLengthValidator:(NSString *)toBeString decimalLength:(NSNumber *)decimalLength;

+ (NSString *)tfcs_ns_subWithString:(NSString *)string length:(NSInteger)length;

@end

NS_ASSUME_NONNULL_END
