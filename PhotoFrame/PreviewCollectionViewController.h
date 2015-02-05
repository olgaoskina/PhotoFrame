//
//  PreviewCollectionViewController.h
//  PhotoFrame
//
//  Created by Olga Oskina on 03/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YandexPhotosDownloader.h"
#import "ShowPhotosViewController.h"
#import "PhotoCell.h"

@interface PreviewCollectionViewController : UICollectionViewController {
    NSString *token;
    NSString *folder;
    YandexPhotosDownloader *downloader;
}
@property(strong, nonatomic) IBOutlet UICollectionView *photosCollectionView;

- (void)setFolder:(NSString *)newFolder;

- (void)setToken:(NSString *)newToken;

@end
