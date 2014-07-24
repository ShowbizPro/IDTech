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


    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    bgImage.contentMode = UIViewContentModeScaleAspectFit;
    bgImage.alpha = .7;
    [self.dataTable setBackgroundView:bgImage];
    [self.view setBackgroundColor:[UIColor blackColor]];

	self.playerNamers = [[NSArray alloc] initWithObjects:@"dexter-0", @"meteos",@"noname",@"amazing",@"crumbzz",@"helios",@"kez",@"iwilldominate",@"doublelift",@"sneaky",@"vasilii",@"wildturtle",@"imaqtpie",@"altec",@"robertxlee",@"cop",@"link", @"hai", @"xiaoweixiao", @"bjergsen", @"shiphtur", @"pobelter", @"pr0lly", @"voyboy", @"aphromoo", @"lemonnation", @"mor", @"gleeb", @"kiwikid", @"krepo", @"bubbadub", @"xpecial", @"seraph", @"balls", @"ackerman", @"dyrus", @"zion-spartan", @"innox-0", @"westrice", @"quas", nil];
	self.NA = true;

	self.playerNamersEU = [[NSArray alloc] initWithObjects: @"shook", @"cyanide",@"kottenx", @"jankos",@"svenskeren", @"impaler", @"airwaks", @"diamond", @"tabzz", @"rekkles", @"creaton", @"celaver-0", @"candypanda", @"mrrallez", @"woolite", @"genja", @"froggen", @"xpeke", @"kerp", @"overpow",@"jesiz", @"selfie", @"cowtard-0", @"niq-0", @"nyph", @"yellowstar", @"jree", @"vander",@"nrated", @"kasing",@"unlimited-0", @"edward", @"wickd",@"soaz",@"kev1n",@"xaxus",@"fredy122",@"mimer", @"youngbuck-0", @"fomko",nil];


	for (int i=0; i < self.playerNamers.count; i++) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
		                       [GrabData getData:self.playerNamers[i]];
			       });
	}


	for(int i=0; i<self.playerNamersEU.count; i++) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
		                       [GrabData getEUData:self.playerNamersEU[i]];
                
			       });
	}

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
	self.indexSelection = indexPath.row;
	[self.navigationController pushViewController:VCIP animated:YES];





}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"userCell";
	UserCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	if (self.NA) {
        [[Global getNaLock] lock];
		PlayerStats *PSNA = [localNAArray objectAtIndex:[indexPath row]];
		[cell.IGNLabel setText:PSNA.ign];
        [[Global getNaLock] unlock];
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

- (IBAction)teamButton:(id)sender {
    [[Global getNaLock]lock];
    [localNAArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
        return [ps1.team localizedCaseInsensitiveCompare:ps2.team];
    }];
    [[Global getNaLock]unlock];
    
    
    [[Global getEULock]lock];
    [localEUArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
        return [ps1.team localizedCaseInsensitiveCompare:ps2.team];
    }];
    [[Global getEULock]unlock];
    [self.dataTable reloadData];
}

- (IBAction)IGNButton:(id)sender {
    [[Global getNaLock]lock];
    [localNAArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
        return [ps1.ign localizedCaseInsensitiveCompare:ps2.ign];
    }];
    [[Global getNaLock]unlock];
    
    
    [[Global getEULock]lock];
    [localEUArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
        return [ps1.ign localizedCaseInsensitiveCompare:ps2.ign];
    }];
    [[Global getEULock]unlock];
    [self.dataTable reloadData];
}
@end
