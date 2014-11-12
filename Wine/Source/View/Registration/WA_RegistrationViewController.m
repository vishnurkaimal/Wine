//
//  WA_RegistrationViewController.m
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "WA_RegistrationViewController.h"
#import "Utility.h"
#import "Constant.h"
#import "UserDTO.h"
#import "UserRepository.h"
@interface WA_RegistrationViewController (){
    
    
}

@property (nonatomic,retain)IBOutlet UIView *backgrondView;
@property (nonatomic,retain)IBOutlet UIView *backgrondLabel;
@property (nonatomic,retain)IBOutlet UITextField *emailField;
@property (nonatomic,retain)IBOutlet UITextField *passwordField;
@property (nonatomic,retain)IBOutlet UITextField *confirmPasswordField;
@property (nonatomic,retain)IBOutlet UITextField *ageField;
@property(nonatomic,retain)UIDatePicker *pickerView;
@property(nonatomic,retain)UIActionSheet *pickerViewPopup;
@property (nonatomic,assign) NSInteger age;
-(IBAction)registerUser:(id)sender;
@end

@implementation WA_RegistrationViewController

#pragma mark - View Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"Registration";
    [self arrangeScreen];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
}

#pragma mark - Custom methods
-(void)arrangeScreen{
    _backgrondLabel.layer.cornerRadius = 10;
    _backgrondView.layer.cornerRadius  = 5;
}

-(BOOL)validateAllTextField{
    if ( [[Utility trimTextField:_emailField.text] length]==0 || [[Utility trimTextField:_passwordField.text] length] == 0 || [[Utility trimTextField:_confirmPasswordField.text ] length] == 0 || [[Utility trimTextField:_ageField.text] length] == 0)
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
    
    else if(![[Utility trimTextField:_passwordField.text] isEqualToString:[Utility trimTextField:_confirmPasswordField.text]]){
        
        [self showAlertWithTitle:@"Password" message:@"Mismatch in password"];
        [self.view endEditing:YES];
        return NO;
    }
    else if(_age<21){
        
        [self showAlertWithTitle:@"Age" message:@"Age should be atleast 21"];
        [self.view endEditing:YES];
        return NO;

    }
    return YES;
}


#pragma mark - Button Actions
-(void)doneButtonPressed:(id)sender{
    NSDate *selectDate = self.pickerView.date;
    _age = [self ageFromBirthday:selectDate];
    _ageField.text = [Utility convertDateToString:selectDate];
     [self.pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

-(void)cancelButtonPressed:(id)sender{
    [self.pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}
#pragma mark - UIbutton Actions

-(IBAction)registerUser:(id)sender{
    
 if([self validateAllTextField]){
        [self.view endEditing:YES];
        UserRepository *usrRepository = [[UserRepository alloc]init];
        UserDTO *usrDTO = [[UserDTO alloc]init];
        usrDTO.email = [Utility trimTextField:_emailField.text] ;
        usrDTO.password =[Utility trimTextField:_passwordField.text];
        usrDTO.age = [NSString stringWithFormat:@"%i",_age];
        if(![usrRepository saveUserDetails:usrDTO]){
           [self showAlertWithTitle:@"Whoops!" message:@"User Already Exists"];
            return;
        }
        else{
            NSLog(@"Successfully Registerd");;
        }
    }
}

#pragma mark - UItextfield delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 250 ||textField.tag == 251 ){
        // allow backspace
        if (range.length > 0 && [
                                 
                                 string length] == 0)
        {
            return YES;
        }
        // do not allow . at the beggining
        if (range.location == 0 && [string isEqualToString:@"."])
        {
            return NO;
        }
        if (range.location == 9)
        {
            return NO;
        }
     }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)aTextField{
     if(aTextField.tag == 252){
         [self.view endEditing:YES];
         _pickerViewPopup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
         _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
         [_pickerView  setBackgroundColor:[UIColor whiteColor]];
         //_pickerViewPopup.backgroundColor = [UIColor greenColor];
         _pickerView.datePickerMode = UIDatePickerModeDate;
         _pickerView.hidden = NO;
         UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
         pickerToolbar.barStyle = UIBarStyleBlackOpaque;
         [pickerToolbar sizeToFit];
         pickerToolbar.translucent = YES;
         if([Utility currentVersionGreaterOrEqualtoIOS7])
             pickerToolbar.barTintColor = UIColorFromRGB(0xA4D3EE);
         else
             pickerToolbar.tintColor = UIColorFromRGB(0xA4D3EE);
         NSMutableArray *barItems = [[NSMutableArray alloc] init];
         
         UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
         [barItems addObject:flexSpace];
         
         UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
         [barItems addObject:doneBtn];
         
         UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
         [barItems addObject:cancelBtn];
         
         [pickerToolbar setItems:barItems animated:YES];
         
         [_pickerViewPopup addSubview:pickerToolbar];
         [_pickerViewPopup addSubview:_pickerView];
         [_pickerViewPopup showInView:self.view];
         [_pickerViewPopup setBounds:CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height)];
    
     }

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

#pragma mark - Memoy warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
