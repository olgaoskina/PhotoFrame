//
//  ShowPhotosViewController.h
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YandexDownloader.h"

@interface ShowPhotosViewController : UIViewController

-(void) setFolder:(NSString*)newFolder;
-(void) setToken:(NSString*)newToken;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
