//
//  BKCampaignTableCell.h
//  Bonus Kent
//
//  Created by Ali Asghar on 11/24/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKCampaignTableCell : UITableViewCell

@property (strong,nonatomic)IBOutlet UIImageView *campaignImage;
@property (strong,nonatomic)IBOutlet UILabel *title;
@property (strong,nonatomic)IBOutlet UILabel *distance;
@property (strong,nonatomic)IBOutlet UIImageView *locationMarkerImage;

@end
