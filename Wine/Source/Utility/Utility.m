//
//  Utility.m
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "Utility.h"
#import "Constant.h"
#import "Reachability.h"
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
+(void)signOutUser{
    [Utility setValueInUserDefaults:@"0" forKey:USEREXISTS];
    
}
+(BOOL) stringIsNotEmpty:(NSString *)string{
    BOOL status =  NO;
    if((string.length>0 && string!=nil))
        status =  YES;
    return status;
    
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
+(BOOL)currentVersionGreaterOrEqualtoIOS8{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= IOS8)
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

+(NSDate *)convertStringToDate:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}
+(void)setValueInUserDefaults:(id)value forKey:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+(id)getValueFromUserDefaults:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
    
}
+(BOOL)checkForInternetConnection
{
    BOOL retVal = FALSE;
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        retVal = TRUE;
    }
    else {
        retVal = FALSE;
    }
    return retVal;
}
#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
+(NSURL *)applicationDocumentsDirectory
{
    NSLog(@"Application directory..%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
