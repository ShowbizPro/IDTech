//
//  GrabData.m
//  LCS Players
//
//  Created by iD Student on 7/18/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "GrabData.h"
#import "TFHpple.h"
#import "Global.h"
@implementation GrabData
@synthesize title = _title;
@synthesize url = _url;



static NSString *firstName;
static NSString *lastName;

- (id)init {
	self = [super init];
	return self;
}

+ (void)saveData:(NSString*)regionString PS:(PlayerStats*)PS{

	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

	NSManagedObjectContext *context = [appDelegate managedObjectContext];
	NSManagedObject *newContact;
	newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:context];
	[newContact setValue: PS.ign forKey:@"ign"];
	[newContact setValue: PS.name forKey:@"name"];
	[newContact setValue: PS.team forKey:@"team"];
	[newContact setValue: PS.position forKey:@"position"];
	[newContact setValue: PS.avgKDA forKey:@"avgKDA"];
	[newContact setValue: PS.avgGoldPerMin forKey:@"avgGPM"];
	[newContact setValue: PS.avgTotalGold forKey:@"avgTG"];
	[newContact setValue: PS.bio forKey:@"bio"];
	[newContact setValue: PS.photo forKey:@"photo"];
    [newContact setValue: regionString forKey:@"region"];
	//NSError *error;
	//[context save:&error];

}
+ (void)findContactNA {
	
	NSMutableArray *localNAArray = [Global getIGNNAArray];
    NSMutableArray *localEUArray = [Global getIGNEUArray];
    
	FirstViewController *FVC = [Global getFVC];
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

	NSManagedObjectContext *context = [appDelegate managedObjectContext];

	NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:context];

	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDesc];

	NSPredicate *pred = [NSPredicate predicateWithFormat:@"(region=%@)", @"NA"];
	//if this is nil, returns everything that has been saved.
	[request setPredicate:pred];
	NSManagedObject *matches = nil;

	NSError *error;
	NSArray *objects = [context executeFetchRequest:request error:&error];

    for (int i = 0; i < objects.count; i++){
        PlayerStats *PS = [[PlayerStats alloc] init];
        matches = objects[i];
        PS.name = [matches valueForKey:@"name"];
        PS.ign = [matches valueForKey:@"ign"];
        PS.team = [matches valueForKey:@"team"];
        PS.position = [matches valueForKey:@"position"];
        PS.avgKDA = [matches valueForKey:@"avgKDA"];
        PS.avgGoldPerMin = [matches valueForKey:@"avgGPM"];
        PS.avgTotalGold = [matches valueForKey:@"avgTG"];
        PS.bio = [matches valueForKey:@"bio"];
        PS.photo = [matches valueForKey:@"photo"];
        [[Global getNaLock] lock];
        [localNAArray addObject:PS];
        [[Global getNaLock] unlock];
    }
    
    
    NSFetchRequest *requestEU = [[NSFetchRequest alloc] init];
	[requestEU setEntity:entityDesc];
    
    NSPredicate *predEU = [NSPredicate predicateWithFormat:@"(region=%@)", @"EU"];
	//if this is nil, returns everything that has been saved.
	[requestEU setPredicate:predEU];
	NSManagedObject *matchesEU = nil;
    
	NSError *errorEU;
	NSArray *objectsEU = [context executeFetchRequest:requestEU error:&errorEU];
    
    for (int i = 0; i < objectsEU.count; i++){
        PlayerStats *PS = [[PlayerStats alloc] init];
        matchesEU = objectsEU[i];
        PS.name = [matchesEU valueForKey:@"name"];
        PS.ign = [matchesEU valueForKey:@"ign"];
        PS.team = [matchesEU valueForKey:@"team"];
        PS.position = [matchesEU valueForKey:@"position"];
        PS.avgKDA = [matchesEU valueForKey:@"avgKDA"];
        PS.avgGoldPerMin = [matchesEU valueForKey:@"avgGPM"];
        PS.avgTotalGold = [matchesEU valueForKey:@"avgTG"];
        PS.bio = [matchesEU valueForKey:@"bio"];
        PS.photo = [matchesEU valueForKey:@"photo"];
        [[Global getEULock] lock];
        [localEUArray addObject:PS];
        [[Global getEULock] unlock];
    }
    [localNAArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
        return [ps1.ign localizedCaseInsensitiveCompare:ps2.ign];
    }];
    [localEUArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
        return [ps1.ign localizedCaseInsensitiveCompare:ps2.ign];
    }];
    [FVC.dataTable reloadData];
}





