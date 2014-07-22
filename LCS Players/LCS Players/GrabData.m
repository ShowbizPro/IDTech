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
//static NSString *playName;

- (id)init

{

	self = [super init];


	//[localNAArray addObject:PS];

//        NSMutableArray *array = [Global getIGNNAArray];
//        [array addObject:PS];


	// 6
	//tutorial.title = [[element firstChild] content];

	// 7
	//tutorial.url = [element objectForKey:@"href"];

	//NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	/*  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
	      NSData *data = [NSData dataWithContentsOfURL:myURL];
	      NSError *error = nil;
	      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
	      NSString *Name = [json objectForKey:@"name"];
	      NSString *Thumbnail = [json objectForKey:@"thumbnail"];
	      NSString *profileMain = [[Thumbnail substringToIndex:[Thumbnail rangeOfString:@"avatar"].location] stringByAppendingString:@"profilemain.jpg"];
	      NSLog(@"Name: %@, Thumbnail: %@",Name,Thumbnail);
	      NSString *render = @"/static-render/us/";
	      NSString *imageLoc = [NSString stringWithFormat:@"%@%@%@",host,render,profileMain];
	      NSURL *imageURL = [NSURL URLWithString:imageLoc];
	      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
	          NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
	          //Need to perform updates back on the main queue :/.
	          [self performSelectorOnMainThread:@selector(displayImage:)
	                                 withObject:imageData waitUntilDone:YES];
	      });
	   });*/

	return self;
}

