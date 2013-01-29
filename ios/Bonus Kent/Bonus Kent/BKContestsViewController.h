//
//  BKContestsViewController.h
//  Bonus Kent
//
//  Created by Ali Asghar on 12/13/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface BKContestsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *items;
}

@property (strong, nonatomic) NSArray *campaigns;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet FBProfilePictureView *profileImage;
@end
