//
//  ListFoldersViewController.h
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YandexFolderDownloader.h"

@interface ListFoldersViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(void) setToken: (NSString*)newToken;
    
@end
