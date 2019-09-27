
//
//  SecondViewController.m
//  Demo
//
//  Created by Shelly on 8/22/19.
//  Copyright © 2019 Shelly. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"


@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *nameText;
@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UIButton *nextBtn;


@end

@implementation SecondViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"第二页";
    [self creatTableView];
}

-(void)creatTableView
{
    for (int i = 0 ; i < 2; i++) {
        UITextField *text = [UITextField new];
        text.backgroundColor = [UIColor yellowColor];
        text.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:text];
        if (i == 0) {
            _nameText = text;
        }else{
            _phoneText = text;
        }
    }
    
    CGFloat interval = 15;
    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).with.offset(interval);
        make.right.equalTo(self.view).with.offset(-interval);
        make.height.mas_equalTo(50);
    }];
    
    [_phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameText.mas_bottom).with.offset(10);
        make.left.right.height.equalTo(_nameText);
    }];
    
    _nextBtn = [[UIButton alloc] init];
    [_nextBtn setTitle:@"点我" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_nextBtn];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(100);
        make.right.equalTo(self.view).with.offset(-100);
        make.top.equalTo(_phoneText.mas_bottom).with.offset(20);
        make.height.mas_equalTo(50);
    }];
    
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThirdViewController *secondVC = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}


@end
