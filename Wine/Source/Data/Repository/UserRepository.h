//
//  UserRepository.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRegistrationDTO.h"
#import "UserLoginDTO.h"
#import <CoreData/CoreData.h>

typedef enum RegStatus : NSInteger RegStatus;
enum RegStatus : NSInteger {
    RegStatusSuccess,
    RegStatusExists,
    RegStatusNotExists,
    RegStatusError
};

@interface UserRepository : NSObject{
    
    
}
-(void)loginUser:(UserLoginDTO *)regDTO WithResponseBlock:(void (^)(RegStatus ,NSError *))responseValue;
-(void)registerUser:(UserRegistrationDTO *)regDTO WithResponseBlock:(void (^)(RegStatus ,NSError *))responseValue;
@end
