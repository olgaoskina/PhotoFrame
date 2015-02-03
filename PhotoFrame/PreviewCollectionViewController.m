//
//  PreviewCollectionViewController.m
//  PhotoFrame
//
//  Created by Olga Oskina on 03/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import "PreviewCollectionViewController.h"

@implementation PreviewCollectionViewController

@synthesize photosCollectionView=_photosCollectionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"IN ShowPhotosViewController:viewDidLoad");
    [self prepareCollectionView];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"IN PreviewCollectionViewController:viewDidAppear");
    downloader = [[YandexPhotosDownloader alloc] initWithPath:folder andToken:token];
    [downloader setSize:@"S"];
    [_photosCollectionView reloadData];
}

-(void) prepareCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [flowLayout setItemSize:CGSizeMake(191, 160)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_photosCollectionView setCollectionViewLayout:flowLayout];
    _photosCollectionView.bounces = YES;
    [_photosCollectionView setShowsHorizontalScrollIndicator:NO];
    [_photosCollectionView setShowsVerticalScrollIndicator:NO];
}

-(void) setToken:(NSString*)newToken
{
    token = newToken;
}

-(void) setFolder:(NSString*)newFolder
{
    folder = newFolder;
}

// Collection view methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = [downloader getPathsToPhotos].count;
    NSLog(@"IN PreviewCollectionViewController:numberOfItemsInSection [COUNT]: %ld", (long)count);
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"IN PreviewCollectionViewController:cellForItemAtIndexPath");
    UICollectionViewCell *photoCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"PhotoCell"
                                    forIndexPath:indexPath];

    
    UIImage *photo = [downloader getImage:[downloader getPathsToPhotos][indexPath.row]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:photo];
    
    [photoCell addSubview:imageView];
    return photoCell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"IN PreviewCollectionViewController:numberOfSectionsInCollectionView");
    return 1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    NSLog(@"IN WebViewController:prepareForSegue [SEGUE]: %@", [segue ]);
    NSLog(@"IN WebViewController:prepareForSegue [IDENTIFIER]: %@", [segue identifier]);
    NSIndexPath *selectedIndexPath = [[_photosCollectionView indexPathsForSelectedItems] objectAtIndex:0];
    if ([[segue identifier] isEqualToString:@"sendImage"])
    {
        [[segue destinationViewController] setToken:token];
        [[segue destinationViewController] setFolder:folder];
        [[segue destinationViewController] setPathToFirstImage:[downloader getPathsToPhotos][selectedIndexPath.row]];
    }
    else
    {
        [super prepareForSegue:segue sender:sender];
    }
}

@end
