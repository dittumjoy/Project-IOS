//
//  ListingViewController.h
//  ThoughtSharing
//
//  Created by Rijo George on 16/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingViewController : UIViewController<UIAlertViewDelegate, UITextViewDelegate, UITextFieldDelegate, UITableViewDataSource>


@property (nonatomic, strong) IBOutlet UIView *viewAddForum;


@end
