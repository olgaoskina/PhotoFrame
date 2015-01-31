//
//  WebViewController.h
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseFolderViewController.h"

#define URL_SCHEME @"photoframe"
#define URL_TO_GET_TOKEN @"https://oauth.yandex.ru/authorize?response_type=token&client_id=8d16cb6010c44044a6a74e9d17ad989a"

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
