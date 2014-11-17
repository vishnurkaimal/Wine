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
#import "WAFacebook.h"
#import "UserRegistrationDTO.h"
#import "UserLoginDTO.h"
#import "WA_WineListViewController.h"
#import "ProgressHUDView.h"

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
    
    if([Utility isUserExits]){
        [self navigateToWineListView];
    }
    else{
    [self showNavBar:NO];
    [super viewWillAppear:YES];
    }
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
-(FBLoginStatus)setfbLoginResponseParams:(FBGraphObject *)graphObject{
    
    UserLoginDTO *loginDto = [[UserLoginDTO alloc]init];
    loginDto.email =  [graphObject objectForKey:@"email"];
    loginDto.dateOfBirth = [graphObject objectForKey:@"birthday"];
    if ((![loginDto.dateOfBirth isEqualToString:@"null"]) ||(loginDto.dateOfBirth !=nil)) {
       NSDate* dob= [Utility convertStringToDate:loginDto.dateOfBirth];
       NSInteger dateofBirth = [self ageFromBirthday:dob];
        if(dateofBirth<21){
            return FBLoginFailWithAge;
        }
    }
    if(loginDto.email.length ==0){
        return FBLoginFailWithoutEmail;
    }
    return FBLoginStatusSuccess;
}
-(void)navigateToWineListView{
    
    WA_WineListViewController *wineListView = (WA_WineListViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"WA_WineListViewController"];
    [self.navigationController pushViewController:wineListView animated:YES];
}

#pragma mark - Button Actions
-(IBAction)registrationButtonClicked:(id)sender{
    
    WA_RegistrationViewController *regViewController = (WA_RegistrationViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"WA_RegistrationViewController"];
    [self.navigationController pushViewController:regViewController animated:YES];
}
-(IBAction)loginButtonCliked:(id)sender{
    [self.view endEditing:YES];
    if([self validateAllTextField]){
         [self.view endEditing:YES];
        if([Utility checkForInternetConnection]){
          [self showProgressIndicator:@"Loading..."];
          UserLoginDTO *loginDto = [[UserLoginDTO alloc]init];
            loginDto.email = @"vishnu.kaimal@exp.com";//_emailField.text;
          loginDto.password = @"vishnu";//_passwordField.text;
          UserRepository *userRepo = [[UserRepository alloc]init];
          [userRepo loginUser:loginDto WithResponseBlock:^(RegStatus regStatus , NSError *error){
          [self hideModalProgressIndicator];
              switch (regStatus) {
                  case RegStatusSuccess:
                       NSLog(@"SUCESSFULLY LOGINED");
                      [Utility setValueInUserDefaults:@"1" forKey:USEREXISTS];
                      [self navigateToWineListView];
                      break;
                  case RegStatusNotExists:
                      [self showAlertWithTitle:@"Whoops!" message:@"User not exists, please register first"];
                      break;
                  case RegStatusError:
                      [self showAlertWithTitle:@"Whoops!" message:@"Unspecified error occured,please try again later!"];
                      break;
                  default:
                      break;
              }
           }];
        }
        else{
            [self showAlertWithTitle:@"Whoops!" message:@"Pleaser check your internet connection"];
            return;
        }
    }
}
-(IBAction)faceBookButtonClicked:(id)sender{
    
    if ([Utility checkForInternetConnection]) {
        WAFacebook *facebook = [WAFacebook share];
        [facebook LoginFacebook:^(id blockVar){
            id user = blockVar;
            if(user!= nil){
               FBGraphObject *objct = (FBGraphObject*)blockVar;
               FBLoginStatus fbstatus= [self setfbLoginResponseParams:objct];
                switch (fbstatus) {
                    case FBLoginFailWithAge:
                         [self showAlertWithTitle:@"Age!"message:@"Age should be atleast 21"];
                        break;
                    case FBLoginFailWithoutEmail:
                        [self showAlertWithTitle:@"Email!"message:@"We are unable to connect with your Email"];
                        break;
                    case FBLoginStatusSuccess:
                        [Utility setValueInUserDefaults:@"1" forKey:USEREXISTS];
                         NSLog(@"SUCESSFULLY LOGIN With FB");
                         [self navigateToWineListView];
                        break;
                    default:
                        break;
                }
            }
            else{
                [self showAlertWithTitle:@"Whoops!" message:@"No user found"];
            }
        }];
    }
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
