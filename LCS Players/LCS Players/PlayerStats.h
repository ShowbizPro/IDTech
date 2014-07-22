//
//  PlayerStats.h
//  LCS Players
//
//  Created by iD Student on 7/17/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerStats : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ign;
@property (nonatomic, strong) NSString *team;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *avgKDA;
@property (nonatomic, strong) NSString *avgGoldPerMin;
@property (nonatomic, strong) NSString *avgTotalGold;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) UIImageView *photo;


@end
