//
//  ViewController.m
//  PostingToTwitter
//
//  Created by iD Student on 7/16/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tweetButton:(id)sender {
    
    SLComposeViewController *SLVC = [SLComposeViewController composeViewControllerForServiceType: SLServiceTypeTwitter];
    
    [self presentViewController:SLVC animated:true completion:^{nil;}];
    
    
}

@end
