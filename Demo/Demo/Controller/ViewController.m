//
//  ViewController.m
//  Demo
//
//  Created by Shelly on 2019/3/27.
//  Copyright © 2019年 Shelly. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "SecondViewController.h"
#import "CircleLayout.h"
#import "LineCollectionViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg4"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //隐藏黑线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
        
    int (^block)(int index) = ^(int count){
        return count + 1;
    };
    
    NSInteger a = block(5);
//    NSLog(@"a---%ld",a);
    
    void(^Block)(void)=^{
//        NSLog(@"age=%ld",(long)a);
    };
    Block();
    
    
    NSArray *array = @[@1,@2,@3,@2,@2,@23,@2];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"array = %@",x);
    }];
    
    NSDictionary *dictionary = @{@"key1":@"value1",@"key2":@"value2",@"key3":@"value3",@"key4":@"value4",@"key5":@"value5"};
    [dictionary.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        // x 是一个元祖，这个宏能够将 key 和 value 拆开
        RACTupleUnpack(NSString *key,NSString *value) = x;
//        NSLog(@"字典内容:%@:%@",key,value);
    }];
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, 200, 30)];
    textField.backgroundColor = [UIColor yellowColor];
    textField.placeholder = @"请输入内容";
    [self.view addSubview:textField];
    [[textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"文本框:%@",x);
    }];
    
    [[textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"输入框内容:%@",x);
    }];
    
    //按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(15, 60, 200, 30)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"点一下" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"按钮被点击了");
        textField.frame = CGRectMake(50, textField.frame.origin.y + 60, textField.frame.size.width, textField.frame.size.height);
    }];
    
    RAC(btn,enabled) = [RACSignal combineLatest:@[textField.rac_textSignal] reduce:^id _Nonnull(NSString *text){
        return @(text.length);
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"键盘弹起");
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
//        NSLog(@"键盘隐藏");
    }];
    
    [RACObserve(textField, frame) subscribeNext:^(id  _Nullable x) {
//        NSLog(@"文本框的frame变了");
    }];
        
//    [self creatSubViews];
    [self creatSearchBar];
}

-(void)createViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    
    
}

-(void)creatSearchBar
{
    UIView *searchBackView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth - 15 * 2, NavH)];
    searchBackView.backgroundColor = [UIColor clearColor];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, searchBackView.frame.size.width, NavH)];
    _searchBar.delegate = self;
    _searchBar.tintColor = [UIColor redColor];//光标颜色
    _searchBar.barTintColor = [UIColor lightGrayColor];//搜索框背景颜色
//    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [searchBackView addSubview:_searchBar];
    self.navigationItem.titleView = searchBackView;
    
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
    
//    UIStoryboard *homeStoryBoard = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
//    HomeViewController *homeVC = [homeStoryBoard instantiateViewControllerWithIdentifier:@"HomeVC"];
//    [self.navigationController pushViewController:homeVC animated:YES];
    
}

@end
