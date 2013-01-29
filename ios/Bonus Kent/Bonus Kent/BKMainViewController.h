//
//  BKMainViewController.h
//  Bonus Kent
//
//  Created by Ali Asghar on 11/24/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCameraViewController.h"

@interface BKMainViewController : UIViewController<CustomCameraDelegate>

- (IBAction)campaignBtnClicked:(id)sender;
- (IBAction)contestsBtnClicked:(id)sender;
- (IBAction)snap:(id)sender;

@end
