//
//  DownloadImage.m
//  PhotoFrame
//
//  Created by Olga Oskina on 16/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//


#import "DownloadImage.h"


@implementation DownloadImage

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        index = 0;
//        connectToYandex = [[ConnectToYandex alloc] init];
        imagesUrl = [NSArray arrayWithObjects:
                     @"http://wallpaperpassion.com/upload_big_thumb/7238/city-nights-photo.jpg",
                     @"http://www.anywalls.com/pic/201211/480x800/anywalls.com-33381.jpg",
                     @"http://www.fonstola.ru/pic/201201/320x480/fonstola.ru-68319.jpg",
                     @"http://www.graphicsdb.com/data/media/774/curacao_1__iphone_wallpaper.jpg",
                     @"http://grandwallpapers.net/photo/zelenaya-trava-480x640.jpg",
                     nil];
    }
    return self;
}

-(UIImage*)downloadImage:(NSString*)stringUrl
{
    NSLog(@"[START LOAD IMAGE]");
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    NSLog(@"%@", data);
    NSLog(@"[STOP LOAD IMAGE]");
    return image;
}

-(UIImage*)getImage
{
    return [self downloadImage:[imagesUrl objectAtIndex:index]];
//    [connectToYandex methodGET:@"/chat.txt"];
//    UIImage *image = [connectToYandex getImage];
//    return image;
}

-(void)incrementIndex
{
    index = index == imagesUrl.count - 1 ? 0: index + 1;
    NSLog(@"%lu", index);
}

-(void)decrementIndex
{
    index = index == 0 ? imagesUrl.count - 1: index - 1;
    NSLog(@"%lu", index);
}

@end