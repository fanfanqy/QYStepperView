//
//  UITextField+TFCLimitLength.h
//  TransfarShipper
//
//  Created by 范庆宇 on 2021/7/27.
//  Copyright © 2021 Transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TextLengthMoreThanBlock)(void);

typedef void(^TextChangeBlock)(void);

@interface UITextField (TFCLimitLength)

/** 输入限制长度  */
@property (nonatomic, strong) NSNumber *limitLength;

/** 输入长度超过限制回调 */
@property (nonatomic, copy) TextLengthMoreThanBlock lenghtBlock;

/** 输入长度变化回调 */
@property (nonatomic, copy) TextChangeBlock changeBlock;

@end

NS_ASSUME_NONNULL_END
