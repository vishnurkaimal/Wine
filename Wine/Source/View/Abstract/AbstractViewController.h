//
//  AbstractViewController.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractViewController : UIViewController
-(BOOL)isEmailValidation:(NSString *)strEmail;
-(void)showAlertWithTitle:(NSString *)title message:(NSString *)msg;
@end
