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
@synthesize folderTextField=_folderTextField;
@synthesize showButton=_showButton;
@synthesize folderLabel=_folderLabel;
@synthesize scrollView=_scrollView;

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
    _webView.hidden = YES;
    _scrollView.hidden = YES;
    _scrollView.contentSize = _imageView.frame.size;
    [_scrollView addSubview:_imageView];
    _scrollView.minimumZoomScale = _scrollView.frame.size.width / _imageView.frame.size.width;
    _scrollView.maximumZoomScale = 2.0;
    [_scrollView setZoomScale:_scrollView.minimumZoomScale];
}

-(void)showPhotos:(NSString*) token
{
    _scrollView.hidden = NO;
    self.view.backgroundColor = [UIColor blackColor];
    yandexDownloader = [[YandexDownloader alloc] initWithPath:PATH_TO_PHOTOS andToken:token];
    [_imageView setImage:[yandexDownloader getNextImage]];
    [_imageView setContentMode:UIViewContentModeCenter];
    [self setSwipesAndTaps];
}

-(void)setSwipesAndTaps
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
    
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwice:)];
    
    tapTwice.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:tapTwice];
    NSLog(@"Taps setted");
}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe
{

    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        NSLog(@"[LEFT SWIPE]");
        [_imageView setImage:[yandexDownloader getNextImage]];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        NSLog(@"[RIGTH SWIPE]");
        [_imageView setImage:[yandexDownloader getPreviousImage]];
    }
}


// WebView methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];

    if ([url.scheme isEqualToString:URL_SCHEME])
    {
        _webView.hidden = YES;
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = NO;
        NSArray *arr = [[url description] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#=&"]];
        
        [self showPhotos:[arr objectAtIndex:2]];
        
        return NO;
    }
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

- (void)viewDidLayoutSubviews {
    _webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (IBAction)showPhotosAction:(UIButton *)sender {
    PATH_TO_PHOTOS = _folderTextField.text;

    if (![@"" isEqualToString:PATH_TO_PHOTOS]) {
        _folderLabel.hidden = YES;
        _folderTextField.hidden = YES;
        _showButton.hidden = YES;
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_TO_GET_TOKEN]];
        [_webView loadRequest:request];
        _webView.hidden = NO;
    }
}

- (void)tapTwice:(UIGestureRecognizer *)gesture
{
    NSLog(@"[TWICE TAP]");
    if (_scrollView.zoomScale == 2) {
        [_scrollView setZoomScale:1];
    } else {
        [_scrollView setZoomScale:2];
    }
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}


@end
