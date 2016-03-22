//
//  FeelingsViewController.m
//  Haven
//
//  Created by Benjamin Harvey on 3/21/16.
//  Copyright © 2016 KZ. All rights reserved.
//

#import "FeelingsViewController.h"
#import <Parse/Parse.h>

@interface FeelingsViewController ()

@end

@implementation FeelingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)positiveClick:(UIButton *)sender {

    PFObject *gameScore = [PFObject objectWithClassName:@"Feelings"];
    PFUser *currentUser = [PFUser currentUser];
    gameScore[@"user"] = currentUser[@"username"];
    gameScore[@"feeling"] = @"Feeling good";
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            // There was a problem, check error.description
        }
    }];

}
- (IBAction)negativeClick:(UIButton *)sender {
    PFObject *gameScore = [PFObject objectWithClassName:@"Feelings"];
    PFUser *currentUser = [PFUser currentUser];
    gameScore[@"user"] = currentUser[@"username"];
    gameScore[@"feeling"] = @"Feeling bad";
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            // There was a problem, check error.description
        }
    }];
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
