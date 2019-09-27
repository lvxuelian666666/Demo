//
//  HomeViewController.m
//  Demo
//
//  Created by Shelly on 2019/4/26.
//  Copyright © 2019年 Shelly. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) NSString *labelText;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _labelText = @"This is a short text about sth";
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, StatusH + NavH, ScreenWidth, 100)];
    label.text = _labelText;
    label.numberOfLines = 10;
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];

    for (int i = 0; i < 10; i++) {
        _labelText = [_labelText stringByAppendingString:@"\n "];
    }
    label.text = _labelText;

}


@end
