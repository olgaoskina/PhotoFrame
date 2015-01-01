//
//  ViewController.m
//  PhotoFrame
//
//  Created by Olga Oskina on 15/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize imageView=_imageView;
@synthesize webView=_webView;

- (void)viewDidUnload
{
    _imageView = nil;
    yandexDownloader = nil;
    _webView = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://oauth.yandex.ru/authorize?response_type=token&client_id=8d16cb6010c44044a6a74e9d17ad989a"]];
    [_webView loadRequest:request];
    _webView.hidden = NO;
    
    
    
}

-(void)showPhotos:(NSString*) token
{
    self.view.backgroundColor = [UIColor blackColor];
    yandexDownloader = [[YandexDownloader alloc] initWithPath:@"/Google" andToken:token];
    [_imageView setImage:[yandexDownloader getImage]];
    [_imageView setContentMode:UIViewContentModeCenter];
    [self setSwipes];
}


-(void)setSwipes
{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    NSLog(@"Left swipe setted");

    UISwipeGestureRecognizer *swipeRigth = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(didSwipe:)];
    swipeRigth.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRigth];
     NSLog(@"Rigth swipe setted");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe
{

    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        NSLog(@"LEFT SWIPE");
        [yandexDownloader incrementIndex];
        [_imageView setImage:[yandexDownloader getImage]];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        NSLog(@"RIGTH SWIPE");
        [yandexDownloader decrementIndex];
        [_imageView setImage:[yandexDownloader getImage]];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //Получаем URL
    NSURL *url = [request URL];
    NSLog(@"[URL FROM REQUEST]: %@", url);
    NSLog(@"[URL SCHEME]: %@", url.scheme);
    
    
    //Проверяем на соответствие пользовательской URL-схеме
    if ([url.scheme isEqualToString:URL_SCHEME])
    {
        _webView.hidden = YES;
        //убираем индикатор сетевой активности
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = NO;
        
        //разбираем URL на отдельные элементы
        //наш токен будет в массиве arr под индексом 2
        NSArray *arr = [[url description] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#=&"]];
        NSLog(@"[TOKEN]: %@", [arr objectAtIndex:2]);
        
        [self showPhotos:[arr objectAtIndex:2]];

        //запрещаем UIWebView открывать URL
        return NO;
    }
    
    //разрешаем UIWebView переход по URL
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}


@end
