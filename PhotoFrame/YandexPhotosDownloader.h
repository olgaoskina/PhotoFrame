//
//  YandexPhotosDownloader.h
//  PhotoFrame
//
//  Created by Olga Oskina on 16/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_YandexPhotosDownloader_h
#define PhotoFrame_YandexPhotosDownloader_h

#import <Foundation/Foundation.h>
#import "PhotosDownloader.h"
#import "Downloader.h"

@interface YandexPhotosDownloader : Downloader <PhotosDownloader> {
    NSArray *pathsToPhotos;
    unsigned long index;
}
@end


#endif
