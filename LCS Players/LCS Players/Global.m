//
//  Global.m
//  LCS Players
//
//  Created by iD Student on 7/17/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "Global.h"

@implementation Global
static NSMutableArray* IGNNAArray;
+(NSMutableArray*)getIGNNAArray{
    if(IGNNAArray == nil){
        IGNNAArray = [[NSMutableArray alloc] init];
    }
    return IGNNAArray;
}



static NSMutableArray* IGNEUArray;
+(NSMutableArray*)getIGNEUArray{
    if(IGNEUArray == nil){
        IGNEUArray = [[NSMutableArray alloc] init];
    }
    return IGNEUArray;
}
@end