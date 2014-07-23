//
//  ViewControllerInfoPage.m
//  LCS Players
//
//  Created by iD Student on 7/17/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "ViewControllerInfoPage.h"
#import "PlayerStats.h"
#import "FirstViewController.h"
#import "Global.h"

@interface ViewControllerInfoPage ()

@end

@implementation ViewControllerInfoPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
	localNAArray = [Global getIGNNAArray];
    localEUArray = [Global getIGNEUArray];
    PlayerStats *PS ;
    
    FirstViewController *FVC = [Global getFVC];
    if(FVC.NA){
      PS   = localNAArray[FVC.indexSelection];
    }
    else{
        PS = localEUArray[FVC.indexSelection];
    }
    //NA = true;
    
    
    
    
    [self.IGNLabel setText:PS.ign];
    [self.NameLabel setText:PS.name];
    [self.TeamLabel setText:PS.team];
    [self.PositionLabel setText:PS.position];
    [self.avgKDALabel setText:PS.avgKDA];
    [self.avgGPMLabel setText:PS.avgGoldPerMin];
    [self.avgGPTLabel setText:PS.avgTotalGold];
    [self.bioTextView setText:PS.bio];
    [self.PlayerPicture setImage:PS.photo];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
