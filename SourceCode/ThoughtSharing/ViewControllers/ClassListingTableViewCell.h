//
//  ClassListingTableViewCell.h
//  ThoughtSharing
//
//  Created by Rijo George on 16/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassListingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

@end
