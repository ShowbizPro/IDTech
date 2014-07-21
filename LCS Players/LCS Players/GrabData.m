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
static PlayerStats *PS;
static NSMutableArray *localNAArray;
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

+ (PlayerStats*)getData:(NSString*)playerName{
    //[Global setGD:self];
	PS = [[PlayerStats alloc] init];
    localNAArray = [Global getIGNNAArray];
    
	        //        NSString *nameOfPlayer;
        //        NSString *host = @"http://na.lolesports.com/";
        //        NSString *characterInfo = [@"/na-lcs/2014/split2/players/" stringByAppendingString:nameOfPlayer];
		// Do any additional setup after loading the view, typically from a nib.
    NSString *playerNames = [@"http://na.lolesports.com/na-lcs/2014/split2/players/" stringByAppendingString:playerName];
    
		NSURL* myURL = [NSURL URLWithString:playerNames];
		NSData *data = [NSData dataWithContentsOfURL:myURL];
        
        
		TFHpple *playerParser = [TFHpple hppleWithHTMLData:data];
        
		//NSString *playerXpathQueryString = @"//div[@class='player-profile-foreground']";
        NSString *playerXpathQueryString = @"//span";
		NSArray *playerNodes = [playerParser searchWithXPathQuery:playerXpathQueryString];
        
        
		for (TFHppleElement *element in playerNodes) {
            //NSLog(@"%@",[element objectForKey:@"class"]);
            if([[element objectForKey:@"class"] isEqualToString:@"field-content player-summoner-name"]){
                PS.ign = [element firstChild].content;
            }
            if([[element objectForKey:@"class"] isEqualToString:@"field-content player-first-name"]){
                firstName = [element firstChild].content;
            }
            if([[element objectForKey:@"class"] isEqualToString:@"field-content player-last-name"]){
                lastName = [element firstChild].content;
            }
           if([[element objectForKey:@"class"] isEqualToString:@"field-content player-position"]){
                PS.position = [element firstChild].content;
            }
            if([[element objectForKey:@"class"] isEqualToString:@"stat-value"]){
                PS.avgKDA = [element firstChild].content;
            }
            if([[element objectForKey:@"class"] isEqualToString:@"field-item even"]){
                PS.bio = [element firstChild].content;
            }
            PS.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
           
            
		}
	
			

    
		
    
    return PS;
}



@end
