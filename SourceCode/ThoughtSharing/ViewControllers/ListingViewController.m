//
//  ListingViewController.m
//  ThoughtSharing
//
//  Created by Rijo George on 16/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import "ListingViewController.h"
#import "ListingTableViewCell.h"
#import "ClassListingTableViewCell.h"
#import <Parse/Parse.h>
#import "CommentsViewController.h"

NSString *placeHolderForumDescription = @"Description";

@interface ListingViewController () <UITableViewDataSource,UITableViewDelegate>{
    PFObject *currentGroup;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *forumListArray;
@end

@implementation ListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    
    self.forumListArray = [[NSMutableArray alloc] init];

    [self initialSetup];
    
    self.tableView.estimatedRowHeight = 120.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.title = @"Forum";
    [self.navigationItem setHidesBackButton:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"Groups"];
//    [query whereKey:@"objectId" equalTo:[[PFUser object] objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            [self.forumListArray addObjectsFromArray:objects];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    

    [_viewAddForum setHidden:YES];
    
//    THEME_RELATED;
//    [_tableView setBackgroundColor:COLOR_ORANGE];
//    THEME_RELATED;
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"Sign out" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 60, 44)];
    [btn addTarget:self action:@selector(btnSignOutClicked) forControlEvents:UIControlEventTouchUpInside];
//    [btn.titleLabel setTextColor:[UIColor blackColor]];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    UIButton *btnAddForum = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnAddForum setTitle:@"Add Forum" forState:UIControlStateNormal];
    [btnAddForum setFrame:CGRectMake(0, 0, 80, 44)];
    [btnAddForum addTarget:self action:@selector(btnAddForumClicked) forControlEvents:UIControlEventTouchUpInside];
    [btnAddForum.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [btnAddForum setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    
    UIBarButtonItem *btnBar = [[UIBarButtonItem alloc]initWithCustomView:btn];
    UIBarButtonItem *btnBarAdd = [[UIBarButtonItem alloc]initWithCustomView:btnAddForum];

    [self.navigationItem setRightBarButtonItem:btnBar];
    [self.navigationItem setLeftBarButtonItem:btnBarAdd];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.forumListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClassListingTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    PFObject *group =  [self.forumListArray objectAtIndex:indexPath.row];
    cell.headerLabel.text = [group valueForKey:@"GroupName"];
    cell.descLabel.text = [group valueForKey:@"GroupDescription"];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.rowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currentGroup =  [self.forumListArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showdetail" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showdetail"])
    {
        // Get reference to the destination view controller
        CommentsViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setGroup:currentGroup];
    }
}

#pragma mark - MyMethods
-(void)initialSetup{
    [_viewAddForum.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_viewAddForum.layer setCornerRadius:5];
//    [_viewAddForum.layer setBorderWidth:1];
    [_viewAddForum setBackgroundColor:COLOR_RGB(242, 242, 242)];
    
    UITextField *txtFieldTitle = (id)[_viewAddForum viewWithTag:2];
    [txtFieldTitle.layer setCornerRadius:5];
    [txtFieldTitle.layer setBorderWidth:1];
    [txtFieldTitle.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [txtFieldTitle setBackgroundColor:[UIColor clearColor]];
    txtFieldTitle.delegate=self;

    UITextView *txtViewDesc = (id)[_viewAddForum viewWithTag:3];
    [txtViewDesc.layer setCornerRadius:5];
    [txtViewDesc.layer setBorderWidth:1];
    [txtViewDesc.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [txtViewDesc setBackgroundColor:[UIColor clearColor]];
    txtViewDesc.textColor = [UIColor lightGrayColor]; //optional
    txtViewDesc.delegate=self;

    UIButton *btnCancel = (id)[_viewAddForum viewWithTag:4];
    [btnCancel setBackgroundColor:[UIColor clearColor]];
    [btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(hideAddForumView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnSubmit = (id)[_viewAddForum viewWithTag:5];
    [btnSubmit setBackgroundColor:[UIColor clearColor]];
    [btnSubmit setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnSubmit addTarget:self action:@selector(submitForum) forControlEvents:UIControlEventTouchUpInside];
    
    [self resetAddForumView];

}
-(void)btnSignOutClicked{
    DISPLAY_METHOD_NAME;
    
    UIAlertView *al = [[UIAlertView alloc]initWithTitle:nil message:@"Do you want to Sign out" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [al show];
    al.tag = 100;
    
    
}
-(void)logoutFromParseAndPop{
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)btnAddForumClicked{
    [_viewAddForum setHidden:NO];
    [_tableView setUserInteractionEnabled:NO];
}
-(void)hideAddForumView{
    [_viewAddForum setHidden:YES];
    [self resetAddForumView];
    [_tableView setUserInteractionEnabled:YES];
}
-(void)resetAddForumView{
    UITextField *txtFieldTitle = (id)[_viewAddForum viewWithTag:2];
    UITextView *txtViewDesc = (id)[_viewAddForum viewWithTag:3];
    
    [txtFieldTitle setText:@""];
    txtViewDesc.textColor = [UIColor lightGrayColor];
    txtViewDesc.text = placeHolderForumDescription;
    [self.view endEditing:YES];
}
-(void)submitForum{
    
    
    
    UITextField *txtFieldTitle = (id)[_viewAddForum viewWithTag:2];
    UITextView *txtViewDesc = (id)[_viewAddForum viewWithTag:3];

    
    if (!txtFieldTitle.text.length) {
        return;
    }
    
    PFUser *currentUser = [PFUser currentUser];

    PFObject *newForum            = [PFObject objectWithClassName:@"Groups"];
    newForum[@"Owner"]            = [currentUser objectForKey:@"username"];
    newForum[@"GroupName"]        = txtFieldTitle.text;
    newForum[@"GroupDescription"] = txtViewDesc.text;


    [newForum saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            NSLog(@"new forum added");
            
            [self hideAddForumView];
            
            [self.forumListArray addObject:newForum];
            [self.tableView reloadData];
            
            
            
            NSIndexPath* ipath = [NSIndexPath indexPathForRow: self.forumListArray.count-1 inSection: 0];
            [_tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
            
            
        } else {
            // There was a problem, check error.description
        }
    }];
    

    
}
#pragma mark - Alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 100){
        if(buttonIndex == 1){
            [self logoutFromParseAndPop];
        }
    }
}

#pragma mark - TextView Delegates
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:placeHolderForumDescription]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = placeHolderForumDescription;
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}
@end
