//
//  PlayerStats.h
//  LCS Players
//
//  Created by iD Student on 7/17/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerStats : NSObject

@property (nonatomic, weak) NSString *name;
@property (nonatomic, weak) NSString *ign;
@property (nonatomic, weak) NSString *team;
@property (nonatomic, weak) NSString *position;
@property (nonatomic, weak) NSString *avgKDA;
@property (nonatomic, weak) NSString *avgGoldPerMin;
@property (nonatomic, weak) NSString *avgTotalGold; 
@property (nonatomic, weak) NSString *bio;


@end
