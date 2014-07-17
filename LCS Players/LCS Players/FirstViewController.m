//
//  FirstViewController.m
//  LCS Players
//
//  Created by iD Student on 7/16/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "FirstViewController.h"
#import "Global.h"
#import "PlayerStats.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    PlayerStats *PS = [[PlayerStats alloc]init];
    
	localNAArray = [Global getIGNNAArray];
    localEUArray = [Global getIGNEUArray];
   
    PS.ign = @"PLAYER 1";
    
    [localNAArray addObject:PS];
    NA = true;
	// Do any additional setup after loading the view, typically from a nib.
	[self.dataTable setDelegate:self];
	[self.dataTable setDataSource:self];

	[self.dataTable reloadData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	if (NA) {
		return [localNAArray count];
	}
	else {
		return [localEUArray count];
	}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
        PlayerStats *PSNA = [localNAArray objectAtIndex:[indexPath row]];
    ViewControllerInfoPage *VCIP = [self.storyboard instantiateViewControllerWithIdentifier:@"infoPage"];
        [self.navigationController pushViewController:VCIP animated:YES];
        
        /*[self.VCIP.IGNLabel setText:PSNA.ign];
        [self.VCIP.NameLabel setText:PSNA.name];
        [self.VCIP.TeamLabel setText:PSNA.team];
        [self.VCIP.PositionLabel setText:PSNA.position];
        [self.VCIP.avgKDALabel setText:PSNA.avgKDA];
        [self.VCIP.avgGPMLabel setText:PSNA.avgGoldPerMin];
        [self.VCIP.avgGPTLabel setText:PSNA.avgTotalGold];
        [self.VCIP.bioTextView setText:PSNA.bio];*/
   
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"userCell";
	UserCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	if (NA) {
        PlayerStats *PSNA = [localNAArray objectAtIndex:[indexPath row]];
		[cell.IGNLabel setText:PSNA.ign];
	}
	else {
        PlayerStats *PSEU = [localEUArray objectAtIndex:[indexPath row]];
		[cell.IGNLabel setText:PSEU.ign];
	}

	// Configure the cell...

	return cell;
}

- (void)viewWillLayoutSubviews {
	UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
	if (orientation == UIDeviceOrientationLandscapeLeft) {
		//[self.bioTextView setFrame:CGRectMake(100,100,200,300)];
	}
}

- (IBAction)Segment:(id)sender {
	UISegmentedControl *segmentbutton = (UISegmentedControl *)sender;
	if (segmentbutton.selectedSegmentIndex == 0) {
		NA = true;
	}
	else if (segmentbutton.selectedSegmentIndex == 1) {
		NA = false;
	}


	[self.dataTable reloadData];
}

@end