+ (PlayerStats*)getData:(NSString*)playerName {
	//[Global setGD:self];
	PlayerStats *PS = [[PlayerStats alloc] init];
	NSMutableArray *localNAArray = [Global getIGNNAArray];

	//        NSString *nameOfPlayer;
	//        NSString *host = @"http://na.lolesports.com/";
	//        NSString *characterInfo = [@"/na-lcs/2014/split2/players/" stringByAppendingString:nameOfPlayer];
	// Do any additional setup after loading the view, typically from a nib.
	NSString *playerNames = [@"http://na.lolesports.com/na-lcs/2014/split2/players/" stringByAppendingString : playerName];

	NSURL* myURL = [NSURL URLWithString:playerNames];
	NSData *data = [NSData dataWithContentsOfURL:myURL];


	TFHpple *playerParser = [TFHpple hppleWithHTMLData:data];

	//NSString *playerXpathQueryString = @"//div[@class='player-profile-foreground']";
	NSString *playerXpathQueryString = @"//span";
	NSArray *playerNodes = [playerParser searchWithXPathQuery:playerXpathQueryString];


	for (TFHppleElement *element in playerNodes) {
		//NSLog(@"%@",[element objectForKey:@"class"]);
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
	NSString *bioXpathQueryString = @"//*[@id='player-profile']/div[3]/div/div[1]/div[1]/div/div/div/div/div/p";
	NSArray *bioNodes = [playerParser searchWithXPathQuery:bioXpathQueryString];
	for(TFHppleElement *element in bioNodes) {
		PS.bio = element.firstChild.content;
	}
    if([PS.ign isEqualToString:@"dexter" ]||[PS.ign isEqualToString:@"Doublelift" ]||[PS.ign isEqualToString:@"Link" ]||[PS.ign isEqualToString:@"Aphromoo" ]||[PS.ign isEqualToString:@"Seraph"]){
        PS.team = @"CLG";
    }
    if([PS.ign isEqualToString:@"Meteos" ]||[PS.ign isEqualToString:@"Hai" ]||[PS.ign isEqualToString:@"LemonNation" ]||[PS.ign isEqualToString:@"Sneaky" ]||[PS.ign isEqualToString:@"Balls"]){
        PS.team = @"Cloud9";
    }
    if([PS.ign isEqualToString:@"Bjergsen" ]||[PS.ign isEqualToString:@"Dyrus" ]||[PS.ign isEqualToString:@"Amazing" ]||[PS.ign isEqualToString:@"WildTurtle" ]||[PS.ign isEqualToString:@"Gleeb"]){
        PS.team = @"TSM";
    }
    if([PS.ign isEqualToString:@"Mor" ]||[PS.ign isEqualToString:@"XiaoWeiXiao" ]||[PS.ign isEqualToString:@"ackerman" ]||[PS.ign isEqualToString:@"Vasilii" ]||[PS.ign isEqualToString:@"NoName"]){
        PS.team = @"LMQ";
    }
    if([PS.ign isEqualToString:@"Helios" ]||[PS.ign isEqualToString:@"Krepo" ]||[PS.ign isEqualToString:@"Altec" ]||[PS.ign isEqualToString:@"Innox" ]||[PS.ign isEqualToString:@"Pobelter"]){
        PS.team = @"EG";
    }
    if([PS.ign isEqualToString:@"Shiphtur" ]||[PS.ign isEqualToString:@"Crumbzz" ]||[PS.ign isEqualToString:@"Imaqtpie" ]||[PS.ign isEqualToString:@"KiWiKiD" ]||[PS.ign isEqualToString:@"Zion Spartan"]){
        PS.team = @"Dignitas";
    }
    if([PS.ign isEqualToString:@"kez" ]||[PS.ign isEqualToString:@"Westrice" ]||[PS.ign isEqualToString:@"pr0lly" ]||[PS.ign isEqualToString:@"Bubbadub" ]||[PS.ign isEqualToString:@"ROBERTxLEE"]){
        PS.team = @"compLexity";
    }
    if([PS.ign isEqualToString:@"Voyboy" ]||[PS.ign isEqualToString:@"Quas" ]||[PS.ign isEqualToString:@"IWillDominate" ]||[PS.ign isEqualToString:@"Xpecial" ]||[PS.ign isEqualToString:@"Cop"]){
        PS.team = @"Curse";
    }


    
//    NSString *imageXpathQueryString = @"//div";
//	NSArray *imageNodes = [playerParser searchWithXPathQuery:imageXpathQueryString];
//    for(TFHppleElement *element in imageNodes) {
//        if([[element objectForKey:@"class"] isEqualToString:@"content"]) {
//			PS.photo = element;
//		}
//    }
    
    
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
    static NSLock *nalock;
    [nalock lock];
	[localNAArray addObject:PS];
    [nalock unlock];




	return PS;
}


+(PlayerStats*)getEUData:(NSString*)playerName {
	//[Global setGD:self];
	PlayerStats *PSEU = [[PlayerStats alloc] init];
	NSMutableArray *localEUArray = [Global getIGNEUArray];

	//        NSString *nameOfPlayer;
	//        NSString *host = @"http://na.lolesports.com/";
	//        NSString *characterInfo = [@"/na-lcs/2014/split2/players/" stringByAppendingString:nameOfPlayer];
	// Do any additional setup after loading the view, typically from a nib.
	NSString *playerNames = [@"http://na.lolesports.com/eu-lcs/2014/split2/players/" stringByAppendingString : playerName];

	NSURL* myURL = [NSURL URLWithString:playerNames];
	NSData *data = [NSData dataWithContentsOfURL:myURL];


	TFHpple *playerParser = [TFHpple hppleWithHTMLData:data];

	//NSString *playerXpathQueryString = @"//div[@class='player-profile-foreground']";
	NSString *playerXpathQueryString = @"//span";
	NSArray *playerNodes = [playerParser searchWithXPathQuery:playerXpathQueryString];


	for (TFHppleElement *element in playerNodes) {
		//NSLog(@"%@",[element objectForKey:@"class"]);
		if([[element objectForKey:@"class"] isEqualToString:@"field-content player-summoner-name"]) {
			NSString *sumname = [element firstChild].content;
			NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"\""];
			sumname = [[sumname componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
			PSEU.ign = sumname;
		}
		if([[element objectForKey:@"class"] isEqualToString:@"field-content player-first-name"]) {
			firstName = [element firstChild].content;
		}
		if([[element objectForKey:@"class"] isEqualToString:@"field-content player-last-name"]) {
			lastName = [element firstChild].content;
		}
		if([[element objectForKey:@"class"] isEqualToString:@"field-content player-position"]) {
			PSEU.position = [element firstChild].content;
		}
		PSEU.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];


	}
    
    if([PSEU.ign isEqualToString:@"Nyph" ]||[PSEU.ign isEqualToString:@"Tabzz" ]||[PSEU.ign isEqualToString:@"Froggen" ]||[PSEU.ign isEqualToString:@"Shook" ]||[PSEU.ign isEqualToString:@"Wickd"]){
        PSEU.team = @"Alliance";
    }
    if([PSEU.ign isEqualToString:@"YoungBuck" ]||[PSEU.ign isEqualToString:@"Airwaks" ]||[PSEU.ign isEqualToString:@"cowTard" ]||[PSEU.ign isEqualToString:@"Woolite" ]||[PSEU.ign isEqualToString:@"Unlimited"]){
        PSEU.team = @"Copenhagen Wolves";
    }
    if([PSEU.ign isEqualToString:@"sOAZ" ]||[PSEU.ign isEqualToString:@"Cyanide" ]||[PSEU.ign isEqualToString:@"xPeke" ]||[PSEU.ign isEqualToString:@"Rekkles" ]||[PSEU.ign isEqualToString:@"YellOwStaR"]){
        PSEU.team = @"Fnatic";
    }
    if([PSEU.ign isEqualToString:@"Kev1n" ]||[PSEU.ign isEqualToString:@"Kottenx" ]||[PSEU.ign isEqualToString:@"Kerp" ]||[PSEU.ign isEqualToString:@"Creaton" ]||[PSEU.ign isEqualToString:@"Jree"]){
        PSEU.team = @"Millenium";
    }
    if([PSEU.ign isEqualToString:@"Xaxus" ]||[PSEU.ign isEqualToString:@"Jankos" ]||[PSEU.ign isEqualToString:@"Overpow" ]||[PSEU.ign isEqualToString:@"Celaver" ]||[PSEU.ign isEqualToString:@"VandeR"]){
        PSEU.team = @"Roccat";
    }
    if([PSEU.ign isEqualToString:@"freddy122" ]||[PSEU.ign isEqualToString:@"Svenskeren" ]||[PSEU.ign isEqualToString:@"Jesiz" ]||[PSEU.ign isEqualToString:@"CandyPanda" ]||[PSEU.ign isEqualToString:@"nRated"]){
        PSEU.team = @"SK Gaming";
    }
    if([PSEU.ign isEqualToString:@"Mimer"]||[PSEU.ign isEqualToString:@"Impaler"]||[PSEU.ign isEqualToString:@"SELFIE" ]||[PSEU.ign isEqualToString:@"MrRalleZ"]||[PSEU.ign isEqualToString:@"kaSing"]){
        PSEU.team = @"Supa Hot Crew";
    }
    if([PSEU.ign isEqualToString:@"Fomko" ]||[PSEU.ign isEqualToString:@"Diamond" ]||[PSEU.ign isEqualToString:@"NiQ" ]||[PSEU.ign isEqualToString:@"Genja" ]||[PSEU.ign isEqualToString:@"EDward"]){
        PSEU.team = @"Gambit Gaming";
    }
    
    
    
	NSString *bioXpathQueryString = @"//*[@id='player-profile']/div[3]/div/div[1]/div[1]/div/div/div/div/div/p";
	NSArray *bioNodes = [playerParser searchWithXPathQuery:bioXpathQueryString];
	for(TFHppleElement *element in bioNodes) {
		PSEU.bio = element.firstChild.content;
	}
	//	for(int i = 1; i<4; i++) {
	for(int i = 1; i<4; i++) {
		NSString *querypath1 = @"//*[@id='player-profile']/div[2]/div/div/div[1]/div/div[1]/div/div/div/div/ul/li[";
		NSString *querypath2 = @"]/div[2]";
        
		NSString *statbioXpathQueryString = [NSString stringWithFormat:@"%@%d%@", querypath1, i, querypath2];
		NSArray *statbioNodes = [playerParser searchWithXPathQuery:statbioXpathQueryString];
		for (TFHppleElement *element in statbioNodes) {
            
			//NSLog(@"%@",element);
            
			if(i==1) {
				PSEU.avgKDA = element.text;
			}
			else if (i==2) {
				PSEU.avgGoldPerMin = element.text;
			}
			else{
				PSEU.avgTotalGold = element.text;
			}
		}
	}
    static NSLock *eulock;
    [eulock lock];
	[localEUArray addObject:PSEU];
    [eulock unlock];





	return PSEU;
}





@end
