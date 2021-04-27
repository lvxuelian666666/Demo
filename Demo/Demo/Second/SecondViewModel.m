//
//  SecondViewModel.m
//  Demo
//
//  Created by Shelly on 6/3/20.
//  Copyright © 2020 Shelly. All rights reserved.
//

#import "SecondViewModel.h"

@implementation SecondViewModel

-(instancetype)initWithSecond:(SecondModel *)model
{
    self = [super init];
    if (self) {
        _model = model;
        if (model.userName.length > 0) {
            _userName = model.userName;
        }else{
            _userName = [NSString stringWithFormat:@"你真的好漂亮呀"];
        }
    }
    return self;
}


@end
