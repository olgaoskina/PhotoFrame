//
//  YandexFolderDownloader.h
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_YandexFolderDownloader_h
#define PhotoFrame_YandexFolderDownloader_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FoldersDownloader.h"

#define URL_TO_API @"https://cloud-api.yandex.net:443/v1/disk/"

@interface YandexFoldersDownloader : NSObject <FoldersDownloader>
{
    NSString *userToken;
    NSArray *folders; // NSArray of NSDictionary (<name, path>)
}

@end

#endif
