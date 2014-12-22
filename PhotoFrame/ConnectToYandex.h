//
//  ConnectToYandex.h
//  PhotoFrame
//
//  Created by Olga Oskina on 16/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#ifndef PhotoFrame_ConnectToYandex_h
#define PhotoFrame_ConnectToYandex_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConnectToYandex : NSObject
{
    NSMutableData *_responseData;
}

-(void)methodGET:(NSString*)path;
-(UIImage*)getImage;

@end


#endif
