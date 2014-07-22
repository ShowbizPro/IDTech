//
//  ViewControllerInfoPage.h
//  LCS Players
//
//  Created by iD Student on 7/17/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerInfoPage : UIViewController{
    NSMutableArray *localNAArray;
    NSMutableArray *localEUArray;
}
@property (weak, nonatomic) IBOutlet UILabel *IGNLabel;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *PositionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *PlayerPicture;
@property (weak, nonatomic) IBOutlet UILabel *avgKDALabel;
@property (weak, nonatomic) IBOutlet UILabel *avgGPMLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgGPTLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;


@end
