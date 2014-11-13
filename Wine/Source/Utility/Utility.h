//
//  Utility.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject
+(NSString *)trimTextField:(NSString*)textString;
+(BOOL)currentVersionGreaterOrEqualtoIOS7;
+(NSString *)convertDateToString:(NSDate *)date;
+(NSDate *)convertStringToDate:(NSString *)dateString;
+(NSURL *)applicationDocumentsDirectory;
+(void)setValueInUserDefaults:(id)value forKey:(NSString *)key;
+(id)getValueFromUserDefaults:(NSString *)key;
+(BOOL)checkForInternetConnection;
+(BOOL) stringIsNotEmpty:(NSString *)string;

@end