+ (PlayerStats*)getData:(NSString*)playerName {
	//[Global setGD:self];
	PlayerStats *PS = [[PlayerStats alloc] init];
	FirstViewController *FVC = [Global getFVC];
	[[Global getNaLock] lock];
        NSMutableArray *localNAArray = [Global getIGNNAArray];
	[[Global getNaLock] unlock];

	NSString *playerNames = [@"http://na.lolesports.com/na-lcs/2014/split2/players/" stringByAppendingString : playerName];

	NSURL* myURL = [NSURL URLWithString:playerNames];
	NSData *data = [NSData dataWithContentsOfURL:myURL];


	TFHpple *playerParser = [TFHpple hppleWithHTMLData:data];

	[self getProfileInfo:playerParser PS:PS];
	[self getPhoto:playerParser PS:PS];
	[self getStats:playerParser PS:PS];
	[self getBio:playerParser PS:PS];
	[self getTeam:PS];

    int row;
	[[Global getNaLock] lock];
        [localNAArray addObject:PS];
        row = localNAArray.count-1;
        [localNAArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
	         return [ps1.ign localizedCaseInsensitiveCompare:ps2.ign];
        }];
    [[Global getNaLock] unlock];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [FVC.dataTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:false];
   });
//	[FVC.dataTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    //[self saveData:@"NA" PS:PS];
	
	return PS;
}


+(PlayerStats*)getEUData:(NSString*)playerName {

	PlayerStats *PSEU = [[PlayerStats alloc] init];
	FirstViewController *FVC = [Global getFVC];
	[[Global getEULock] lock];
        NSMutableArray *localEUArray = [Global getIGNEUArray];
	[[Global getEULock] unlock];

	NSString *playerNames = [@"http://na.lolesports.com/eu-lcs/2014/split2/players/" stringByAppendingString : playerName];

	NSURL* myURL = [NSURL URLWithString:playerNames];
	NSData *data = [NSData dataWithContentsOfURL:myURL];

	TFHpple *playerParser = [TFHpple hppleWithHTMLData:data];

	[self getProfileInfo:playerParser PS:PSEU];
	[self getPhoto:playerParser PS:PSEU];
	[self getStats:playerParser PS:PSEU];
	[self getBio:playerParser PS:PSEU];
	[self getTeam:PSEU];
    int row;
	[[Global getEULock] lock];
        [localEUArray addObject:PSEU];
        row = localEUArray.count-1;
        [localEUArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
            return [ps1.ign localizedCaseInsensitiveCompare:ps2.ign];
        }];
    [[Global getEULock] unlock];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [FVC.dataTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:false];
    });
//	[FVC.dataTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
	
//  [self saveData:@"EU" PS:PSEU];
	return PSEU;
}





+(PlayerStats*)getProfileInfo:(TFHpple*)playerParser PS:(PlayerStats*)PS {
	NSString *playerXpathQueryString = @"//span";
	NSArray *playerNodes = [playerParser searchWithXPathQuery:playerXpathQueryString];


	for (TFHppleElement *element in playerNodes) {

		if([[element objectForKey:@"class"] isEqualToString:@"field-content player-summoner-name"]) {
			NSString *sumname = [element firstChild].content;
			NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\""];
			sumname = [[sumname componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
			PS.ign = sumname;
		}
		if([[element objectForKey:@"class"] isEqualToString:@"field-content player-first-name"]) {
			firstName = [element firstChild].content;
		}
		if([[element objectForKey:@"class"] isEqualToString:@"field-content player-last-name"]) {
			lastName = [element firstChild].content;
		}
		if([[element objectForKey:@"class"] isEqualToString:@"field-content player-position"]) {
			PS.position = [element firstChild].content;
		}
		PS.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];


	}
	return PS;
}

