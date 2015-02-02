//
//  YandexFoldersDownloader.m
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#import "YandexFolderDownloader.h"

@implementation YandexFoldersDownloader

- (instancetype)initWithPath:(NSString *)path andToken:(NSString *)token {
    self = [super init];
    if (self) {
        self.userToken = [NSString stringWithString:token];
    }
    return self;
}

- (NSArray *)getFolders:(NSString *)onPath {
    NSArray *keys = [NSArray arrayWithObjects:@"path", nil];
    NSArray *values = [NSArray arrayWithObjects:onPath, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSData *json = [self methodGET:self.userToken operation:@"resources" withParameters:dictionary];
    NSLog(@"IN YandexFoldersDownloader:getFolders [FOLDERS COUNT]: %lu", (unsigned long) [[self getFoldersFrom:json] count]);
    return [self getFoldersFrom:json];
}

- (NSArray *)getFoldersFrom:(NSData *)json {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSError *error = nil;
    id object = [NSJSONSerialization
            JSONObjectWithData:json
                       options:0
                         error:&error];
    if (error) {
        NSLog(@"[ERROR WHEN LOAD JSON]: %@", error);
        return nil;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *embedded = object[@"_embedded"];
        NSArray *items = embedded[@"items"];
        for (NSDictionary *item in items) {
            NSString *path = item[@"path"];
            NSString *name = item[@"name"];
            NSString *type = item[@"type"];
            if ([type isEqualToString:@"dir"]) {
                [result addObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:name, path, nil] forKeys:[NSArray arrayWithObjects:@"name", @"path", nil]]];
            }
        }
    }
    return result;
}

@end