//
//  WebViewController.m
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController {
    NSString* token;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"IN WebViewController:viewDidLoad");
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_TO_GET_TOKEN]];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"IN WebViewController:webView");
    NSURL *url = [request URL];
    
    if ([url.scheme isEqualToString:URL_SCHEME])
    {
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = NO;
        token = [[[url description]
                  componentsSeparatedByCharactersInSet:
                  [NSCharacterSet characterSetWithCharactersInString:@"#=&"]] objectAtIndex:2];
        
        [self performSegueWithIdentifier:@"sendToken" sender:self];
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"IN WebViewController:webViewDidStartLoad");
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"IN WebViewController:webViewDidFinishLoad");
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"IN WebViewController:prepareForSegue [IDENTIFIER]: %@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"sendToken"])
    {
        ListFoldersTableViewController *controller = [[[segue destinationViewController] viewControllers] objectAtIndex:0];
        [controller setToken:token];
        [controller setTitle:@"/"];
        NSLog(@"IN WebViewController:prepareForSegue [TITLE]: %@", controller.currentFolder.title);
    }
    else
    {
        [super prepareForSegue:segue sender:sender];
    }
}

@end
