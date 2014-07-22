//
//  FirstViewController.h
//  LCS Players
//
//  Created by iD Student on 7/16/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCell.h"
#import "ViewControllerInfoPage.h"
#import "PlayerStats.h"
#import "GrabData.h"
@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	
    NSMutableArray *localNAArray;
    NSMutableArray *localEUArray;
    GrabData *localGrabData;
}

- (IBAction)Segment:(id)sender;


@property (weak, nonatomic) IBOutlet UISegmentedControl *outSegment;

@property (weak, nonatomic) IBOutlet UITableView *dataTable;


@property (nonatomic) NSInteger indexSelection;


@property (nonatomic) NSArray *playerNamers;
@property (nonatomic) NSArray *playerNamersEU;

@property (nonatomic) bool NA;


@property (weak, nonatomic) ViewControllerInfoPage *VCIP;








@end
