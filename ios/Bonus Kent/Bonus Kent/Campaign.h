//
//  Campaign.h
//  Bonus Kent
//
//  Created by Ali Asghar on 11/24/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Campaign : NSObject

@property (strong,nonatomic)NSString *_id;
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *status;
@property (strong,nonatomic)UIImage *img;
@property (strong,nonatomic)UIImage *promoImage;
@property (strong,nonatomic)NSString *endDate;
@property (strong,nonatomic)NSString *starDate;

@property (strong,nonatomic)NSString *desc;
@property (strong,nonatomic)NSString *latitude;
@property (strong,nonatomic)NSString *longitude;
@property (strong,nonatomic)NSString *distance;
@property (strong,nonatomic)NSString *withinRange;
@property (strong,nonatomic)NSString *locationGlobalImpact;
@property (strong,nonatomic)NSString *locationARGlobalImpact;
@end
