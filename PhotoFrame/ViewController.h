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

@interface ViewController : UIViewController
{
     YandexDownloader *yandexDownloader;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end

