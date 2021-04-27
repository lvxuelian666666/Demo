//
//  SecondView.m
//  Demo
//
//  Created by Shelly on 6/3/20.
//  Copyright © 2020 Shelly. All rights reserved.
//

#import "SecondView.h"

@implementation SecondView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        _titleLab = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont boldSystemFontOfSize:20];
        [self addSubview:_titleLab];
        
        
        
    }
    return self;
}



@end
