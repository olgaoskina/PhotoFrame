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

#import "FoldersDownloader.h"
#import "Downloader.h"

@interface YandexFoldersDownloader : Downloader <FoldersDownloader> {
    long countPhotos;
}

- (long)getCountPhotosInFolder;

@end

#endif
