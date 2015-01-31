//
//  ViewController.m
//  PhotoFrame
//
//  Created by Olga Oskina on 15/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#import "ChooseFolderViewController.h"

@implementation ChooseFolderViewController {
    NSString* token;
}
@synthesize folder=_folder;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IN viewDidLoad");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setToken: (NSString*)newToken
{
    token = newToken;
}

- (IBAction)showToken:(id)sender {
    _folder.text = token;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"[IDENTIFIER]: %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"sendFolder"])
    {
//        [[segue destinationViewController] setFolder:_folder.text];
    }
    else
    {
        [super prepareForSegue:segue sender:sender];
    }
}

@end
