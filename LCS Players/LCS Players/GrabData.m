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

+ (PlayerStats*)getData:(NSString*)playerName {
	//[Global setGD:self];
	PlayerStats *PS = [[PlayerStats alloc] init];
	FirstViewController *FVC = [Global getFVC];
	NSMutableArray *localNAArray = [Global getIGNNAArray];

	NSString *playerNames = [@"http://na.lolesports.com/na-lcs/2014/split2/players/" stringByAppendingString : playerName];

	NSURL* myURL = [NSURL URLWithString:playerNames];
	NSData *data = [NSData dataWithContentsOfURL:myURL];


	TFHpple *playerParser = [TFHpple hppleWithHTMLData:data];

	[self getProfileInfo:playerParser PS:PS];
	[self getPhoto:playerParser PS:PS];
	[self getStats:playerParser PS:PS];
	[self getBio:playerParser PS:PS];
	[self getTeam:PS];

	[[Global getNaLock] lock];
	[localNAArray addObject:PS];
	if(localNAArray.count >= FVC.playerNamers.count) {
        [localNAArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
			         return [ps1.ign localizedCaseInsensitiveCompare:ps2.ign];
        }];
		[FVC.dataTable performSelectorOnMainThread:@selector(reloadData)
		 withObject:nil waitUntilDone:YES];
	}
	[[Global getNaLock] unlock];

	return PS;
}


+(PlayerStats*)getEUData:(NSString*)playerName {

	PlayerStats *PSEU = [[PlayerStats alloc] init];
	FirstViewController *FVC = [Global getFVC];
	NSMutableArray *localEUArray = [Global getIGNEUArray];

	NSString *playerNames = [@"http://na.lolesports.com/eu-lcs/2014/split2/players/" stringByAppendingString : playerName];

	NSURL* myURL = [NSURL URLWithString:playerNames];
	NSData *data = [NSData dataWithContentsOfURL:myURL];


	TFHpple *playerParser = [TFHpple hppleWithHTMLData:data];

	[self getProfileInfo:playerParser PS:PSEU];
	[self getPhoto:playerParser PS:PSEU];
	[self getStats:playerParser PS:PSEU];
	[self getBio:playerParser PS:PSEU];
	[self getTeam:PSEU];

	[[Global getEULock] lock];
	[localEUArray addObject:PSEU];
        [localEUArray sortUsingComparator:^NSComparisonResult (PlayerStats *ps1, PlayerStats *ps2){
            return [ps1.ign localizedCaseInsensitiveCompare:ps2.ign];
        }];
	[FVC.dataTable performSelectorOnMainThread:@selector(reloadData)
	 withObject:nil waitUntilDone:YES];
	[[Global getEULock] unlock];

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
	for(TFHppleElement *element in bioNodes) {
		PS.bio = element.firstChild.content;
	}

	if(PS.bio == nil) {
		PS.bio = @"N/A";
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
