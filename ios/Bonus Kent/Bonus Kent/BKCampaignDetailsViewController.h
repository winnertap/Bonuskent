//
//  BKCampaignDetailsViewController.h
//  Bonus Kent
//
//  Created by Ali Asghar on 11/24/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Campaign.h"

@interface BKCampaignDetailsViewController : UIViewController

@property (strong,nonatomic)Campaign *campaign;

@property (strong, nonatomic) IBOutlet UIImageView *promoImage;
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;

@end
