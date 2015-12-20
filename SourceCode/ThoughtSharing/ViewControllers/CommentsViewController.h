//
//  CommentsViewController.h
//  ThoughtSharing
//
//  Created by Rijo George on 16/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface CommentsViewController : UIViewController<UITextViewDelegate>
{
    float hgtKeyboard;
}


- (void)setGroup:(PFObject *)object;

@property (nonatomic, weak) IBOutlet UITextView *txtViewComments;
@property (nonatomic, weak) IBOutlet UIView *viewBottom;


-(IBAction)btnSendClicked:(id)sender;

@end
