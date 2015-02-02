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
@synthesize currentPath=_currentPath;

- (void)viewDidLoad
{
    NSLog(@"IN ListFoldersTableViewController:viewDidLoad");
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    downloader = [[YandexFoldersDownloader alloc] initWithToken:token];
    NSLog(@"IN ListFoldersTableViewController:viewDidAppear [CURRENT PATH]: %@", _currentPath);
    folders = [downloader getFolders:_currentPath];
    
    [self.tableView reloadData];
}

-(void) setToken: (NSString*)newToken
{
    token = newToken;
    NSLog(@"IN ListFoldersTableViewController:setToken [SETTED TOKEN]: %@", token);
}
-(void) setTitle: (NSString*)newTitle
{
    [_currentFolder setTitle: newTitle];
    NSLog(@"IN ListFoldersTableViewController:setTitle [SETTED TITLE MUST BE]: %@", newTitle);
    NSLog(@"IN ListFoldersTableViewController:setTitle [SETTED TITLE]: %@", [_currentFolder title]);
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ListFoldersTableViewController *nextFilesViewController = [storyboard instantiateViewControllerWithIdentifier:@"FilesViewController"];
    
    NSDictionary *selectedFolder = [folders objectAtIndex:indexPath.row];
    [nextFilesViewController setToken:token];
    [nextFilesViewController setTitle:[selectedFolder objectForKey:@"name"]];
    [nextFilesViewController setCurrentPath:[selectedFolder objectForKey:@"path"]];
    NSLog(@"IN ListFoldersTableViewController:tableView [TITLE]: %@", [selectedFolder objectForKey:@"name"]);
    
    [[self navigationController] pushViewController:nextFilesViewController animated:true];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"IN WebViewController:prepareForSegue [IDENTIFIER]: %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"sendFolder"])
    {
        [[segue destinationViewController] setToken:token];
        [[segue destinationViewController] setFolder:_currentPath];
        NSLog(@"IN ListFoldersTableViewController:prepareForSegue [TITLE]: %@",_currentPath);
    }
    else
    {
        [super prepareForSegue:segue sender:sender];
    }
}
@end
