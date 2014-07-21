//
//  GrabData.h
//  LCS Players
//
//  Created by iD Student on 7/18/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerStats.h"

@interface GrabData : NSObject{
    
    
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
+ (PlayerStats*)getData:(NSString*)playerName;
@end
