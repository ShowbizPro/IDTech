//
//  ViewController.h
//  RPS
//
//  Created by iD Student on 7/14/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    rock = 1,
    paper = 2,
    scissors = 3,
}Choice;




@interface ViewController : UIViewController <UIApplicationDelegate>{

int playerWins;
int playerLosses;
int playerTies;
    
int CountTime;
int currentIndex;
    
    NSString *ChoiceOfPlayer;
    
    NSTimer *timer;
    
    Choice PlayerChoice;
    Choice CompChoice;
    
    
    NSArray *UIColorArray;
    NSArray *RPS;
    Choice RPSC[3];
}
@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *compImageView;

@property (weak, nonatomic) IBOutlet UIImageView *Choices;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *ChoiceButton;

@property (weak, nonatomic) IBOutlet UILabel *playerLabel;

@property (weak, nonatomic) IBOutlet UILabel *compLabel;


@property (weak, nonatomic) IBOutlet UILabel *result;

@property (weak, nonatomic) IBOutlet UILabel *wins;
@property (weak, nonatomic) IBOutlet UILabel *losses;
@property (weak, nonatomic) IBOutlet UILabel *ties;


@property (weak, nonatomic) IBOutlet UILabel *CountDownLabel;

@end
