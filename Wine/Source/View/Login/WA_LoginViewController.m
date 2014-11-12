//
//  ViewController.m
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "WA_LoginViewController.h"
#import "WA_RegistrationViewController.h"
#import "Constant.h"
#import "FontUtility.h"
#import "Utility.h"
#import "UserRepository.h"
#define BG_frame
@interface WA_LoginViewController (){

  CGRect bgFrame;
   
}
@property (nonatomic,retain)IBOutlet UILabel *headerLabel;
@property (nonatomic,retain)IBOutlet UIImageView * loginBgImageView;
@property (nonatomic,retain)IBOutlet UITextField *emailField;
@property (nonatomic,retain)IBOutlet UITextField *passwordField;
-(IBAction)registrationButtonClicked:(id)sender;
-(IBAction)faceBookButtonClicked:(id)sender;
-(IBAction)loginButtonCliked:(id)sender;
@end
@implementation WA_LoginViewController

#pragma mark- View Cycle
- (void)viewDidLoad {

    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:YES];
}
#pragma mark - Custom Methods
-(BOOL)validateAllTextField{
    
    if ( [[Utility trimTextField:_emailField.text] length]==0 || [[Utility trimTextField:_passwordField.text] length] == 0)
    {
        [self showAlertWithTitle:@"Whoops" message:@"Please enter all fields"];
        [self.view endEditing:YES];
        return NO;
    }
    else if(![self isEmailValidation:[Utility trimTextField:_emailField.text]]){
        
        [self showAlertWithTitle:@"Email" message:@"Enter a valid email."];
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}

#pragma mark - Button Actions
-(IBAction)registrationButtonClicked:(id)sender{
    
    WA_RegistrationViewController *regViewController = (WA_RegistrationViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"WA_RegistrationViewController"];
    [self.navigationController pushViewController:regViewController animated:YES];
}
-(IBAction)loginButtonCliked:(id)sender{
    [self.view endEditing:YES];
    if([self validateAllTextField]){
        UserRepository *userRepo = [[UserRepository alloc]init];
        if([userRepo isUserExists:[Utility trimTextField:_emailField.text]]){
            [Utility setValueInUserDefaults:@"1" forKey:USEREXISTS];
            NSLog(@"SUCESSFULLY LOGIN");
        }
        else{
            [self showAlertWithTitle:@"Whoops!" message:@"Mismatch in email and password"];
            return;
        }
    }
}
-(IBAction)faceBookButtonClicked:(id)sender{
    
    
    
}

#pragma mark - UItextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Memory Mangament
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
