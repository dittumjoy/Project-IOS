//
//  ClassListingTableViewCell.m
//  ThoughtSharing
//
//  Created by Rijo George on 16/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import "ClassListingTableViewCell.h"

@implementation ClassListingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_innerView.layer setCornerRadius:5.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
