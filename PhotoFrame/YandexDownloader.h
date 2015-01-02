//
//  ConnectToYandex.h
//  PhotoFrame
//
//  Created by Olga Oskina on 16/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_ConnectToYandex_h
#define PhotoFrame_ConnectToYandex_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Downloader.h"

#define URL_TO_API @"https://cloud-api.yandex.net:443/v1/disk/"

@interface YandexDownloader : NSObject <Downloader>
{
    NSArray *pathsToPhotos;
    NSString *userToken;
    unsigned long index;
}
-(instancetype)initWithPath:(NSString*) path andToken:(NSString*)token;
@end


#endif
