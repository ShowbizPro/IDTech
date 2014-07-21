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
#import "GrabData.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
	[super viewDidLoad];


	localNAArray = [Global getIGNNAArray];
	localEUArray = [Global getIGNEUArray];

	[Global setFVC:self];
	PlayerStats *dexter=[GrabData getData:@"dexter-0"];
    [localNAArray addObject:dexter];
    
    PlayerStats *meteos=[GrabData getData:@"meteos"];
    [localNAArray addObject:meteos];
    
    PlayerStats *noname=[GrabData getData:@"noname"];
    [localNAArray addObject:noname];
    
    PlayerStats *amazing=[GrabData getData:@"amazing"];
    [localNAArray addObject:amazing];
    
    PlayerStats *crumbzz=[GrabData getData:@"crumbzz"];
    [localNAArray addObject:crumbzz];
    
    PlayerStats *helios=[GrabData getData:@"helios"];
    [localNAArray addObject:helios];
    
    PlayerStats *kez=[GrabData getData:@"kez"];
    [localNAArray addObject:kez];
    
    PlayerStats *IWD=[GrabData getData:@"iwilldominate"];
    [localNAArray addObject:IWD];
    
    PlayerStats *dlift=[GrabData getData:@"doublelift"];
    [localNAArray addObject:dlift];
    
    PlayerStats *sneaky=[GrabData getData:@"sneaky"];
    [localNAArray addObject:sneaky];
    
    PlayerStats *vasilii=[GrabData getData:@"vasilii"];
    [localNAArray addObject:vasilii];
    
    PlayerStats *turtle=[GrabData getData:@"wildturtle"];
    [localNAArray addObject:turtle];

    PlayerStats *qtpie=[GrabData getData:@"imaqtpie"];
    [localNAArray addObject:qtpie];
    
    PlayerStats *altec=[GrabData getData:@"altec"];
    [localNAArray addObject:altec];
    
    PlayerStats *rxl=[GrabData getData:@"robertxlee"];
    [localNAArray addObject:rxl];
    
    PlayerStats *cop=[GrabData getData:@"cop"];
    [localNAArray addObject:cop];
    

    
    
    
    
    
    
    
   

	/*localPS.ign = @"PLAYER 1";	localPS.name = @"Loudy";
	    localPS.team = @"Cloud10";
	    localPS.position = @"APC";
	    localPS.avgKDA = @"7.7";
	    localPS.avgGoldPerMin = @"500";
	    localPS.avgTotalGold = @"7k";
	    //PS.photo = PS.photo setImage:[UIImage imageNamed:<#(NSString *)#>;
	    localPS.bio = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";*/



	/* localPS2.ign = @"PLAYER 2";
	    localPS2.name = @"FallingRockios";
	    localPS2.team = @"Cloud10";
	    localPS2.position = @"JUNG";
	    localPS2.avgKDA = @"5.2";
	    localPS2.avgGoldPerMin = @"300";
	    localPS2.avgTotalGold = @"15k";
	    //PS.photo = PS.photo setImage:[UIImage imageNamed:<#(NSString *)#>;
	    localPS2.bio = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";



	   localPS3.ign = @"PLAYER 1";
	    localPS3.name = @"Toaden";
	    localPS3.team = @"Hord";
	    localPS3.position = @"Mid";
	    localPS3.avgKDA = @"7.7";
	    localPS3.avgGoldPerMin = @"500";
	    localPS3.avgTotalGold = @"7k";
	    //PS.photo = PS.photo setImage:[UIImage imageNamed:<#(NSString *)#>;
	    localPS3.bio = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";












	    [localNAArray addObject:localPS];
	   [localNAArray addObject:localPS2];

	   [localEUArray addObject:localPS3];*/
    
    
   
    

	//[localNAArray addObject:localGrabData.PS];

	self.NA = true;
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
	if (self.NA) {
		return [localNAArray count];
	}
	else {
		return [localEUArray count];
	}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	ViewControllerInfoPage *VCIP = [self.storyboard instantiateViewControllerWithIdentifier:@"infoPage"];
	[self.navigationController pushViewController:VCIP animated:YES];
	self.indexSelection = indexPath.row;




}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"userCell";
	UserCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	if (self.NA) {
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
		self.NA = true;
	}
	else if (segmentbutton.selectedSegmentIndex == 1) {
		self.NA = false;
	}


	[self.dataTable reloadData];
}

@end
