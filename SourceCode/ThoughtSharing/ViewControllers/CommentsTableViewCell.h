//
//  CommentsTableViewCell.h
//  ThoughtSharing
//
//  Created by Rijo George on 16/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
