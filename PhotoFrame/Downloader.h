//
//  Downloader.h
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_Downloader_h
#define PhotoFrame_Downloader_h

#import <UIKit/UIKit.h>

#define URL_TO_API @"https://cloud-api.yandex.net:443/v1/disk/"

@interface Downloader : NSObject

@property(readwrite) NSString *userToken;

- (NSURLRequest *)createRequest:(NSString *)stringUrl withToken:(NSString *)userToken;

- (NSData *)methodGET:(NSString *)userToken operation:(NSString *)operation withParameters:(NSDictionary *)parameters;

@end

#endif
