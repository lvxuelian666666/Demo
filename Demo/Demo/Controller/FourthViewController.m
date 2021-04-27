
//
//  FourthViewController.m
//  Demo
//
//  Created by Shelly on 10/8/19.
//  Copyright © 2019 Shelly. All rights reserved.
//

#import "FourthViewController.h"
#import "SearchViewController.h"

@interface FourthViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) dispatch_semaphore_t semaphoreLock;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *titleArr;


@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第四页";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.tableView];
//    [self GCD];
//    [self applyGCD];
    [self block];
    self.titleArr = @[@"1",@"3",@"5"];
    
//    int multiplier = 6;
//    int(^abc)(int) = ^int(int num){
//        return num *multiplier;
//    };
//    NSLog(@"打印 = %d",abc(5));
//
//    int (^Sum)(int n,int m) = ^(int a, int b){
//        return a + b;
//    };
//
//    NSLog(@"加法 = %d",Sum(5,6));
//
//    void (^blk)(void) = ^{
//        NSLog(@"qqqq");
//    };
//    blk();
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < 100; i++) {
        dispatch_group_async(group, queue, ^{
            NSLog(@"---i=%d",i);
        });
    }

    dispatch_group_notify(group, queue, ^{
        NSLog(@"结束");
    });
    
    
    
    
}

//-(void)addBlock:((^)blk)block
//{
//
//
//}




-(void)createOpenButton
{
    UIImage *image = [UIImage imageNamed:@"btn_openenterprise"];
    NSLog(@"size =%@",NSStringFromCGSize(image.size));
    UIButton *_openShopBtn = [[UIButton alloc] initWithFrame:CGRectMake(3 * IMG_WIDTH, 100 * W, ScreenWidth - 3 * IMG_WIDTH * 2, 70 * IMG_WIDTH)];
    [_openShopBtn setBackgroundImage:image forState:UIControlStateNormal];
    [_openShopBtn addTarget:self action:@selector(openShopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_openShopBtn];
}


-(UIImage *)resizableImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2) resizingMode:UIImageResizingModeStretch];
    return image;
}

-(void)setTitleArr:(NSArray *)titleArr
{
    NSLog(@"---titleArr = %@",titleArr);
    
    
}

-(void)block
{
    void(^blk)(void) = ^{
        NSLog(@"-------%d",999);
    };
    blk();
    
    
    int (^blockName)(NSString *str) = ^int (NSString *name){
        return 10;
    };
    
    int a = blockName(@"aa");
    NSLog(@"啊 = %d",a);
    

    
}

-(void)GCD
{
    for (int i = 0; i < 100; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"i= %d currentThread = %@",i,[NSThread currentThread]);
        });
    }
}

-(void)applyGCD
{
    dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
        NSLog(@"%zd---%@",index,[NSThread currentThread]);
    });
}

-(void)initTicketStatusSave
{
    
    _semaphoreLock = dispatch_semaphore_create(1);
    
    _index = 100;
    
    
    
    
}

#pragma mark --
-(void)saleTicketSafe
{
    while (1) {
        dispatch_semaphore_wait(_semaphoreLock, DISPATCH_TIME_FOREVER);
        if (self.index > 0) {
            self.index--;
            NSLog(@"剩余票数:%ld 窗口:%@",self.index,[NSThread currentThread]);
        }else{
            //相当于解锁
            dispatch_semaphore_signal(_semaphoreLock);
            break;
        }
        //相当于解锁
        dispatch_semaphore_signal(_semaphoreLock);
    }
    
    
}


#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [UIColor yellowColor];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    cell.detailTextLabel.text = @"点开看看";
    if (indexPath.row % 2 == 0) {
        cell.selected = YES;
     } else {
         cell.selected = NO;
    }
    return cell;
}

#pragma mark - tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willBeginEditingRowAtIndexPath");
    
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didEndEditingRowAtIndexPath");
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    NSLog(@"willDisplayHeaderView");
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"willDisplayCell");
}

-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didUnhighlightRowAtIndexPath");
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    titleLab.text = @"header";
    [view addSubview:titleLab];
    return view;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavH + StatusH, ScreenHeight, ScreenHeight - NavH - StatusH) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
       _tableView.allowsMultipleSelectionDuringEditing = YES;
       [_tableView setEditing:YES animated:YES];
       [_tableView indexPathsForSelectedRows];
    }
    return _tableView;
}


@end
