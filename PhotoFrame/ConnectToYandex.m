//
//  ConnectToYandex.m
//  PhotoFrame
//
//  Created by Olga Oskina on 16/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#import "ConnectToYandex.h"

@implementation ConnectToYandex


-(void)getResources
{

}

-(void)methodGET:(NSString*)path
{
//    "Authorization: OAuth 0fae2bbef7a34adaabc8a830f29b6c67"
    NSURL *url = [NSURL URLWithString:[@"https://cloud-api.yandex.net:443/v1/disk/resources/download?path=" stringByAppendingString:path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"OAuth 0fae2bbef7a34adaabc8a830f29b6c67" forHTTPHeaderField:@"Authorization"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!connection)
    {
        NSLog(@"connection failed");
    } else
    {
        NSLog(@"connection succeeded");
    }
}

-(UIImage*)getImage
{
    return [UIImage imageWithData:_responseData];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"IN CONNECTION didReceiveResponse");
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"IN CONNECTION didReceiveData");
    NSLog(@"%@", data);
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error {
    NSString *errorString = [[NSString alloc] initWithFormat:@"Connection failed! Error - %@ %@ %@",
                             [error localizedDescription],
                             [error description],
                             [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
    NSLog(@"%@", errorString);
}
@end