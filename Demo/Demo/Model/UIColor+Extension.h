//
//  UIColor+Extension.h
//  Demo
//
//  Created by Shelly on 4/27/20.
//  Copyright © 2020 Shelly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)

/**
 *  十六进制的颜色转换为UIColor
 *
 *  @param color   十六进制的颜色
 *
 *  @return   UIColor
 */
+ (UIColor *)colorwithHexString:(NSString *)color;


@end

NS_ASSUME_NONNULL_END
