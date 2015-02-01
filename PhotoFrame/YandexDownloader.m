//
//  ConnectToYandex.m
//  PhotoFrame
//
//  Created by Olga Oskina on 16/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#import "YandexDownloader.h"

@implementation YandexDownloader

-(instancetype)initWithPath:(NSString*) path andToken:(NSString*)token;
{
    NSLog(@"In initWithPath [PATH]: %@", path);
    self = [super init];
    if (self)
    {
        index = 0;
        userToken = [NSString stringWithString:token];
        pathsToPhotos = [self getFiles:path];
    }
    return self;
}

-(NSArray*)getFiles:(NSString *)onPath
{
    NSArray *keys = [NSArray arrayWithObjects:@"path", nil];
    NSArray *values = [NSArray arrayWithObjects:onPath, nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSData *json = [self methodGET:@"resources" withParameters:dictionary];
    NSArray *array = [self getResourcesFrom:json];
    NSLog(@"[PATHS]: %@", array);
    
    return array;
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
    NSLog(@"[URL FROM DOWNLOAD]: %@", stringUrl);
    
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:[NSString stringWithFormat:@"OAuth %@", userToken] forHTTPHeaderField:@"Authorization"];
    
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

-(UIImage*) getImage:(NSString*)onPath
{
    NSArray *keys = [NSArray arrayWithObjects:@"path", @"preview_size", nil];
    NSArray *values = [NSArray arrayWithObjects:onPath, @"M", nil];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:values forKeys:keys];
    NSData *data = [self methodGET:@"resources" withParameters:dictionary];
    NSString* stringFromData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString* urlWithPhoto = [self getStringFrom:data withName:@"preview"];
    NSLog(@"%@", [@"[LOAD FROM YANDEX]: " stringByAppendingString:stringFromData]);
    
    return [self downloadImage:urlWithPhoto];
}

-(UIImage*) getNextImage
{
    [self incrementIndex];
    return [self getImage:[pathsToPhotos objectAtIndex:index]];
}

-(UIImage*) getPreviousImage
{
    [self decrementIndex];
    return [self getImage:[pathsToPhotos objectAtIndex:index]];
}

-(UIImage*)downloadImage:(NSString*)stringUrl
{
    NSLog(@"[START LOAD IMAGE]");
    
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"OAuth 0fae2bbef7a34adaabc8a830f29b6c67" forHTTPHeaderField:@"Authorization"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    
    UIImage *image = [[UIImage alloc] initWithData:data];
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSLog(@"[STOP LOAD IMAGE]");
    return image;
}

-(NSString*)getStringFrom: (NSData*)json withName:(NSString*)name
{
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:json
                 options:0
                 error:&error];
    if(error)
    {
        NSLog(@"[ERROR WHEL LOAD JSON]: %@", error);
    }
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"[HREF]: %@",[object valueForKey:name]);
        return object[name];
    }
    return nil;
}

-(NSArray*)getResourcesFrom: (NSData*)json
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:json
                 options:0
                 error:&error];
    if(error)
    {
        NSLog(@"[ERROR WHEL LOAD JSON]: %@", error);
        return nil;
    }
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *embedded = object[@"_embedded"];
        NSArray *items = embedded[@"items"];
        NSLog(@"[items]: %@", items);
        for (NSDictionary *item in items)
        {
            NSString *path = item[@"path"];
            NSString *type = item[@"type"];
            if ([type isEqualToString:@"file"])
            {
                NSString *mimeType = item[@"mime_type"];
                if ([mimeType containsString:@"image"])
                {
                    [result addObject:path];
                }
            }
        }
    }
    return result;
}


-(void)incrementIndex
{
    index = index == pathsToPhotos.count - 1 ? 0: index + 1;
    NSLog(@"%lu", index);
}

-(void)decrementIndex
{
    index = index == 0 ? pathsToPhotos.count - 1: index - 1;
    NSLog(@"%lu", index);
}






@end