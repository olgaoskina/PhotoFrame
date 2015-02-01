//
//  YandexFoldersDownloader.m
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import "YandexFolderDownloader.h"

@implementation YandexFoldersDownloader

-(instancetype)initWithPath:(NSString*) path andToken:(NSString*)token
{
    self = [super init];
    if (self)
    {
        userToken = [NSString stringWithString:token];
        folders = [self getFolders:path];
    }
    return self;
}

-(NSArray*)getFolders:(NSString*)onPath
{
    NSArray *keys = [NSArray arrayWithObjects:@"path", nil];
    NSArray *values = [NSArray arrayWithObjects:onPath, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSData *json = [self methodGET:@"resources" withParameters:dictionary];
    NSLog(@"IN YandexFoldersDownloader:getFolders [FOLDERS COUNT]: %lu",  (unsigned long)[[self getFoldersFrom:json] count]);
    return [self getFoldersFrom:json];
}

-(NSData*)methodGET:(NSString*)operation withParameters:(NSDictionary*)parameters
{
    NSMutableString* stringUrl = [NSMutableString stringWithFormat:@"%@%@?", URL_TO_API, operation];
    
    for(NSString *key in [parameters allKeys])
    {
        NSString *value = [parameters valueForKey:key];
        [stringUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
    }
    NSRange range = NSMakeRange(stringUrl.length-1, 1);
    [stringUrl deleteCharactersInRange:range];
    
    NSURLRequest *request = [self createRequest: stringUrl];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (error == nil)
    {
        return data;
    } else
    {
        NSLog(@"[ERROR LOAD FROM YANDEX]: %@", error);
        return nil;
    }
}

-(NSURLRequest*) createRequest: (NSString*) stringUrl
{
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:[NSString stringWithFormat:@"OAuth %@", userToken] forHTTPHeaderField:@"Authorization"];
    return request;
}

-(NSMutableArray*)getFoldersFrom: (NSData*)json
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:json
                 options:0
                 error:&error];
    if(error)
    {
        NSLog(@"[ERROR WHEN LOAD JSON]: %@", error);
        return nil;
    }
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *embedded = object[@"_embedded"];
        NSArray *items = embedded[@"items"];
        for (NSDictionary *item in items)
        {
            NSString *path = item[@"path"];
            NSString *name = item[@"name"];
            NSString *type = item[@"type"];
            if ([type isEqualToString:@"dir"])
            {
                [result addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name, path, nil] forKeys:[NSArray arrayWithObjects:@"name", @"path", nil]]];
            }
        }
    }
    return result;
}

@end