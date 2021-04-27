//
//  SecondViewModel.h
//  Demo
//
//  Created by Shelly on 6/3/20.
//  Copyright © 2020 Shelly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecondModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewModel : NSObject

@property (nonatomic, strong) SecondModel *model;
@property (nonatomic, copy) NSString *userName;

-(instancetype)initWithSecond:(SecondModel *)model;


@end

NS_ASSUME_NONNULL_END
