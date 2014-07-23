//
//  Global.m
//  LCS Players
//
//  Created by iD Student on 7/17/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "Global.h"
#import "FirstViewController.h"
#import "PlayerStats.h"
#import "GrabData.h"

@implementation Global
static NSMutableArray* IGNNAArray;
+(NSMutableArray*)getIGNNAArray{
    if(IGNNAArray == nil){
        IGNNAArray = [[NSMutableArray alloc] init];//WithCapacity:40];
    }
    return IGNNAArray;
}



static NSMutableArray* IGNEUArray;
+(NSMutableArray*)getIGNEUArray{
    if(IGNEUArray == nil){
        IGNEUArray = [[NSMutableArray alloc] init];//WithCapacity:40];
    }
    return IGNEUArray;
}

static FirstViewController* FVC;
+(FirstViewController*)getFVC{
    
    return FVC;
}
+(void)setFVC:(FirstViewController*)fvc{
    FVC = fvc;
}



static NSLock *nalock;
+(NSLock*)getNaLock{
    return nalock;
}


@end