+(PlayerStats*)getStats:(TFHpple*)playerParser PS:(PlayerStats*)PS {
	for(int i = 1; i<4; i++) {
		NSString *querypath1 = @"//*[@id='player-profile']/div[2]/div/div/div[1]/div/div[1]/div/div/div/div/ul/li[";
		NSString *querypath2 = @"]/div[2]";

		NSString *statbioXpathQueryString = [NSString stringWithFormat:@"%@%d%@", querypath1, i, querypath2];
		NSArray *statbioNodes = [playerParser searchWithXPathQuery:statbioXpathQueryString];
		for (TFHppleElement *element in statbioNodes) {

			//NSLog(@"%@",element);

			if(i==1) {
				PS.avgKDA = element.text;
			}
			else if (i==2) {
				PS.avgGoldPerMin = element.text;
			}
			else{
				PS.avgTotalGold = element.text;
			}
		}
	}
	return PS;
}

+(PlayerStats*)getPhoto:(TFHpple*)playerParser PS:(PlayerStats*)PS {
	NSString *imageXpathQueryString = @"//*[@id='player-profile']/div[1]/div/div/div/div/div/div/div[2]/div/div/div/img";
	NSArray *imageNodes = [playerParser searchWithXPathQuery:imageXpathQueryString];
	for(TFHppleElement *element in imageNodes) {
		NSString *end = [element.attributes objectForKey:@"src"];
		NSString *urlString = [NSString stringWithFormat:@"%@%@", @"http://na.lolesports.com", end];


		//Downloading the image given a url for the image.
		NSURL *imageURL = [NSURL URLWithString:urlString];
		NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
		UIImage *image = [UIImage imageWithData:imageData];
		PS.photo = image;
	}
	return PS;
}

+(PlayerStats*)getBio:(TFHpple*)playerParser PS:(PlayerStats*)PS {
	NSString *bioXpathQueryString = @"//*[@id='player-profile']/div[3]/div/div[1]/div[1]/div/div/div/div/div/p";
	NSArray *bioNodes = [playerParser searchWithXPathQuery:bioXpathQueryString];
    if(bioNodes.count == 0) {
        PS.bio = @"N/A";
    }
    else {
        for(TFHppleElement *element in bioNodes) {
            PS.bio = element.firstChild.content;
        }
    }

	
	return PS;
}

