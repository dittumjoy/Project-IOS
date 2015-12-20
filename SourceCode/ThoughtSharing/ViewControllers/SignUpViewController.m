//
//  SignUpViewController.m
//  ThoughtSharing
//
//  Created by Rijo George on 14/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "TSTextField.h"
@interface SignUpViewController ()
- (IBAction)signUpClicked:(id)sender;
@property (weak, nonatomic) IBOutlet TSTextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet TSTextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet TSTextField *emailTextField;
@property (weak, nonatomic) IBOutlet TSTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet TSTextField *confirmPasswordTextField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Sign Up";
    
//    THEME_RELATED;
//    UIButton *btn1 = (id)[self.view viewWithTag:101];
//    [btn1 setBackgroundColor:COLOR_ORANGE];
//    THEME_RELATED;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpClicked:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"ApplicationUsers"];
    [query whereKey:@"Email" equalTo:_emailTextField.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}
@end
