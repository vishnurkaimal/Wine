//
//  AbstractViewController.m
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "AbstractViewController.h"
#import "Utility.h"

#define SIGNOUT_ALERT_TAG 250
@interface AbstractViewController ()

@end

@implementation AbstractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)showSignOutButton{
    
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign out"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(signOutUser)];
    self.navigationItem.rightBarButtonItem = signOutButton;
    
}
-(void)showNavBar:(BOOL)isNavBar{
    if(isNavBar){
        self.navigationController.navigationBarHidden = NO;
    }
    else{
        self.navigationController.navigationBarHidden = YES;
    }
    
}


#pragma mark - Custom methods
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


-(BOOL)isEmailValidation:(NSString *)strEmail
{
    NSLog(@"%@",strEmail);
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:strEmail] == NO)
        return NO;
    return YES;
}
- (NSInteger)ageFromBirthday:(NSDate *)birthdate {
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:birthdate
                                       toDate:today
                                       options:0];
    return ageComponents.year;
}

- (void) showProgressIndicator:(NSString *)text {
    if (!progressIndicator) {
        progressIndicator = [[ProgressHUDView alloc] initWithView:self.view];
        progressIndicator.userInteractionEnabled = NO;
        progressIndicator.labelText = text;
        [self.view addSubview:progressIndicator];
        [progressIndicator show:YES];
    }
    
}

- (void) hideModalProgressIndicator {
    if(progressIndicator) {
        [progressIndicator removeFromSuperview];
        progressIndicator = nil;
    }
}
#pragma mark - Button Action

-(void)signOutUser{
    
    UIAlertView *signOutAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to Sign out" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    signOutAlert.tag = SIGNOUT_ALERT_TAG;
    [signOutAlert show];
    [Utility signOutUser];
    
}
#pragma mark - UIlaertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == SIGNOUT_ALERT_TAG) {
        if(buttonIndex == 1){
          [Utility signOutUser];
          [self .navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark - memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