+(PlayerStats*)getTeam:(PlayerStats*)PS {
	if([PS.ign isEqualToString:@"dexter" ]||[PS.ign isEqualToString:@"Doublelift" ]||[PS.ign isEqualToString:@"Link" ]||[PS.ign isEqualToString:@"Aphromoo" ]||[PS.ign isEqualToString:@"Seraph"]) {
		PS.team = @"CLG";
	}
	if([PS.ign isEqualToString:@"Meteos" ]||[PS.ign isEqualToString:@"Hai" ]||[PS.ign isEqualToString:@"LemonNation" ]||[PS.ign isEqualToString:@"Sneaky" ]||[PS.ign isEqualToString:@"Balls"]) {
		PS.team = @"Cloud9";
	}
	if([PS.ign isEqualToString:@"Bjergsen" ]||[PS.ign isEqualToString:@"Dyrus" ]||[PS.ign isEqualToString:@"Amazing" ]||[PS.ign isEqualToString:@"WildTurtle" ]||[PS.ign isEqualToString:@"Gleeb"]) {
		PS.team = @"TSM";
	}
	if([PS.ign isEqualToString:@"Mor" ]||[PS.ign isEqualToString:@"XiaoWeiXiao" ]||[PS.ign isEqualToString:@"ackerman" ]||[PS.ign isEqualToString:@"Vasilii" ]||[PS.ign isEqualToString:@"NoName"]) {
		PS.team = @"LMQ";
	}
	if([PS.ign isEqualToString:@"Helios" ]||[PS.ign isEqualToString:@"Krepo" ]||[PS.ign isEqualToString:@"Altec" ]||[PS.ign isEqualToString:@"Innox" ]||[PS.ign isEqualToString:@"Pobelter"]) {
		PS.team = @"EG";
	}
	if([PS.ign isEqualToString:@"Shiphtur" ]||[PS.ign isEqualToString:@"Crumbzz" ]||[PS.ign isEqualToString:@"Imaqtpie" ]||[PS.ign isEqualToString:@"KiWiKiD" ]||[PS.ign isEqualToString:@"Zion Spartan"]) {
		PS.team = @"Dignitas";
	}
	if([PS.ign isEqualToString:@"kez" ]||[PS.ign isEqualToString:@"Westrice" ]||[PS.ign isEqualToString:@"pr0lly" ]||[PS.ign isEqualToString:@"Bubbadub" ]||[PS.ign isEqualToString:@"ROBERTxLEE"]) {
		PS.team = @"compLexity";
	}
	if([PS.ign isEqualToString:@"Voyboy" ]||[PS.ign isEqualToString:@"Quas" ]||[PS.ign isEqualToString:@"IWillDominate" ]||[PS.ign isEqualToString:@"Xpecial" ]||[PS.ign isEqualToString:@"Cop"]) {
		PS.team = @"Curse";
	}

	if([PS.ign isEqualToString:@"Nyph" ]||[PS.ign isEqualToString:@"Tabzz" ]||[PS.ign isEqualToString:@"Froggen" ]||[PS.ign isEqualToString:@"Shook" ]||[PS.ign isEqualToString:@"Wickd"]) {
		PS.team = @"Alliance";
	}
	if([PS.ign isEqualToString:@"YoungBuck" ]||[PS.ign isEqualToString:@"Airwaks" ]||[PS.ign isEqualToString:@"cowTard" ]||[PS.ign isEqualToString:@"Woolite" ]||[PS.ign isEqualToString:@"Unlimited"]) {
		PS.team = @"Copenhagen Wolves";
	}
	if([PS.ign isEqualToString:@"sOAZ" ]||[PS.ign isEqualToString:@"Cyanide" ]||[PS.ign isEqualToString:@"xPeke" ]||[PS.ign isEqualToString:@"Rekkles" ]||[PS.ign isEqualToString:@"YellOwStaR"]) {
		PS.team = @"Fnatic";
	}
	if([PS.ign isEqualToString:@"Kev1n" ]||[PS.ign isEqualToString:@"Kottenx" ]||[PS.ign isEqualToString:@"Kerp" ]||[PS.ign isEqualToString:@"Creaton" ]||[PS.ign isEqualToString:@"Jree"]) {
		PS.team = @"Millenium";
	}
	if([PS.ign isEqualToString:@"Xaxus" ]||[PS.ign isEqualToString:@"Jankos" ]||[PS.ign isEqualToString:@"Overpow" ]||[PS.ign isEqualToString:@"Celaver" ]||[PS.ign isEqualToString:@"VandeR"]) {
		PS.team = @"Roccat";
	}
	if([PS.ign isEqualToString:@"freddy122" ]||[PS.ign isEqualToString:@"Svenskeren" ]||[PS.ign isEqualToString:@"Jesiz" ]||[PS.ign isEqualToString:@"CandyPanda" ]||[PS.ign isEqualToString:@"nRated"]) {
		PS.team = @"SK Gaming";
	}
	if([PS.ign isEqualToString:@"Mimer"]||[PS.ign isEqualToString:@"Impaler"]||[PS.ign isEqualToString:@"SELFIE" ]||[PS.ign isEqualToString:@"MrRalleZ"]||[PS.ign isEqualToString:@"kaSing"]) {
		PS.team = @"Supa Hot Crew";
	}
	if([PS.ign isEqualToString:@"Fomko" ]||[PS.ign isEqualToString:@"Diamond" ]||[PS.ign isEqualToString:@"NiQ" ]||[PS.ign isEqualToString:@"Genja" ]||[PS.ign isEqualToString:@"EDward"]) {
		PS.team = @"Gambit Gaming";
	}

	return PS;


}









@end
