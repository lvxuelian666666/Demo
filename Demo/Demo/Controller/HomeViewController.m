//
//  HomeViewController.m
//  Demo
//
//  Created by Shelly on 4/27/20.
//  Copyright © 2020 Shelly. All rights reserved.
//

#import "HomeViewController.h"
#import "VertificationCodeView.h"
#import "AppDelegate.h"
#import <QuickLook/QuickLook.h>
#import <YLGIFImage/YLImageView.h>
#import <WebKit/WebKit.h>
#import <AFNetworking/AFNetworking.h>

@interface HomeViewController ()<WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate>
//电话
@property (nonatomic, strong) UITextField *phoneText;
//下一步
@property(nonatomic, strong) UIButton *nextBtn;
//
@property (nonatomic, strong) QLPreviewController *previewController;
@property (nonatomic, strong) NSURL *fileUrl;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIDocumentInteractionController *DIController;
@property(nonatomic,strong)NSURL *fileURL;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createWebview];
}

-(void)createWebview
{

    NSString*css = @"body{-webkit-user-select:none;-webkit-user-drag:none;}";

    //css 选中样式取消
    NSMutableString*javascript = [NSMutableString string];
    [javascript appendString:@"var style = document.createElement('style');"];
    [javascript appendString:@"style.type = 'text/css';"];
    [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [javascript appendString:@"style.appendChild(cssContent);"];
    [javascript appendString:@"document.body.appendChild(style);"];
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按

    //javascript 注入
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript
    injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    WKUserContentController*userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:noneSelectScript];
    
    WKWebViewConfiguration*configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences.javaScriptEnabled =YES;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically =NO;
    configuration.userContentController = userContentController;
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusH - NavH) configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    /*
     * 关闭回弹效果
     */
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:_webView];
    
 
    [self actionQLView];
    
    
//    NSURL *url = [NSURL URLWithString:@"file:///var/mobile/Containers/Data/Application/4EB20B7F-A0F8-4B18-9D64-ED9281BF90B3/Documents/MzAxYmY5OGU1NTktNjllYS00ZDk5LWE1MGEtYjkzODRhN2FlMjk3NjQ2YmRkM2ItOWVjNi00MzAxLTgzYTUtZGNlMDJiNDA0ZTliMTYwNDM4MzUxOTY1NERDMkE0QjQzLTdENTctNERDMC1CQjBFLTFFQ0Q5OTk2NUNFNw==.pdf"];
//    [self.webView loadFileURL:url allowingReadAccessToURL:url];
    
    
    /********** 下面 代码是为了禁止复制粘贴的  ****/
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];
    longPress.delegate = self; //记得在.h文件里加上委托
    longPress.minimumPressDuration = 0.4; //这里为什么要设置0.4，因为只要大于0.5就无效，我像大概是因为默认的跳出放大镜的手势的长按时间是0.5秒，
    //如果我们自定义的手势大于或小于0.5秒的话就来不及替换他的默认手势了，这是只是我的猜测。但是最好大于0.2秒，因为有的pdf有一些书签跳转功能，这个值太小的话可能会使这些功能失效。
    [self.webView addGestureRecognizer:longPress];
    
    [UIPasteboard generalPasteboard].string = @"";
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(paste:) || action == @selector(cut:)){
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
}

-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{

}

- (void)actionQLView
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *urlStr = @"https://api2.meitanjianghu.com/ReportPdfController/viewFile?fid=e7b8f88a-4fd5-4e21-91f2-f7d9fa6b6211646bdd3b-9ec6-4301-83a5-dce02b404e9bDC2A4B43-7D57-4DC0-BB0E-1ECD99965CE7";
    NSString *fileName = @"MzAxZWUxZmYxM2YtYjg2MS00YzU0LTliNDItYjlmOTQ3Yzc4MTcyNjQ2YmRkM2ItOWVjNi00MzAxLTgzYTUtZGNlMDJiNDA0ZTliMTYwNTU0MjQwMDAwMERDMkE0QjQzLTdENTctNERDMC1CQjBFLTFFQ0Q5OTk2NUNFNw==.pdf";

    NSURL *URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //判断是否存在
    if ([self isFileExist:fileName]) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        self.fileURL = url;
        
        
        NSLog(@"URL = %@",URL);
//        [self.webView loadRequest:[NSURLRequest requestWithURL:self.fileURL]];
        [self.webView loadFileURL:self.fileURL allowingReadAccessToURL:self.fileURL];
    } else {
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){

        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
            return url;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            self.fileURL = filePath;
            //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
//            [self.webView loadRequest:[NSURLRequest requestWithURL:self.fileURL]];
            [self.webView loadFileURL:self.fileURL allowingReadAccessToURL:self.fileURL];
        }];
        [downloadTask resume];
    }
}

/**
 判断文件是否已经在沙盒中存在
 @param fileName 文件名
 @return 1:存在 0:不存在
 */
- (BOOL)isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

-(NSURL *)readFile:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    return url;
}


@end
