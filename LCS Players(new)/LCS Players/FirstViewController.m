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
    self.NA = true;
    
    //Set the first view controller to point to self.
    [Global setFVC:self];
    
    //Grab pointers to the global arrays.
	localNAArray = [Global getIGNNAArray];
	localEUArray = [Global getIGNEUArray];
    
    //Handle displaying cover image for a set time.
    [self handleCover];

    //Set up the table.
    [self initTable];
    
    //Load data into the table.
    [self readInData];
}

//-----Load the data for the table into memory.
-(void) readInData{
    //[GrabData findContactNA];
    self.playerNamers = [[NSArray alloc] initWithObjects:@"dexter-0", @"meteos",@"noname",@"amazing",@"crumbzz",@"helios",@"kez",@"iwilldominate",@"doublelift",@"sneaky",@"vasilii",@"wildturtle",@"imaqtpie",@"altec",@"robertxlee",@"cop",@"link", @"hai", @"xiaoweixiao", @"bjergsen", @"shiphtur", @"pobelter", @"pr0lly", @"voyboy", @"aphromoo", @"lemonnation", @"mor", @"lustboy", @"kiwikid", @"krepo", @"bubbadub", @"xpecial", @"seraph", @"balls", @"ackerman", @"dyrus", @"zion-spartan", @"innox-0", @"westrice", @"quas", nil];
    
    //self.playerNamersEU = [[NSArray alloc] init];
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
}
//-----Handle initializing the table and setting it appropriately.
-(void) initTable{
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
	bgImage.contentMode = UIViewContentModeScaleAspectFit;
	bgImage.alpha = .7;
	[self.dataTable setBackgroundView:bgImage];
	[self.view setBackgroundColor:[UIColor blackColor]];
    [self.dataTable setDelegate:self];
	[self.dataTable setDataSource:self];
}

//-----Handle displaying the cover image for extra load time-----
-(void)handleCover{
    coverImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cover"]];
	[coverImage setHidden:false];
	[coverImage bringSubviewToFront:self.view];
	[coverImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	[coverImage setAlpha:1];
	[NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(hideCover) userInfo:nil repeats:false];
}
-(void)hideCover {
	[coverImage setHidden:true];
}

//-----Table display functions-----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger tempCount;
	if (self.NA) {
		[[Global getNaLock] lock];
            tempCount = [localNAArray count];
        [[Global getNaLock] unlock];
	}
	else {
		[[Global getEULock] lock];
            tempCount = [localEUArray count];
        [[Global getEULock] unlock];
	}
    return tempCount;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ViewControllerInfoPage *VCIP = [self.storyboard instantiateViewControllerWithIdentifier:@"infoPage"];
	VCIP.indexSelection = indexPath.row;
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
		[[Global getEULock] lock];
            PlayerStats *PSEU = [localEUArray objectAtIndex:[indexPath row]];
            [cell.IGNLabel setText:PSEU.ign];
		[[Global getEULock] unlock];
	}
	return cell;
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
