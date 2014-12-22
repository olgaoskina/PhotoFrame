//
//  DownloadImage.h
//  PhotoFrame
//
//  Created by Olga Oskina on 16/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_DownloadImage_h
#define PhotoFrame_DownloadImage_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConnectToYandex.h"


@interface DownloadImage : NSObject
{
//    ConnectToYandex *connectToYandex;
    NSArray *imagesUrl;
    unsigned long index;
}

-(UIImage*)downloadImage:(NSString*)stringUrl;

-(UIImage*)getImage;

-(void)incrementIndex;

-(void)decrementIndex;

@end

#endif
