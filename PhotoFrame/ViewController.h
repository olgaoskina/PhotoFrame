//
//  ViewController.h
//  PhotoFrame
//
//  Created by Olga Oskina on 15/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadImage.h"

@interface ViewController : UIViewController
{
    DownloadImage *downloader;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end

