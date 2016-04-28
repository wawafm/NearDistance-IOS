//
//  VillageNewsDetailViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "VillageNewsDetailViewController.h"

@interface VillageNewsDetailViewController ()

@end

@implementation VillageNewsDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [USERDEFAULT setObject:@"messageDetail" forKey:@"mess_detail"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"消息详情"];
    
    NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: %d; color: %@;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>", 14,kUIColorFromRGB(BLACK_COLOR), _content];
    [_newsWebView loadHTMLString:jsString baseURL:nil];
    [self.newsWebView stringByEvaluatingJavaScriptFromString:jsString];
    [(UIScrollView *)[[_newsWebView subviews] objectAtIndex:0] setBounces:NO];
    _newsWebView.userInteractionEnabled = YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
