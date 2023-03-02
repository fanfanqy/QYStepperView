//
//  NSString+QYStepperView.m
//  Pods-TFCSNumberStepperView_Example
//
//  Created by 范庆宇 on 2022/6/9.
//

#import "NSString+QYStepperView.h"

@implementation NSString (QYStepperView)

+ (BOOL)tfcs_ns_isEmpty:(NSString*)string
{
    
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    
    if (string == nil) {
        return YES;
    }
    
    if (string.length <= 0) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}

-(BOOL)tfcs_ns_isIntNumbers
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)tfcs_ns_isDoubleNumber
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    double val;
    return [scan scanDouble:&val] && [scan isAtEnd];
}

+ (NSString *)tfcs_ns_decimalLengthValidator:(NSString *)toBeString decimalLength:(NSNumber *)decimalLength
{
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if (decimalLength) {
        int limit = [decimalLength intValue];
        
        NSString *regexStr = [NSString stringWithFormat:@"(\\+|\\-)?(((0[.]\\d{0,%d}))|([0-9]\\d{0,%d}(([.]\\d{0,%d})?)))?",limit,9+1+limit,limit]; // TODO:限制输入99999999.99 @""
        
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray * matches = [regex matchesInString:toBeString options:0 range:NSMakeRange(0, [toBeString length])];
        //match: 所有匹配到的字符,根据() 包含级
        NSMutableArray *array = [NSMutableArray array];
        for (NSTextCheckingResult *match in matches) {
            for (int i = 0; i < [match numberOfRanges]; i++) {
                if (i == 0) {
                    NSString *component = [toBeString substringWithRange:[match rangeAtIndex:i]];
                    [array addObject:component];
                }
            }
        }
        if (array.count > 0) {
            return array[0];
        }
    }
    return toBeString;
}

+ (NSString *)tfcs_ns_subWithString:(NSString *)string length:(NSInteger)length
{
    NSArray *componentArr = [string componentsSeparatedByString:@"."];
    NSString *newValue = componentArr.firstObject;
    if (newValue.length > length) {
        newValue = [newValue substringWithRange:NSMakeRange(0, length)];
        
    }
    if (componentArr.count > 1) {
        return [NSString stringWithFormat:@"%@.%@",newValue,componentArr[1]];
    }
    return newValue;
    
}

@end
