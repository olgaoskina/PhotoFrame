//
//  FoldersDownloader.h
//  PhotoFrame
//
//  Created by Olga Oskina on 01/02/15.
//  Copyright (c) 2015 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_FoldersDownloader_h
#define PhotoFrame_FoldersDownloader_h

@protocol FoldersDownloader

-(NSDictionary*)getFolders:(NSString*)onPath;
-(instancetype)initWithPath:(NSString*) path andToken:(NSString*)token;

@end

#endif
