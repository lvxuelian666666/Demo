//
//  CodeAlertView.h
//  MeiTanJiangHu
//
//  Created by 于颖 on 2018/3/12.
//  Copyright © 2018年 mtjh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnTextBlock)(NSMutableArray *codeArr);
@interface CodeAlertView : UIView
//深色半透明背景颜色
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *codeView;//图形验证码 View
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) UITextField *codeTextField;//验证码输入框
@property (nonatomic, strong) UIButton *sureButton;//确定按钮
/** 随机生成验证码 */
//@property (nonatomic, strong) CodeView *codeView;
//验证码 图片
@property (nonatomic, strong) UIButton *codeBtn;
//关闭
@property (nonatomic, strong) UIButton *closeButton;
//电话号码
@property (nonatomic, strong) NSString *phonenumber;
@property (nonatomic, strong) NSString *uuid;//唯一标识
@property (nonatomic, strong) NSMutableDictionary *dic;//传验证码 返回字典
/** 返回block */
@property (nonatomic,strong) ReturnTextBlock returnTextBlock;

- (void)returnText:(ReturnTextBlock)block;
@end
