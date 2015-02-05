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
    NSLog(@"IN PreviewCollectionViewController:viewDidAppear [RELOAD DATA]");
}

-(void) prepareCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [flowLayout setItemSize:CGSizeMake(150, 150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_photosCollectionView setCollectionViewLayout:flowLayout];
    _photosCollectionView.bounces = YES;
}

-(void) setPhoto: (NSDictionary*) params
{
    NSIndexPath *indexPath = params[@"indexPath"];
    PhotoCell *cell = params[@"cell"];
    UIImage *photo = [downloader getImage:[downloader getPathsToPhotos][indexPath.row]];
    [cell.imageView performSelectorOnMainThread:@selector(setImage:)
                                     withObject:photo
                                  waitUntilDone:YES];
    NSLog(@"IN PreviewCollectionViewController:setPhoto [PHOTO SETTED]");
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
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"
                                                                forIndexPath:indexPath];
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:indexPath,@"indexPath",cell,@"cell", nil];
    
    cell.imageView.image = nil;
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSOperation *loadImgOp = [[NSInvocationOperation alloc] initWithTarget:self
                                                                  selector:@selector(setPhoto:)
                                                                    object:params];
    [queue addOperation:loadImgOp];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"IN PreviewCollectionViewController:numberOfSectionsInCollectionView");
    return 1;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"IN WebViewController:prepareForSegue [IDENTIFIER]: %@", [segue identifier]);
    NSIndexPath *selectedIndexPath = [[_photosCollectionView indexPathsForSelectedItems] objectAtIndex:0];
    if ([[segue identifier] isEqualToString:@"sendImage"])
    {
        [[segue destinationViewController] setToken:token];
        [[segue destinationViewController] setFolder:folder];
        [[segue destinationViewController] setIndexToFirstImage:selectedIndexPath.row];
    }
    else
    {
        [super prepareForSegue:segue sender:sender];
    }
}

@end
