//
//  ListFoldersTableViewController.m
//  PhotoFrame
//
//  Created by Olga Oskina on 02/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import "ListFoldersTableViewController.h"

@implementation ListFoldersTableViewController

@synthesize currentFolder=_currentFolder;

- (void)viewDidLoad
{
    NSLog(@"IN ListFoldersTableViewController:viewDidLoad");
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    downloader = [[YandexFoldersDownloader alloc] initWithPath:@"/" andToken:token];
    folders = [downloader getFolders:@"/"];
    [self.tableView reloadData];
}

-(void) setToken: (NSString*)newToken
{
    token = newToken;
}

-(void) setTitle: (NSString*)newTitle
{
    [_currentFolder setTitle:newTitle];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [folders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FolderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [[folders objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"IN WebViewController:prepareForSegue [IDENTIFIER]: %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"sendFolder"])
    {
        [[segue destinationViewController] setToken:token];
        [[segue destinationViewController] setFolder:[_currentFolder title]];
        NSLog(@"IN ListFoldersTableViewController:prepareForSegue [TITLE]: %@",[_currentFolder title]);
    }
    else
    {
        [super prepareForSegue:segue sender:sender];
    }
}
@end
