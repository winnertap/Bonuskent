//
//  LeadershipBoardViewController.h
//  Bonus Kent
//
//  Created by Ali Asghar on 12/11/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LeadershipBoardViewController : UIViewController<FBFriendPickerDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *items;
    NSMutableDictionary *facebookContacts;
    NSString *facebookIds;
}

@property (strong, nonatomic) FBFriendPickerViewController *friendPickerController;

@property (strong, nonatomic) NSArray* selectedFriends;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *userDisplayNameLbl;

@property (strong, nonatomic) IBOutlet UILabel *pointLbl;
@end
