//
//  ViewController.m
//  Demo
//
//  Created by Shelly on 2019/3/27.
//  Copyright © 2019年 Shelly. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "HomeViewController.h"
#import "SecondViewController.h"
#import "CircleLayout.h"
#import "LineCollectionViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg4"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //隐藏黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    NSLog(@"第一页 === %@",NSStringFromCGRect(self.view.frame));
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第一页";
        
    int (^block)(int index) = ^(int count){
        return count + 1;
    };
    
    NSInteger a = block(5);
    NSLog(@"a---%ld",a);
    [self creatSubViews];
}

-(void)creatSubViews
{
    CircleLayout *layout = [[CircleLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, 100) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[LineCollectionViewCell class] forCellWithReuseIdentifier:@"LineCollectionViewCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LineCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController *secondVC = [[SecondViewController alloc] init];
      [self.navigationController pushViewController:secondVC animated:YES];
}

-(void)setupButton
{
    _button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 35)];
    _button.backgroundColor = [UIColor orangeColor];
    [_button setImage:[UIImage imageNamed:@"btn_admire"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"btn_admire_sel"] forState:UIControlStateSelected];
    [_button setTitle:@"点我" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_button setTitleShadowColor:[UIColor blueColor] forState:UIControlStateNormal];
    _button.adjustsImageWhenDisabled = YES;
    _button.adjustsImageWhenHighlighted = YES;
    
    [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
}

-(void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    HomeViewController *homeVC = [homeStoryBoard instantiateViewControllerWithIdentifier:@"HomeVC"];
    [self.navigationController pushViewController:homeVC animated:YES];
    
}

@end
