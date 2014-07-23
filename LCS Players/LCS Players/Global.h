//
//  Global.h
//  LCS Players
//
//  Created by iD Student on 7/17/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirstViewController.h"
#import "GrabData.h"

@interface Global : NSObject
+(NSMutableArray*)getIGNNAArray;
+(NSMutableArray*)getIGNEUArray;

+(void)setFVC:(FirstViewController*)fvc;
+(FirstViewController*)getFVC;

+(NSLock*)getNaLock;




@end
