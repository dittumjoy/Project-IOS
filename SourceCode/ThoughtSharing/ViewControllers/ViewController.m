//
//  ViewController.m
//  ThoughtSharing
//
//  Created by Rijo George on 14/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "TSTextField.h"
@interface ViewController ()
- (IBAction)signUpClicked:(id)sender;
@property (weak, nonatomic) IBOutlet TSTextField *EmailTextField;

@property (weak, nonatomic) IBOutlet TSTextField *passwordTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Login";
    
    
//    THEME_RELATED;
//    UIButton *btn1 = (id)[self.view viewWithTag:101];
//    UIButton *btn2 = (id)[self.view viewWithTag:102];
//    UILabel *lbl1=(id)[self.view viewWithTag:103];
//    
//    [btn1 setBackgroundColor:COLOR_ORANGE];
//    [btn2 setBackgroundColor:COLOR_ORANGE];
//    [lbl1 setTextColor:COLOR_ORANGE];
//    THEME_RELATED;
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.EmailTextField.text = @"";
    self.passwordTextField.text = @"";
    
    [self.view endEditing:YES];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        [self performSegueWithIdentifier:@"showforum" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpClicked:(id)sender {
    if (self.EmailTextField.text.length==0 || self.passwordTextField.text.length==0)
        return;
    
    [PFUser logInWithUsernameInBackground:self.EmailTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"user  %@",user);
                                            [self performSegueWithIdentifier:@"showforum" sender:nil];
                                        } else {
                                            NSLog(@"error  %@",error);
                                            // The login failed. Check error to see why.
                                            [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"Please check your Email Id and Password" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
                                        }
                                    }];}
@end