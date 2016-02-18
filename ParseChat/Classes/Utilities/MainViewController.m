//
//  MainViewController.m
//  Haven
//
//  Created by Benjamin Harvey on 2/17/16.
//  Copyright © 2016 KZ. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>
#import "utilities.h"
#import "ChatView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    CGRect fullScreen = [[UIScreen mainScreen] bounds];
    self.tabBarController.tabBar.hidden=YES;
    [self setExtendedLayoutIncludesOpaqueBars:YES];
    
    [[self.tabBarController.view.subviews objectAtIndex:0]setFrame:fullScreen];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didSelectSingleUser:(PFUser *)user2
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    PFUser *user1 = [PFUser currentUser];
    NSString *groupId = StartPrivateChat(user1, user2);
    [self actionChat:groupId];
}

- (void)actionChat:(NSString *)groupId
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    ChatView *chatView = [[ChatView alloc] initWith:groupId];
    chatView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatView animated:YES];
}

- (void)goToMsAnderson
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
    PFQuery *query2 = [PFQuery queryWithClassName:PF_USER_CLASS_NAME];
    [query2 whereKey:PF_USER_FULLNAME_LOWER equalTo:@"ms. anderson"];
    [query2 setLimit:1];
    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error == nil)
         {
             PFUser *msAnderson = objects.firstObject;
             
             [self didSelectSingleUser:msAnderson];
             
         }
         
     
     }];
}


- (IBAction)clickedBullyAlert:(UIButton *)sender {
    [self goToMsAnderson];
}

- (IBAction)clickedNeedToShare:(UIButton *)sender {
    [self goToMsAnderson];
}

- (IBAction)clickedReferA:(UIButton *)sender {
    if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        controller.body = @"Hello";
        controller.recipients = [NSArray arrayWithObjects:@"+1234567890", nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (IBAction)clickedMessageTeacher:(UIButton *)sender {
    [self goToMsAnderson];
}

- (IBAction)clickedSchedule:(UIButton *)sender {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:4];
    [comps setMonth:7];
    [comps setYear:2010];
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    [self showCalendarOnDate:[cal dateFromComponents:comps]];
}

- (void)showCalendarOnDate:(NSDate *)date
{
    // calc time interval since 1 January 2001, GMT
    NSInteger interval = [date timeIntervalSinceReferenceDate];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"calshow:%ld", interval]];
    [[UIApplication sharedApplication] openURL:url];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
