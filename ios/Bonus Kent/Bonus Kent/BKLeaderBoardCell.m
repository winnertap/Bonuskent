//
//  BKLeaderBoardCell.m
//  Bonus Kent
//
//  Created by Ali Asghar on 12/12/12.
//  Copyright (c) 2012 Ali Asghar. All rights reserved.
//

#import "BKLeaderBoardCell.h"

@implementation BKLeaderBoardCell

@synthesize profileImage;
@synthesize name;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
