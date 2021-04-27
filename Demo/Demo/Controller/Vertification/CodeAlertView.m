//
//  CodeAlertView.m
//  MeiTanJiangHu
//
//  Created by 于颖 on 2018/3/12.
//  Copyright © 2018年 mtjh. All rights reserved.
//

#import "CodeAlertView.h"

@interface CodeAlertView()<UITextFieldDelegate>

@end
@implementation CodeAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _dic = [NSMutableDictionary dictionary];
        _bgView = [[UIView alloc] initWithFrame:self.frame];
        _bgView.backgroundColor = RGB(0, 0, 0, 0.45);
        [self addSubview:_bgView];
        
        _codeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - W * 80, H * 216.5)];
        _codeView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        _codeView.backgroundColor = [UIColor whiteColor];
        _codeView.layer.cornerRadius = W * 16;
        [self addSubview:_codeView];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"btn_close"];
        _closeButton.frame = CGRectMake(ScreenWidth - W * 80 - W * 6 - 23 * W, W * 6, W * 23, W * 23);
        [_closeButton setBackgroundImage:image forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.codeView addSubview:_closeButton];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(W * 15, H * 30, self.codeView.frame.size.width - W * 30, H * 18)];
        _titleLabel.textColor = Dark_Word_Color;
        _titleLabel.font = CHINESE_SYSTEM(18);
        _titleLabel.text = @"请输入图形验证码";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.codeView addSubview:_titleLabel];
        
        _codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(W * 32.5, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + W * 30, W * 119, W * 38)];
        _codeTextField.placeholder = @"请输入";
        _codeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_codeTextField.placeholder attributes:@{NSForegroundColorAttributeName:TextField_Defualt_Color}];
        _codeTextField.textColor = [UIColor blackColor];
        _codeTextField.font = CHINESE_SYSTEM(15);
        _codeTextField.layer.cornerRadius = 4;
        _codeTextField.keyboardType = UIKeyboardTypeDefault;
        _codeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _codeTextField.keyboardType = UIKeyboardTypeURL;
        _codeTextField.borderStyle = UITextBorderStyleRoundedRect;
        _codeTextField.delegate = self;
        [self.codeView addSubview:_codeTextField];
        
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.frame = CGRectMake(_codeTextField.frame.size.width + _codeTextField.frame.origin.x + W * 10, _codeTextField.frame.origin.y + 1, W * 71, H * 36);
        [_codeBtn addTarget:self action:@selector(codeChangeClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.codeView addSubview:_codeBtn];
        
        
        self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureButton.frame = CGRectMake(W * 32.5, _codeTextField.frame.origin.y + _codeTextField.frame.size.height + W * 30, self.codeView.frame.size.width - W * 32.5 * 2, H * 38);
        self.sureButton.backgroundColor = Common_Blue_Color;
        self.sureButton.titleLabel.font = CHINESE_SYSTEM(19);
        [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sureButton.layer.cornerRadius = 20;
        self.sureButton.layer.masksToBounds = YES;
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton addTarget:self action:@selector(sureCodeBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.codeView addSubview:self.sureButton];
    }
    return self;
}

- (void)sureCodeBtn
{

}

#pragma mark - block
- (void)returnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
}

- (void)closeClicked
{
    [_codeView removeFromSuperview];
    [_bgView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:true];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //设置视图移动的位移
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 80, self.frame.size.width, self.frame.size.height);
    return true;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    //设置视图移动的位移
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    return true;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
