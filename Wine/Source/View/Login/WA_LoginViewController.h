//
//  ViewController.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
typedef enum FBLoginStatus : NSInteger FBLoginStatus;
enum FBLoginStatus : NSInteger {
    FBLoginFailWithAge,
    FBLoginFailWithoutEmail,
    FBLoginFailWithError,
    FBLoginStatusSuccess
};
@interface WA_LoginViewController: AbstractViewController<UITextFieldDelegate>


@end

