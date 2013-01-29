//
//  BKContestsTableCell.h
//  Bonus Kent
//
//  Created by Ali Asghar on 12/13/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKContestsTableCell : UITableViewCell

@property (strong,nonatomic)IBOutlet UIImageView *campaignImage;
@property (strong,nonatomic)IBOutlet UILabel *campaignName;
@property (strong,nonatomic)IBOutlet UILabel *points;


@end
