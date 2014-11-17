//
//  AbstractViewController.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressHUDView.h"
@interface AbstractViewController : UIViewController{
    ProgressHUDView *progressIndicator;
}


-(void)showSignOutButton;
-(void)showNavBar:(BOOL)isNavBar;
- (void) hideModalProgressIndicator;
-(BOOL)isEmailValidation:(NSString *)strEmail;
- (NSInteger)ageFromBirthday:(NSDate *)birthdate;
- (void) showProgressIndicator:(NSString *)text;
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)msg;
@end
