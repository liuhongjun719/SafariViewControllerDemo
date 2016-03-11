//
//  SafariViewController.m
//  CollectFrameDemo
//
//  Created by 123456 on 16/3/11.
//  Copyright © 2016年 123456. All rights reserved.
//
//SFSafariViewController ：通过SFSafariViewController，你几乎可以使用所有Safari的一些便利特性，而无需让用户离开你的应用。
#import "SafariViewController.h"
#import <SafariServices/SafariServices.h>

@interface SafariViewController ()<SFSafariViewControllerDelegate>

@end

@implementation SafariViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- SFSafariViewController
- (IBAction)showSafariAction:(id)sender {
    SFSafariViewController *controller = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    controller.delegate = self;
    //    [self presentViewController:controller animated:YES completion:nil];
    [self.navigationController pushViewController:controller animated:YES];
    [self setBackBarbuttonItemStyle];
}

- (void)setBackBarbuttonItemStyle {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"上一页"
                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    // 设置返回按钮的背景图片
    UIImage *img = [UIImage imageNamed:@"popBack"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:img
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    // 设置文本与图片的偏移量
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
    // 设置文本的属性
    NSDictionary *attributes = @{UITextAttributeFont:[UIFont systemFontOfSize:16],
                                 UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

#pragma mark- SFSafariViewControllerDelegate
#pragma mark 只有执行presentViewController方法时会调用(点击done按钮时执行)，如果执行pushViewController方法，则不执行
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
}

#pragma mark 当点击界面的按钮可以弹出 UIActivityViewController 弹出框时会调用
- (NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(nullable NSString *)title {
    NSLog(@"stringURL-------:%@", [URL absoluteString]);//stringURL-------:https://www.baidu.com/
    
    NSLog(@"title=======:%@", title);//title=======:百度一下
    return nil;
}

#pragma mark 刚进入界面请求完url(https://www.baidu.com)后回执行，进入界面后，点击该界面中的按钮进行url请求时不会再调用该方法
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    view.backgroundColor = [UIColor yellowColor];
    [controller.view addSubview:view];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setTitle:@"Color" forState:UIControlStateNormal];
    nextButton.frame = CGRectMake(10, 10, 50, 50);
    nextButton.backgroundColor = [UIColor purpleColor];
    [nextButton addTarget:self action:@selector(nextPageAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:nextButton];
}

- (void)nextPageAction:(UIButton *)sender {
    if (sender.superview.backgroundColor == [UIColor yellowColor]) {
        sender.superview.backgroundColor = [UIColor purpleColor];
    }else {
        sender.superview.backgroundColor = [UIColor yellowColor];
    }
}

@end
