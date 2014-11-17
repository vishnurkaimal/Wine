//
//  UserRepository.m
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "UserRepository.h"
#import "UserTable.h"
#import "Utility.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#define ENTITY_USER @"User"
@implementation UserRepository


-(void)isUserExists:(NSString *)emailText WithResponseBlock:(void (^)(RegStatus))responseValue{

   PFQuery *query = [PFQuery queryWithClassName:@"User_Registration"];
   [query whereKey:@"email" equalTo:emailText];
   query.cachePolicy = kPFCachePolicyNetworkOnly;
    if ([query countObjects] == 0) {
        responseValue (RegStatusNotExists);
    }
    else {
         responseValue (RegStatusExists);
    }
}

-(void)registerUser:(UserRegistrationDTO *)regDTO WithResponseBlock:(void (^)(RegStatus ,NSError *))responseValue{
    
    [self isUserExists:regDTO.email WithResponseBlock: ^(RegStatus  regStatus){
        if(regStatus == RegStatusExists){
            responseValue(regStatus,nil);
        }
        else{
            PFObject *obj = [PFObject objectWithClassName:@"User_Registration"];
            [obj setObject:regDTO.email forKey:@"email"];
            [obj setObject:regDTO.password forKey:@"password"];
            [obj setObject:regDTO.age forKey:@"age"];
            [obj setObject:[Utility convertDateToString:[NSDate date]] forKey:@"register_date"];
            [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(error){
                responseValue(RegStatusError,error);
             }
            else{
                responseValue(RegStatusSuccess,error);
            }
            }];
        }
    }];
}

-(void)loginUser:(UserLoginDTO *)loginDTO WithResponseBlock:(void (^)(RegStatus ,NSError *))responseValue{
    
    [self isUserExists:loginDTO.email WithResponseBlock: ^(RegStatus  regStatus){
        if(regStatus == RegStatusNotExists){
            responseValue(regStatus,nil);
        }
        else{
            PFObject *obj = [PFObject objectWithClassName:@"User_Login"];
            [obj setObject:loginDTO.email forKey:@"email"];
            [obj setObject:loginDTO.password forKey:@"password"];
            [obj setObject:[Utility convertDateToString:[NSDate date]] forKey:@"login_date"];
            [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(error){
                    responseValue(RegStatusError,error);
                }
                else{
                    responseValue(RegStatusSuccess,error);
                }
            }];
        }
    }];
}

@end
