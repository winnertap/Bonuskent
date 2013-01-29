//
//  BKLeaderBoardCell.h
//  Bonus Kent
//
//  Created by Ali Asghar on 12/12/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface BKLeaderBoardCell : UITableViewCell

@property (strong,nonatomic)IBOutlet UIImageView *profileImage;
@property (strong,nonatomic)IBOutlet UILabel *name;
@property (strong,nonatomic)IBOutlet UILabel *rank;
@property (strong,nonatomic)IBOutlet UILabel *points;

@end
