//
//  SecondViewController.m
//  TabCoreDataTemp
//
//  Created by 真有 津坂 on 12/03/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

//    ページをWebViewのサイズに合わせて表示するよう設定
    swimwebView.scalesPageToFit = YES;
    swimwebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
//    WebViewにdelegate先のオブジェクトを指定
    swimwebView.delegate = self;
    
//    「進む」、「戻る」ボタンを無効化する。
    bBarButton.enabled = NO;
    fBarButton.enabled = NO;
    
    
    NSURL *URL = [NSURL URLWithString:@"http://www.masters-swim.or.jp/competition/schedule.html"];
    NSURLRequest *URLreq = [NSURLRequest requestWithURL:URL];
    [swimwebView loadRequest: URLreq];
}


//指定されたURLのページをWebViewに表示する。
- (IBAction)openButtonPress:(id)sender{
    [swimwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://sites.google.com/site/propicaudio/"]]];
}

//次のページを表示する。
- (IBAction)forwardButtonPress:(id)sender{
    [swimwebView goForward];
}

//前のページを表示する。
- (IBAction)backButtonPress:(id)sender{
    [swimwebView goBack];
}

- (IBAction)mastersBtn:(id)sender {
    [swimwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.masters-swim.or.jp/competition/schedule.html"]]];
}

- (IBAction)owsBtn:(id)sender {
        [swimwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://sites.google.com/site/365swimming/top/taikaiichiran2013"]]];
}




- (void)webViewDidStartLoad:(UIWebView *)webView {
//    ページのロードが開始されたので、ステータスバーのロード中インジケータを表示する。
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    ページのロードが終了したので、ステータスバーのロード中インジケータを非表示にする。
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
//    ページの「進む」および「戻る」が可能かチェックし、各ボタンの有効／無効を指定する。
    bBarButton.enabled = [webView canGoBack];
    fBarButton.enabled = [webView canGoForward];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    エラーが発生したので、ステータスバーのロード中インジケータを非表示にする。
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
//    ロードキャンセルエラーの場合はエラー処理を行わない。
//    ページのロード途中に別のページを表示しようとした場合でも、このエラーが発生するが、
//    アプリの操作はそのまま続行できるため、エラー処理は行わない。
    if ([error code] != NSURLErrorCancelled) {
//        エラーの内容をWebView画面に表示する。
        NSString* errString = [NSString stringWithFormat:
                               @"<html><center><font size=+7 color='red'>エラーが発生しました。:<br>%@</font></center></html>",
                               error.localizedDescription];
        [webView loadHTMLString:errString baseURL:nil];
    }
}






- (void)viewDidUnload
{
    swimwebView.delegate = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
