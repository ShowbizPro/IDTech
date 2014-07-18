//
//  GrabData.m
//  LCS Players
//
//  Created by iD Student on 7/18/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "GrabData.h"

@implementation GrabData

- (id)init
{
    self = [super init];
    if(self)  {
//        NSString *nameOfPlayer;
//        NSString *host = @"http://na.lolesports.com/";
//        NSString *characterInfo = [@"/na-lcs/2014/split2/players/" stringByAppendingString:nameOfPlayer];
        // Do any additional setup after loading the view, typically from a nib.
        NSURL* myURL = [NSURL URLWithString:@"http://na.lolesports.com/na-lcs/2014/split2/players/dexter-0"];
        NSData *data = [NSData dataWithContentsOfURL:myURL];
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
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
    }
    return self;
}



@end
