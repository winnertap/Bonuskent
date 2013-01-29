//
//  UIUtils.m
//  meU
//
//  Created by Apple on 13/09/2012.
//  Copyright (c) 2012 MacrosoftInc. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

+(UIButton *) getTopLeftBarItem: (NSString*) Title {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"back_03.png"] forState:UIControlStateNormal];
    [leftButton setTitle:Title forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        leftButton.frame = CGRectMake(0.0f, 0.0f, 90.0f, 45.0f);
    }else{
        leftButton.frame = CGRectMake(0.0f, 0.0f, 75.0f, 35.0f);
        leftButton.titleLabel.font =[UIFont boldSystemFontOfSize:12.0];
    }
    [leftButton titleEdgeInsets];
    
    return leftButton;
}

+(UIButton *) getTopRightBarItem: (NSString*) Title {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"small-button_03.png"] forState:UIControlStateNormal];
    [rightButton setTitle:Title forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        rightButton.frame = CGRectMake(0.0f, 0.0f, 90.0f, 45.0f);
    }else{
        rightButton.frame = CGRectMake(0.0f, 0.0f, 75.0f, 35.0f);
        rightButton.titleLabel.font =[UIFont boldSystemFontOfSize:12.0];
    }
    return rightButton;
}

+(UIButton *) getHomeBackBarItem {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"home_03.png"] forState:UIControlStateNormal];
//    [rightButton setTitle:@" Back" forState:UIControlStateNormal];
    
    [rightButton setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:55.0f/255.0f blue:147.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        rightButton.frame = CGRectMake(0.0f, 0.0f, 90.0f, 45.0f);
    }else{
        rightButton.frame = CGRectMake(0.0f, 0.0f, 75.0f, 35.0f);
        rightButton.titleLabel.font =[UIFont boldSystemFontOfSize:12.0];
    }
    return rightButton;
}

@end
