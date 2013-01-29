//
//  BKCampaignListViewController.h
//  Bonus Kent
//
//  Created by Ali Asghar on 11/24/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Campaign.h"
#import <CoreLocation/CoreLocation.h>

@interface BKCampaignListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    NSMutableArray *items;
    NSMutableArray *allCampaigns;
    
    Campaign *selectedCampaign;
    
    CLLocationManager *locationManager;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
