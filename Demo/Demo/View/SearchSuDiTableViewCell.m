//
//  SearchSuDiTableViewCell.m
//  Demo
//
//  Created by Shelly on 7/14/20.
//  Copyright © 2020 Shelly. All rights reserved.
//

#import "SearchSuDiTableViewCell.h"

@implementation SearchSuDiTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label_title = [UILabel new];
        self.label_nameTime = [UILabel new];
        self.isTop = [UILabel new];
        _isTop.textColor = [UIColor colorWithRed:0 green:198 / 255.0 blue:95 / 255.0 alpha:1];
        self.isEssence = [UILabel new];
        _isEssence.textColor = [UIColor colorWithRed:247 / 255.0 green:123 / 255.0 blue:81 / 255.0 alpha:1];
        
        self.label_content = [UILabel new];
        self.label_content.textColor = RGB(153, 153, 153, 1);

        [self.contentView addSubview:self.isTop];
        [self.contentView addSubview:self.isEssence];
        [self.contentView addSubview:self.label_title];
        [self.contentView addSubview:self.label_nameTime];
        [self.contentView addSubview:self.label_content];
        _label_nameTime.textColor = RGB(153, 153, 153, 1);

        _label_title.font  = CHINESE_SYSTEM(16);
        _label_nameTime.font = CHINESE_SYSTEM(12);
        _isTop.font = CHINESE_SYSTEM(16);
        _isEssence.font = CHINESE_SYSTEM(16);
        _label_content.font = CHINESE_SYSTEM(12);
        
        _label_line = [UILabel new];
        _label_line.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_label_line];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = [[NSString stringWithFormat:@"[置顶]"] boundingRectWithSize:CGSizeMake(MAXFLOAT, W * 17) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: CHINESE_SYSTEM(16)} context:nil];
 
    if (_isTop.text == nil && _isEssence.text == nil) {
        self.label_title.frame = CGRectMake(15 * W, 15 * W, ScreenWidth - 30 * W, 17 * W);
    }else if (_isTop.text != nil && _isEssence.text == nil){
        self.isTop.frame = CGRectMake(15 * W, 15 * W, rect.size.width, 17 * W);
        self.label_title.frame = CGRectMake(_isTop.frame.size.width + _isTop.frame.origin.y + 5 * W, 15 * W, ScreenWidth - 30 * W - _isTop.frame.size.width - 5 * W, 17 * W);
    }else if (_isTop.text == nil && _isEssence.text != nil){
        self.isEssence.frame = CGRectMake(15 * W, 15 * W, rect.size.width, 17 * W);
        self.label_title.frame = CGRectMake(_isEssence.frame.size.width + _isEssence.frame.origin.x + 5 * W , 15 * W, ScreenWidth - 30 * W  - _isEssence.frame.size.width - 5 * W, 17 * W);
    }else if (_isTop.text != nil && _isEssence.text != nil){
        self.isTop.frame = CGRectMake(15 * W, 15 * W, rect.size.width, 17 * W);
        self.isEssence.frame = CGRectMake(_isTop.frame.size.width + _isTop.frame.origin.x, 15 * W, rect.size.width, 17 * W);
        self.label_title.frame = CGRectMake(_isEssence.frame.size.width + _isTop.frame.size.width + _isTop.frame.origin.x + 5 * W, 15 * W, ScreenWidth - 30 * W - _isEssence.frame.size.width - _isTop.frame.size.width - 5 * W, 17 * W);
    }else{
        self.label_title.frame = CGRectMake(15 * W, 15 * W, ScreenWidth - 30 * W, 17 * W);
    }
    self.label_content.frame = CGRectMake(15 * W, self.label_title.frame.size.height + self.label_title.frame.origin.y + 10 * W, ScreenWidth - 30 * W, 12 * W);
    
//    /** 用户名,时间 */
//    _label_nameTime.frame = CGRectMake(15 * W, _label_content.y + _label_content.height + 10 * W, ScreenWidth - 30 * W, 12 * W);
//
//    self.label_line.frame = CGRectMake(15 * W, self.height = SINGLE_LINE_ADJUST_OFFSET, ScreenWidth - 15 * W, SINGLE_LINE_ADJUST_OFFSET);
}

+ (CGFloat)heighForLabel:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width , MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: CHINESE_SYSTEM(12)} context:nil];
    return rect.size.height;
}

@end
