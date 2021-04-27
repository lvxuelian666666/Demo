//
//  VertificationCodeView.h
//  MeiTanJiangHu
//
//  Created by Lv on 2018/1/2.
//  Copyright © 2018年 mtjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeInputLabel.h"
@class VertificationCodeView;
@protocol VertificationCodeViewDelegate <NSObject>

@optional

/**
 全部输入验证码／密码后，执行该方法，并且将code返回
 @param inputView 输入视图
 @param code 验证码／密码
 */
-(void)codeInputView:(VertificationCodeView *)inputView code:(NSString *)code;

@end


@interface VertificationCodeView : UIView

//代理
@property(nonatomic, weak) id<VertificationCodeViewDelegate>delegate;

/**
 验证码的位数
 */
@property (nonatomic, assign) NSInteger numberOfCode;
/**
 验证码几位数
 */
@property (nonatomic, assign) NSInteger numberOfVertificationCode;
/**
 每位 验证码/密码 显示的大小
 */
@property (nonatomic,assign) CGSize codeBgImgSize;
/**
 验证码／密码内容 (通过这里拿到 验证码／密码 的内容)
 */
@property (nonatomic, strong) NSString *vertificationCode;
/**用于获取键盘输入的内容，实际不显示*/
@property (nonatomic, strong) UITextField *textField;
/**实际用于显示验证码/密码的label*/
@property (nonatomic, strong) CodeInputLabel *label;
@end
