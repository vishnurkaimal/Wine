//
//  Utility.m
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "Utility.h"
#import "Constant.h"
#import <UIKit/UIKit.h>
@implementation Utility

+(BOOL)isUserExits{
    
    BOOL userStatus = NO;
    NSString * userVal = [self getValueFromUserDefaults:USEREXISTS];
    if([userVal isEqualToString:@"1"]){
        userStatus = YES;
    }
    return userStatus;
}

+(NSString *)trimTextField:(NSString*)textString{
    
    return [textString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
}

+(BOOL)currentVersionGreaterOrEqualtoIOS7{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= IOS7)
        return YES;
    else
        return NO;
}

+(NSString *)convertDateToString:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSString *startDateString = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    return startDateString;
}

+(void)setValueInUserDefaults:(id)value forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+(id)getValueFromUserDefaults:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
    
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
+(NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
