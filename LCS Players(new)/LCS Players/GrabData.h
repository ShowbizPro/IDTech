//
//  GrabData.h
//  LCS Players
//
//  Created by iD Student on 7/18/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerStats.h"
#import "TFHpple.h"
#import "AppDelegate.h"


@interface GrabData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
+ (PlayerStats*)getData:(NSString*)playerName;
+(PlayerStats*)getEUData:(NSString*)playerName;


+(PlayerStats*)getProfileInfo:(TFHpple*)playerParser PS:(PlayerStats*)PS;
+(PlayerStats*)getPhoto:(TFHpple*)playerParser PS:(PlayerStats*)PS;
+(PlayerStats*)getStats:(TFHpple*)playerParser PS:(PlayerStats*)PS;
+(PlayerStats*)getBio:(TFHpple*)playerParser PS:(PlayerStats*)PS;

+ (void)saveData:(NSString*)regionString PS:(PlayerStats*)PS;

+ (void)findContactNA;

@end
