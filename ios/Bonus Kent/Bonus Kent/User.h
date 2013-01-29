//
//  User.h
//  Bonus Kent
//
//  Created by Ali Asghar on 12/12/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong,nonatomic)NSString *profileId;
@property (strong,nonatomic) NSData *profilePictureData;
@property (strong,nonatomic)NSString *name;
@property (strong,nonatomic)NSString *score;

@end
