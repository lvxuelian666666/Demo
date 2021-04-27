//
//  CodeView.h
//  MengDian
//
//  Created by 新桥科技 on 16/3/3.
//  Copyright © 2016年 新桥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeView : UIView
/** 数组 */
@property (nonatomic, retain) NSArray *changeArray;
/** 随机生成字符串  */
@property (nonatomic, retain) NSMutableString *changeString;

@property (nonatomic, retain) UILabel *codeLabel;
- (void)change;
@end
