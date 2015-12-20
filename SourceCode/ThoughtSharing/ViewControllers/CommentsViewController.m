//
//  CommentsViewController.m
//  ThoughtSharing
//
//  Created by Rijo George on 16/12/15.
//  Copyright © 2015 Rijo George. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentsTableViewCell.h"


NSString *placeHolder = @"Add Comments";

@interface CommentsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    PFObject *group;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *commentsListArray;

@end

@implementation CommentsViewController



#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.commentsListArray = [[NSMutableArray alloc] init];
    self.tableView.estimatedRowHeight = 80.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.title = @"Comments";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myNotificationMethod:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myNotificationMethodHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

    
    
    [_txtViewComments setText:placeHolder];
    
    PFQuery *query = [PFQuery queryWithClassName:@"GroupComments"];
    [query whereKey:@"ClassID" equalTo:[group objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            [self.commentsListArray addObjectsFromArray:objects];
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoadingCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    PFObject *object = [self.commentsListArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [object valueForKey:@"UserID"];
    cell.commentLabel.text = [object valueForKey:@"Comment"];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.rowHeight;
}

- (void)setGroup:(PFObject *)object{
    group = object;
}

#pragma mark -
-(IBAction)btnSendClicked:(id)sender{
    
    if(_txtViewComments.text.length == 0){
        return;
    }
    
    
    

    
    
    NSString *comm = [_txtViewComments text];
    PFUser *currentUser = [PFUser currentUser];

    PFObject *gameScore = [PFObject objectWithClassName:@"GroupComments"];
    gameScore[@"ClassID"] = [group objectId];
    gameScore[@"UserID"] = [currentUser objectForKey:@"username"];
    gameScore[@"Comment"] = comm;
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {

            NSLog(@"comment added");
            
            [_txtViewComments setText:@""];
//            [_txtViewComments resignFirstResponder];
            
            [self.commentsListArray addObject:gameScore];
            [self.tableView reloadData];
            
            
            
            NSIndexPath* ipath = [NSIndexPath indexPathForRow: self.commentsListArray.count-1 inSection: 0];
            [_tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];

            
        } else {
            // There was a problem, check error.description
        }
    }];

    
}


#pragma mark - TextView
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:placeHolder]) {
        [textView setText:@""];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
//    CGRect rec = _tableView.frame;
//    rec.size.height = SCREEN_HEIGHT - 64 - 50;
//    [_tableView setFrame:rec];
//    
//    
//    CGRect rec2 = _viewBottom.frame;
//    rec2.origin.y = CGRectGetMaxY(rec);
//    [_viewBottom setFrame:rec2];
//
    
}

#pragma mark - Notificatrions
- (void)myNotificationMethod:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    hgtKeyboard = keyboardFrameBeginRect.size.height;
    
    CGRect rec = _tableView.frame;
    rec.size.height = SCREEN_HEIGHT - 64 - 50 - hgtKeyboard;
    [_tableView setFrame:rec];
    
    CGRect rec2 = _viewBottom.frame;
    rec2.origin.y = CGRectGetMaxY(rec);
    [_viewBottom setFrame:rec2];
    
}
- (void)myNotificationMethodHide:(NSNotification*)notification
{
    CGRect rec = _tableView.frame;
    rec.size.height = SCREEN_HEIGHT - 64 - 50;
    [_tableView setFrame:rec];
    
    
    CGRect rec2 = _viewBottom.frame;
    rec2.origin.y = CGRectGetMaxY(rec);
    [_viewBottom setFrame:rec2];
}


@end
