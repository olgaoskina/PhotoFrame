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
    NSInteger indexToFirstImage;
    YandexPhotosDownloader *downloader;
}

@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareScrollView];
    [self prepareImageView];
    [self prepareSwipeHandling];
    [self prepareTapHandling];
    NSLog(@"IN ShowPhotosViewController:viewDidLoad");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"IN ShowPhotosViewController:viewDidAppear");
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSOperation *loadImgOp = [[NSInvocationOperation alloc] initWithTarget:self
                                                                  selector:@selector(setNextImage)
                                                                    object:nil];
    NSOperation *prepareDownloader = [[NSInvocationOperation alloc] initWithTarget:self
                                                                          selector:@selector(prepareDownloader)
                                                                            object:nil];
    [loadImgOp addDependency:prepareDownloader];
    [queue addOperation:prepareDownloader];
    [queue addOperation:loadImgOp];
}

- (void)prepareDownloader {
    NSLog(@"IN ShowPhotosViewController:prepareDownloader");
    YandexPhotosDownloader *localDownloader = [[YandexPhotosDownloader alloc] initWithPath:folder andToken:token];
    [localDownloader setIndex:indexToFirstImage];

    [self performSelectorOnMainThread:@selector(setDownloader:)
                           withObject:localDownloader
                        waitUntilDone:YES];
}

- (void)prepareImageView {
    [_imageView setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)prepareScrollView {
    _scrollView.contentSize = _imageView.frame.size;
    [_scrollView addSubview:_imageView];
    _scrollView.minimumZoomScale = _scrollView.frame.size.width / _imageView.frame.size.width;
    _scrollView.maximumZoomScale = 4.0;
    [_scrollView setZoomScale:_scrollView.minimumZoomScale];
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}

- (void)prepareSwipeHandling {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    NSLog(@"IN ShowPhotosViewController:prepareSwipeHandling [LEFT SWIPE SETTED]");

    UISwipeGestureRecognizer *swipeRigth = [[UISwipeGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(didSwipe:)];
    swipeRigth.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRigth];
    NSLog(@"IN ShowPhotosViewController:prepareSwipeHandling [RIGTH SWIPE SETTED]");
}

- (void)prepareTapHandling {
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwice:)];
    tapTwice.numberOfTapsRequired = 2;
    [_scrollView addGestureRecognizer:tapTwice];
    NSLog(@"IN ShowPhotosViewController:prepareTapHandling TAPS SETTED");
}

- (void)setNextImage {
    NSLog(@"IN ShowPhotosViewController:loadImageInBackground");
    UIImage *photo = [downloader getNextImage];
    [_imageView performSelectorOnMainThread:@selector(setImage:)
                                 withObject:photo
                              waitUntilDone:YES];
}

- (void)didSwipe:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [_imageView setImage:[downloader getNextImage]];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [_imageView setImage:[downloader getPreviousImage]];
    }
}

- (void)tapTwice:(UIGestureRecognizer *)gesture {
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

- (void)setToken:(NSString *)newToken {
    token = newToken;
}

- (void)setDownloader:(YandexPhotosDownloader *)newDownloader {
    downloader = newDownloader;
}

- (void)setFolder:(NSString *)newFolder {
    folder = newFolder;
}

- (void)setIndexToFirstImage:(NSInteger)newIndex {
    indexToFirstImage = newIndex;
}

// ScrollView methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [_scrollView flashScrollIndicators];
}

@end
