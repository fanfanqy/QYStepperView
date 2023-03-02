//
//  UITextField+TFCSNSLimitLength.m
//  TransfarShipper
//
//  Created by 范庆宇 on 2021/7/27.
//  Copyright © 2021 Transfar. All rights reserved.
//

#import "UITextField+TFCSNSLimitLength.h"
#import <objc/runtime.h>
#import <objc/message.h>

static const void *limitLengthKey = &limitLengthKey;
static const void *textLengthMoreThanBlockKey = &textLengthMoreThanBlockKey;
static const void *textChangeBlockKey = &textChangeBlockKey;

@implementation UITextField (TFCSNSLimitLength)

#pragma mark - Setter/Getter
- (NSNumber *)limitLength
{
    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength
{
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TextLengthMoreThanBlock)lenghtBlock
{
    return objc_getAssociatedObject(self, textLengthMoreThanBlockKey);
}

- (void)setLenghtBlock:(TextLengthMoreThanBlock)lenghtBlock
{
    objc_setAssociatedObject(self, textLengthMoreThanBlockKey, lenghtBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (TextChangeBlock)changeBlock
{
    return objc_getAssociatedObject(self, textChangeBlockKey);
}

- (void)setChangeBlock:(TextChangeBlock)changeBlock
{
    objc_setAssociatedObject(self, textChangeBlockKey, changeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextDidChange
{
    if (self.limitLength) {
        NSString *toBeString = self.text;
        //获取高亮部分
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        //在iOS7下,position对象总是不为nil
        int limit = [self.limitLength intValue];
        if ( (!position ||!selectedRange) && (limit > 0 && toBeString.length > limit)) {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:limit];
            if (rangeIndex.length == 1){
                self.text = [toBeString substringToIndex:limit];
                
            }else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, limit)];
                NSInteger tmpLength;
                if (rangeRange.length > limit) {
                    tmpLength = rangeRange.length - rangeIndex.length;
                    
                }else{
                    tmpLength = rangeRange.length;
                    
                }
                self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
            }
            
            if (self.lenghtBlock){
                self.lenghtBlock();
                
            }
        }
        
    }
    
    if (self.changeBlock){
        self.changeBlock();
        
    }
    
}

+ (void)load
{
    Method origMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method newMethod = class_getInstanceMethod([self class], @selector(my_dealloc));
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)my_dealloc
{
    // do your logic here
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
    
    //this calls original dealloc method
    [self my_dealloc];
}

@end
