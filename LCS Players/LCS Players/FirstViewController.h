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
@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	bool NA;
    NSMutableArray *localNAArray;
    NSMutableArray *localEUArray;
}

- (IBAction)Segment:(id)sender;


@property (weak, nonatomic) IBOutlet UISegmentedControl *outSegment;

@property (weak, nonatomic) IBOutlet UITableView *dataTable;


@property (nonatomic) NSInteger indexSelection;

+ (NSMutableArray *)getIGNArray;


@property (weak, nonatomic) ViewControllerInfoPage *VCIP;








@end
