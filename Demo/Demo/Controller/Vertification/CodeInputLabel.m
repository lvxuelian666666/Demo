//
//  CodeInputLabel.m
//  MeiTanJiangHu
//
//  Created by Lv on 2018/1/2.
//  Copyright © 2018年 mtjh. All rights reserved.
//

#import "CodeInputLabel.h"

@implementation CodeInputLabel

//重写setText方法，调用drawRect方法
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGFloat codeOffset = self.codeWidthOffset < 0 ? 0 : self.codeWidthOffset;
    CGFloat rect_width = (rect.size.width - codeOffset) /self.numberOfVertificationCode;
    CGFloat rect_height = rect.size.height;
    
    CGFloat width = self.codeSize.width <=0 ?rect_width : self.codeSize.width;
    CGFloat height = self.codeSize.height <=0 ?rect_height:self.codeSize.height ;

    //设置区域
    for (NSInteger i = 0; i < self.numberOfVertificationCode; i++) {
        //绘制区域
        CGFloat tempX = i * (width + codeOffset);
        CGRect tempRect = CGRectMake(tempX, 0, width, height);
        UILabel *borderlab = [[UILabel alloc]initWithFrame:tempRect];
        borderlab.tag = 100 + i;
        borderlab.layer.borderColor = Light_Word_Color.CGColor;
        borderlab.layer.borderWidth = 0.5;
        if (self.text.length == 0 && i == 0 && _lastBorderLab == nil) {
            borderlab.layer.borderColor = Blue_Word_Color.CGColor;
            borderlab.layer.borderWidth = 1;
            _lastBorderLab = borderlab;
        }
        if (![self viewWithTag:100 + i]) {
            [self addSubview:borderlab];
        }
    }
    
    //设置之前背景为蓝色的恢复灰色
    _lastBorderLab.layer.borderColor = Light_Word_Color.CGColor;
    _lastBorderLab.layer.borderWidth = 0.5;
    
    if (self.text.length < self.numberOfVertificationCode ) {
         //设置目前的框的颜色为蓝色
        UILabel *currentLab = [self viewWithTag:100 + self.text.length];
        currentLab.layer.borderColor = Blue_Word_Color.CGColor;
        currentLab.layer.borderWidth = 1;
        _lastBorderLab = currentLab;
    }
    
    //绘制验证码／密码
    for (NSInteger i = 0; i < self.text.length; i ++) {
        //绘制区域
        CGFloat tempX = i * (width + codeOffset);
        CGRect tempRect = CGRectMake(tempX, 0, width, height);
        //密码
        if (self.secureTextEntry) {
            UIImage *dotImage = [UIImage imageNamed:@""];
            CGPoint drawStartPoint = CGPointMake(tempX + (width - dotImage.size.width) / 2.0, (tempRect.size.height - dotImage.size.height) / 2.0);
            [dotImage drawAtPoint:drawStartPoint];
        }else{
            //验证码
            NSString *charecterString = [NSString stringWithFormat:@"%c", [self.text characterAtIndex:i]];
            //设置属性
            NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
            attributes[NSFontAttributeName] = self.font;
            attributes[NSForegroundColorAttributeName] = self.textColor;
            //计算Size
            CGSize characterSize = [charecterString sizeWithAttributes:attributes];
            //计算输入字的位置
            CGPoint vertificationCodeDrawStartPoint = CGPointMake(tempX + (width - characterSize.width) / 2.0, (tempRect.size.height - characterSize.height) / 2.0);
            // 绘制验证码/密码
            [charecterString drawAtPoint:vertificationCodeDrawStartPoint withAttributes:attributes];
        }
    }
}

@end
