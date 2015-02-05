//
//  ListFoldersTableViewController.h
//  PhotoFrame
//
//  Created by Olga Oskina on 02/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YandexFolderDownloader.h"
#import "PreviewCollectionViewController.h"

@interface ListFoldersTableViewController : UITableViewController {
    NSArray *folders;
    YandexFoldersDownloader *downloader;
    NSString *token;
}
@property(weak, nonatomic) IBOutlet UINavigationItem *currentFolder;
@property(weak, nonatomic) IBOutlet UILabel *countPhotosInFolder;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property(weak, nonatomic) NSString *currentPath;

- (void)setToken:(NSString *)newToken;

- (void)setTitle:(NSString *)newTitle;

@end
