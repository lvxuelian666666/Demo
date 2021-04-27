
//
//  LineCollectionViewCell.m
//  Demo
//
//  Created by Shelly on 9/26/19.
//  Copyright © 2019 Shelly. All rights reserved.
//

#import "LineCollectionViewCell.h"

@implementation LineCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imgView.image = [UIImage imageNamed:@"icon_mpj"];
        [self addSubview:_imgView];
    }
    return self;
}


@end
