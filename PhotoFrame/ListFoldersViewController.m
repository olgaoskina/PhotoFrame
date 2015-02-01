//
//  ListFoldersViewController.m
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import "ListFoldersViewController.h"

@implementation ListFoldersViewController
{
    YandexFoldersDownloader *downloader;
    NSString *token;
    NSArray *folders;
}

@synthesize tableView=_tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    downloader = [[YandexFoldersDownloader alloc] initWithPath:@"/" andToken:token];
    folders = [downloader getFolders:@"/"];
    [_tableView reloadData];
}

-(void) setToken: (NSString*)newToken
{
    token = newToken;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"IN ListFoldersViewController:tableView [COUNT FOLDERS]: %lu", (unsigned long)[folders count]);
    return [folders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"FoldersTable";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [[folders objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
