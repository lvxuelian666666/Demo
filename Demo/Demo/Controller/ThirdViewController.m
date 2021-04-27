//
//  ThirdViewController.m
//  Demo
//
//  Created by Shelly on 8/22/19.
//  Copyright © 2019 Shelly. All rights reserved.
//

#import "ThirdViewController.h"
#import "ViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
 
#import <CoreTelephony/CTCarrier.h>

@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
//长图
@property (nonatomic, strong) UIImageView *posterImgView;

@end

@implementation ThirdViewController

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
    self.title = @"第三页";

//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
//    lable.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:lable];
//
//    [self drawShapeRect];
//    [self drawRect];
//    [self invocation];
    
    _posterImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    _posterImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_posterImgView];
    [self downLoadFile];
}

#pragma mark --  下载文件
- (void)downLoadFile
{
    // 1. 创建url
    NSString *urlStr = @"https://www.meitanjianghu.com/wechat/shopAPI/get/code/0";
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *Url = [NSURL URLWithString:urlStr];
    // 创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:Url];
    request.HTTPMethod = @"POST"; //请求方式
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"typeC":@"json",@"page":@"pages/supplydemanddetail/supplydemanddetail",@"scene":@"ec271134-a7cd-47ad-9102-b5c99496a06c,3477327a-828a-4481-af0c-98228d7e278c,supply"} options:NSJSONWritingPrettyPrinted error:nil];
    NSData *postData = [[NSString stringWithFormat:@"page:%@,scene:%@",@"pages/supplydemanddetail/supplydemanddetail",@"ec271134-a7cd-47ad-9102-b5c99496a06c,3477327a-828a-4481-af0c-98228d7e278c,supply"] dataUsingEncoding:NSUTF8StringEncoding];//请求体
    [request setValue:[NSString stringWithFormat:@"%lu",jsonData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = jsonData;
    // 创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            // 下载成功
            // 注意 location是下载后的临时保存路径, 需要将它移动到需要保存的位置
            NSError *saveError;
            // 创建一个自定义存储路径
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *savePath = [cachePath stringByAppendingPathComponent:@"waterMark.png"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSURL *saveURL = [NSURL fileURLWithPath:savePath];
            NSLog(@"🐯 savePath= %@",savePath);
            if([fileManager  fileExistsAtPath:savePath]){
                if ([fileManager removeItemAtURL:saveURL error:nil]){
                    NSLog(@"remove success");
                }
            }
            // 文件复制到cache路径中
            [fileManager copyItemAtURL:location toURL:saveURL error:&saveError];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //在回调函数中或者后台线程中更新了UI界面，而UI界面必须是在主界面中才能进行修改
                self.posterImgView.image = [UIImage imageWithContentsOfFile:savePath];
            });
            if (!saveError) {
                NSLog(@"保存成功");
            } else {
                NSLog(@"error is %@", saveError.localizedDescription);
            }
        } else {
            NSLog(@"error is : %@", error.localizedDescription);
        }
    }];
    // 恢复线程, 启动任务
    [downLoadTask resume];
}

-(void)invocation
{
    SEL myMethod = @selector(myLog:parm:parm:);
    //1.创建签名:方法名称|参数|返回| 和方法的调用没有关系
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:myMethod];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    //invocation中的方法必须和签名中的方法一致。
    invocation.selector = myMethod;
   
    int a= 1;
    int b = 2;
    int c = 3;
    [invocation setArgument:&a atIndex:2];
    [invocation setArgument:&b atIndex:3];
    [invocation setArgument:&c atIndex:4];
    ////只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
    [invocation invoke];
    
    
}

-(void)myLog:(int)a parm:(int)b parm:(int)c
{
    NSLog(@"total = %d",a+b+c);
}





//-(void)invocation
//{
//    //创建签名:方法名称|和方法的调用关系
//    NSMethodSignature *signature = [UIViewController invo];
//    
//    
//    
//    
//}



-(BOOL)dataHandleBlock:(BOOL(^)(NSDictionary *infoDic))block
{
    block(@{@"a":@"1",@"b":@"2"});
    return YES;
}

-(void)drawRect
{
    CGRect topRect = CGRectMake(0,0,ScreenWidth,300 * W);
    //用灰色填充矩形
    [[UIColor colorwithHexString:@"#0A0C13"] setFill];
    UIRectFill(topRect);

    CGRect bottomRect = CGRectMake(0, 300 * W, ScreenWidth, ScreenHeight - 300 * W);
    [[UIColor colorwithHexString:@"#F5F6F7"] setFill];
    UIRectFill(bottomRect);
}

#pragma mark 绘制矩形
- (void)drawShapeRect
{
    /*
     在程序开发中 无论肉眼在程序中看到的是什么形状，其本质上都是矩形。
     */
    CGRect rect = CGRectMake(50, 50, 200, 200);
    [[UIColor redColor]set];
    //绘制实心矩形
    UIRectFill(rect);
//    //绘制空心矩形
//    UIRectFrame(CGRectMake(50, 300, 200, 200));
}


-(void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavH + StatusH, ScreenWidth, ScreenHeight - NavH - StatusH) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    [self.view addSubview:_tableView];
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
     ViewController*secondVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}


@end
