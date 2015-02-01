//
//  Downloader.h
//  PhotoFrame
//
//  Created by Olga Oskina on 26/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_Downloader_h
#define PhotoFrame_Downloader_h

@protocol Downloader

-(UIImage*)getNextImage;
-(UIImage*)getPreviousImage;
-(NSArray*)getFiles:(NSString*)onPath;

@end

#endif
