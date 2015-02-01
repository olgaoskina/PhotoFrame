//
//  ViewController.h
//  PhotoFrame
//
//  Created by Olga Oskina on 15/12/14.
//  Copyright (c) 2014 Olga Oskina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowPhotosViewController.h"


@interface ChooseFolderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *folder;

-(void) setToken: (NSString*)newToken;
@end

