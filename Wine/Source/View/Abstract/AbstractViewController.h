//
//  AbstractViewController.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractViewController : UIViewController

-(void)showSignOutButton;
-(void)showNavBar:(BOOL)isNavBar;
-(BOOL)isEmailValidation:(NSString *)strEmail;
- (NSInteger)ageFromBirthday:(NSDate *)birthdate;
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)msg;
@end
