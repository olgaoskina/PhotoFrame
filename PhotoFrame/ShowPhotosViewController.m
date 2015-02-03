//
//  ShowPhotosViewController.m
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import "ShowPhotosViewController.h"

@implementation ShowPhotosViewController {
    NSString *token;
    NSString *folder;
    NSString *pathToFirstImage;
    YandexPhotosDownloader *downloader;
}

@synthesize scrollView=_scrollView;
@synthesize imageView=_imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"IN ShowPhotosViewController:viewDidLoad");
    [self prepareScrollView];
    [self prepareImageView];
    [self prepareSwipeHandling];
    [self prepareTapHandling];
}

- (void)viewDidAppear:(BOOL)animated
{
    downloader = [[YandexPhotosDownloader alloc] initWithPath:folder andToken:token];
    [_imageView setImage:[downloader getImage:pathToFirstImage]];
}

-(void) prepareImageView
{
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
}

-(void) prepareScrollView
{
    _scrollView.contentSize = _imageView.frame.size;
    [_scrollView addSubview:_imageView];
    _scrollView.minimumZoomScale = _scrollView.frame.size.width / _imageView.frame.size.width;
    _scrollView.maximumZoomScale = 4.0;
    [_scrollView setZoomScale:_scrollView.minimumZoomScale];
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}

-(void)prepareSwipeHandling
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

-(void) prepareTapHandling
{
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTwice:)];
    tapTwice.numberOfTapsRequired = 2;
    [_scrollView addGestureRecognizer:tapTwice];
    NSLog(@"IN ShowPhotosViewController:prepareTapHandling TAPS SETTED");
}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [_imageView setImage:[downloader getNextImage]];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [_imageView setImage:[downloader getPreviousImage]];
    }
}

- (void)tapTwice:(UIGestureRecognizer *)gesture
{
    if ([_scrollView zoomScale] != _scrollView.minimumZoomScale) {
        CGRect rect = [_scrollView frame];
        [_scrollView zoomToRect:rect animated:YES];
        NSLog(@"IN ShowPhotosViewController:tapTwice [ZOOM SCALE]: %f", [_scrollView zoomScale]);
    } else {
        CGPoint center = [gesture locationInView:_scrollView];
        CGRect rect = CGRectMake(center.x - 50, center.y - 50, 100, 100);
        [_scrollView zoomToRect:rect animated:YES];
        NSLog(@"IN ShowPhotosViewController:tapTwice [ZOOM SCALE]: %f", [_scrollView zoomScale]);
    }
}

-(void) setToken:(NSString*)newToken
{
    token = newToken;
}

-(void) setFolder:(NSString*)newFolder
{
    folder = newFolder;
}

-(void) setPathToFirstImage:(NSString*)newPath
{
    pathToFirstImage = newPath;
}

// ScrollView methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [_scrollView flashScrollIndicators];
}

@end
