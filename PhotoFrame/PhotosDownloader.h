//
//  Downloader.h
//  PhotoFrame
//
//  Created by Olga Oskina on 26/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_PhotosDownloader_h
#define PhotoFrame_PhotosDownloader_h

#import <UIKit/UIKit.h>

@protocol PhotosDownloader

-(UIImage*)getNextImage;
-(UIImage*)getPreviousImage;
-(NSArray*)getFiles:(NSString*)onPath;
-(instancetype)initWithPath:(NSString*) path andToken:(NSString*)token;

@end

#endif
