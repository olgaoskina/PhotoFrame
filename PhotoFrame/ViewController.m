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


- (void)viewDidUnload
{
    _imageView = nil;
    yandexDownloader = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    yandexDownloader = [[YandexDownloader alloc] initWithPath:@"/Google"];
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

@end
