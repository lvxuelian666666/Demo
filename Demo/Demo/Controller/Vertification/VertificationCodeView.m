//
//  VertificationCodeView.m
//  MeiTanJiangHu
//
//  Created by Lv on 2018/1/2.
//  Copyright © 2018年 mtjh. All rights reserved.
//

#import "VertificationCodeView.h"


@interface VertificationCodeView()<UITextFieldDelegate>


@end

@implementation VertificationCodeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.numberOfVertificationCode = 6;
        [self ViewSubViews];
        [self.textField becomeFirstResponder];
    }
    return self;
}

-(void)ViewSubViews
{
    // 设置透明背景色，保证vertificationCodeInputView显示的frame为backgroundImageView的frame
    self.backgroundColor = [UIColor clearColor];
    /* 调出键盘的textField */
    self.textField = [[UITextField alloc] initWithFrame:self.bounds];
    self.textField.textColor = [UIColor blackColor];
    // 隐藏textField，通过点击IDVertificationCodeInputView使其成为第一响应者，来弹出键盘
    self.textField.hidden = YES;
    self.textField.font = [UIFont systemFontOfSize:18];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.delegate = self;
    // 将textField放到最后边
    [self insertSubview:self.textField atIndex:0];
    
    /* 添加用于显示验证码/密码的label */
    self.label = [[CodeInputLabel alloc] initWithFrame:self.bounds];
    //密码的位数
    self.label.numberOfVertificationCode = self.numberOfVertificationCode;
    self.label.font = self.textField.font;
    //每个密码框背景的大小
    self.label.codeSize = CGSizeMake(36 * W, 46 * H);
    //每个密码框背景之间的间距
    self.label.codeWidthOffset = 8 * W;
    [self addSubview:self.label];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断是不是“删除”字符&&判断是不是快速填充的验证码
    if (string.length != 0 && ![string isEqualToString:@""]) {// 不是“删除”字符
        // 判断验证码/密码的位数是否达到预定的位数
        if (textField.text.length < self.numberOfVertificationCode) {
            self.label.text = [textField.text stringByAppendingString:string];
            self.vertificationCode = self.label.text;
            
            //            if (textField.text.length == self.numberOfVertificationCode - 1) {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(codeInputView:code:)]) {
                [self.delegate codeInputView:self code:self.vertificationCode];
            }
            //            }
            return YES;
        } else {
            
            //            if (textField.text.length == self.numberOfVertificationCode) {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(codeInputView:code:)]) {
                [self.delegate codeInputView:self code:self.vertificationCode];
            }
            //            }
            return NO;
        }
    } else { // 是“删除”字符
        if (![textField.text isEqualToString:@""]) {//判断是不是快速填充的验证码
            
            self.label.text = [textField.text substringToIndex:textField.text.length - 1];
            self.vertificationCode = self.label.text;
            if (self.delegate &&[self.delegate respondsToSelector:@selector(codeInputView:code:)]) {
                [self.delegate codeInputView:self code:self.vertificationCode];
            }
            return YES;
        } else {
            return NO;
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField becomeFirstResponder];
}

@end
