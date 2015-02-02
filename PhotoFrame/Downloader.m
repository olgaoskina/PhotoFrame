//
//  Downloader.m
//  PhotoFrame
//
//  Created by Olga Oskina on 02/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader

- (NSURLRequest *)createRequest:(NSString *)stringUrl withToken:(NSString *)userToken {
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:[NSString stringWithFormat:@"OAuth %@", userToken] forHTTPHeaderField:@"Authorization"];
    return request;
}

- (NSData *)methodGET:(NSString *)userToken operation:(NSString *)operation withParameters:(NSDictionary *)parameters {
    NSMutableString *stringUrl = [NSMutableString stringWithFormat:@"%@%@?", URL_TO_API, operation];

    for (NSString *key in [parameters allKeys]) {
        NSString *value = [parameters valueForKey:key];
        [stringUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
    }
    NSRange range = NSMakeRange(stringUrl.length - 1, 1);
    [stringUrl deleteCharactersInRange:range];

    NSURLRequest *request = [self createRequest:stringUrl withToken:userToken];

    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (error == nil) {
        return data;
    } else {
        NSLog(@"[ERROR LOAD FROM YANDEX]: %@", error);
        return nil;
    }
}

@end