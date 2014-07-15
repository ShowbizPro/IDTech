//
//  ViewController.m
//  RPS
//
//  Created by iD Student on 7/14/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController 

Choice RPSC[]= {rock, paper, scissors};



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIColorArray = [[NSArray alloc] initWithObjects:[UIColor blueColor], [UIColor brownColor], [UIColor blackColor], [UIColor purpleColor], [UIColor cyanColor],[UIColor darkGrayColor],[UIColor grayColor],[UIColor lightGrayColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor redColor],[UIColor greenColor],nil];
    CountTime = 1;
    currentIndex=0;
   
    RPS = [[NSArray alloc] initWithObjects:@"rock",@"paper",@"scissor", nil];
    [self.Choices setImage:[UIImage imageNamed:RPS[currentIndex]]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                    message:@"Enjoy the app!" delegate:self cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Done", @"", nil];
    
    
    
    
    if(playerLosses >=10 && playerLosses > playerWins && playerLosses >playerTies){
    [alert show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



- (void)makeCompChoice{
    int randomChoice = (int)1 + arc4random() % (3);
    
    switch (randomChoice) {
        case 1:
            [self.compImageView setImage:[UIImage imageNamed:@"rock"]];
            CompChoice = rock;
            break;
        case 2:
            [self.compImageView setImage:[UIImage imageNamed:@"paper"]];
            CompChoice = paper;
            break;
        case 3:
            [self.compImageView setImage:[UIImage imageNamed:@"scissor"]];
            CompChoice = scissors;
            break;
    }
}
- (void)compareChoices {
    if (PlayerChoice == rock) {
        if (CompChoice == paper) {
            playerLosses++;
            [self.losses setText:[NSString stringWithFormat:@"%d", playerLosses]];
            [self.result setText:@"Wow you're bad!"];
        }else if (CompChoice == scissors) {
            playerWins++;
            [self.wins setText:[NSString stringWithFormat:@"%d", playerWins]];
            [self.result setText:@"Congrats you don't suck!"];
        }else {
            playerTies++;
            [self.ties setText:[NSString stringWithFormat:@"%d", playerTies]];
            [self.result setText:@"Both you and the computer are bad!"];
        }
    }
    else if (PlayerChoice == paper) {
        if (CompChoice == scissors) {
            playerLosses++;
            [self.losses setText:[NSString stringWithFormat:@"%d", playerLosses]];
            [self.result setText:@"Wow you're bad!"];
        }else if (CompChoice == rock) {
            playerWins++;
            [self.wins setText:[NSString stringWithFormat:@"%d", playerWins]];
            [self.result setText:@"Congrats you don't suck!"];
        }else {
            playerTies++;
            [self.ties setText:[NSString stringWithFormat:@"%d", playerTies]];
            [self.result setText:@"Both you and the computer are bad!"];
        }
    }
    else if (PlayerChoice == scissors) {
        if (CompChoice == rock) {
            playerLosses++;
            [self.losses setText:[NSString stringWithFormat:@"%d", playerLosses]];
            [self.result setText:@"Wow you're bad!"];
        }else if (CompChoice == paper) {
            playerWins++;
            [self.wins setText:[NSString stringWithFormat:@"%d", playerWins]];
            [self.result setText:@"Congrats you don't suck!"];
        }else {
            playerTies++;
            [self.ties setText:[NSString stringWithFormat:@"%d", playerTies]];
            [self.result setText:@"Both you and the computer are bad!"];
        }
    }
    
    
}



- (IBAction)swipeLeft:(id)sender {
    currentIndex++;
    if(currentIndex >2){
        currentIndex =2;
    }
    
    if(currentIndex <=2){
        [self.Choices setImage:[UIImage imageNamed:RPS[currentIndex]]];
       
        
    }
    
}

- (IBAction)swipeRight:(id)sender {
    currentIndex--;
    if(currentIndex <0){
        currentIndex =0;
    }
    if(currentIndex >=0){
        [self.Choices setImage:[UIImage imageNamed:RPS[currentIndex]]];
        
    }
}

- (IBAction)ChoiceButton:(id)sender {
    [self.ChoiceButton setEnabled:false];
    if(currentIndex <=2 && currentIndex >=0){
        if(self.playerImageView.alpha == 0){
            [self.playerImageView  setAlpha:1];
            [self.playerImageView  setImage:nil];
            
        }
        if(self.compImageView.alpha == 0){
            [self.compImageView  setAlpha:1];
            [self.compImageView  setImage:nil];
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(timerExpired) userInfo:nil repeats:true];
        PlayerChoice = RPSC[currentIndex];
    }
}

- (void)timerExpired
{
    
    
    if (CountTime > 3){
        
        [self setBgcolor];
        [self.CountDownLabel setText:(@"Shoot!")];
        
        [timer invalidate];
        
        [self makeCompChoice];
        
        [self.playerImageView setImage:[UIImage imageNamed:RPS[currentIndex]]];
        [self compareChoices];
        
        [UIView animateWithDuration:0.5 delay:2.0 options:UIViewAnimationOptionCurveEaseOut animations:^(){
            if(self.playerImageView.alpha == 1){
                [self.playerImageView setAlpha:0];
            }
            else{
                [self.playerImageView  setAlpha:1];
            }
            
            if(self.compImageView.alpha == 1){
                [self.compImageView setAlpha:0];
            }
            else{
                [self.compImageView  setAlpha:1];
            }
            
        }completion:^(BOOL finished){
            [self.CountDownLabel setText:(@"Count Down")];
            [self.result setText:(@"Result")];
            [self.ChoiceButton setEnabled:true];

        }];
        CountTime = 1;
        
    }
    else {
        [self setBgcolor];
        [self.CountDownLabel setText: RPS[CountTime-1]];
        CountTime ++;
    }
        
       
    
    
}
-(void)setBgcolor{
    int randomColor = (int)0 + arc4random() % (12);
    [self.view setBackgroundColor: UIColorArray[randomColor]];
}

- (IBAction)goButton:(id)sender {
    NSString *urlString = self.textField.text;
    NSURL *url;
    
    if([urlString hasPrefix:@"http://"] || [urlString hasPrefix:@"http:/"] || [urlString hasPrefix:@"http:"]) {
        url = [NSURL URLWithString:urlString];
    }else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", self.textField.text]];
    }
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.textField.text]];
    
    [self.website loadRequest:urlRequest];}

- (IBAction)forwardButton:(id)sender {
    [self.website goForward];
}

- (IBAction)backButton:(id)sender {
    [self.website goBack];
}
    @end
