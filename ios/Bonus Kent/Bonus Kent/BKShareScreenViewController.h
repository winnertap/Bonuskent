//
//  BKShareScreenViewController.h
//  Bonus Kent
//
//  Created by Ali Asghar on 11/30/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface BKShareScreenViewController : UIViewController

@property (strong, nonatomic) IBOutlet FBProfilePictureView *fbProfilePic;
@property (strong, nonatomic) IBOutlet UILabel *fbUserNameLbl;
@property (strong, nonatomic) NSURL *snappedPic;
@property (strong, nonatomic) IBOutlet UIImageView *snappedPicUrl;

@property (strong, nonatomic) FBRequestConnection *requestConnection;

- (IBAction)fbShareButtonClicked:(id)sender;
- (IBAction)shareAndWinBtnClicked:(id)sender;
@end
