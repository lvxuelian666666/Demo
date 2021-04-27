//
//  SearchSuDiTableViewCell.h
//  Demo
//
//  Created by Shelly on 7/14/20.
//  Copyright © 2020 Shelly. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchSuDiTableViewCell : UITableViewCell

/** 返回结果标题 */
@property (nonatomic,strong) UILabel *label_title;
/** 返回结果姓名+时间 */
@property (nonatomic,strong) UILabel *label_nameTime;
/** 置顶 */
@property (nonatomic, strong) UILabel *isTop;
/** 精华 */
@property (nonatomic, strong) UILabel *isEssence;
/** 内容 */
@property (nonatomic, strong) UILabel *label_content;
/** 线 */
@property (nonatomic, strong) UILabel *label_line;

+ (CGFloat) heighForLabel:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
