//
//  ViewController.h
//  PhotoFrame
//
//  Created by Olga Oskina on 15/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YandexDownloader.h"
#import "Downloader.h"

#define URL_SCHEME @"photoframe"
#define URL_TO_GET_TOKEN @"https://oauth.yandex.ru/authorize?response_type=token&client_id=8d16cb6010c44044a6a74e9d17ad989a"

@interface ViewController : UIViewController
{
     id<Downloader> yandexDownloader;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

