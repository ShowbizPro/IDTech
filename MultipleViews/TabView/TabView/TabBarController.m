//
//  TabBarController.m
//  TabView
//
//  Created by iD Student on 7/15/14.
//  Copyright (c) 2014 iDTech. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

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
    UITabBar *tabBar = [self tabBar];
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UIEdgeInsets imageInset = UIEdgeInsetsMake(5,0,0,0);
    [tabBarItem1 setImageInsets:imageInset];
    [tabBarItem1 setImage:[[UIImage imageNamed:@"RPS"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"RPS"]
                                  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
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
