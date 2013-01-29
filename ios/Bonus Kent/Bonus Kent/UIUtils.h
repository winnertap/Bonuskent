//
//  UIUtils.h
//  meU
//
//  Created by Apple on 13/09/2012.
//  Copyright (c) 2012 MacrosoftInc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

+(UIButton *) getTopLeftBarItem: (NSString*) Title;
+(UIButton *) getTopRightBarItem: (NSString*) Title;
+(UIButton *) getHomeBackBarItem;
@end
