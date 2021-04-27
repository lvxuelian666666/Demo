
//
//  SecondViewController.m
//  Demo
//
//  Created by Shelly on 8/22/19.
//  Copyright © 2019 Shelly. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import <SafariServices/SafariServices.h>


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
   
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
//
//    [self removeTheRepeatData];
//    [self createButtons];
}


-(void)removeTheRepeatData
{
    NSArray *oldArr = @[@"1",@"5",@"4",@"4",@"1",@"1",@"5"];
    NSArray *newArr = [oldArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"newArr = %@", newArr);
}

-(void)createButtons
{
    //🈲button高亮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(50, 150, 200, 40);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"禁止button高亮" forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"icon_dzht"] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 220, 200, 40)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"有高亮" forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"icon_dzht"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 200, 40)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"无高亮" forState:UIControlStateNormal];
    btn3.adjustsImageWhenHighlighted = NO;
    [btn3 setImage:[UIImage imageNamed:@"icon_dzht"] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
}

-(void)click:(UIButton *)btn
{
    
}

-(void)rightClick
{
    [self createSafariWebView];
}

-(void)createSafariWebView
{
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.meitanjianghu.com"]];
    [self presentViewController:safariVc animated:YES completion:nil]; // 推荐使用modal自动处理 而不是push
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
    [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(100);
        make.right.equalTo(self.view).with.offset(-100);
        make.top.equalTo(_phoneText.mas_bottom).with.offset(20);
        make.height.mas_equalTo(50);
    }];
    
    [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击的时候 x=%@",x);
        FourthViewController *fourthVC = [[FourthViewController alloc] init];
        [self.navigationController pushViewController:fourthVC animated:YES];
    }];
    
    [[self.view rac_signalForSelector:@selector(nextBtnClick:)]subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"按钮被点击的时候 %@",x);
    }];
    
    NSArray *numbers = @[@1,@2,@3,@4];
    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"x===%@",x);
    }];
    
}

-(void)nextBtnClick:(UIButton *)btn
{
    NSLog(@"---click");
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
    if (indexPath.row < 5) {
        ThirdViewController *secondVC = [[ThirdViewController alloc] init];
        [self.navigationController pushViewController:secondVC animated:YES];
    }else{
        FourthViewController *fourthVC = [[FourthViewController alloc] init];
        [self.navigationController pushViewController:fourthVC animated:YES];
    }

}


@end
