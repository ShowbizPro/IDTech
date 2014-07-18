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
	PS.name = @"Loudy";
	PS.team = @"Cloud10";
	PS.position = @"APC";
	PS.avgKDA = @"7.7";
	PS.avgGoldPerMin = @"500";
	PS.avgTotalGold = @"7k";
	//PS.photo = PS.photo setImage:[UIImage imageNamed:<#(NSString *)#>;
	PS.bio = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";


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

	ViewControllerInfoPage *VCIP = [self.storyboard instantiateViewControllerWithIdentifier:@"infoPage"];
	[self.navigationController pushViewController:VCIP animated:YES];
    self.indexSelection = indexPath.section;
  


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
