//
//  UserRepository.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRegistrationDTO.h"
#import <CoreData/CoreData.h>
@interface UserRepository : NSObject{
    
    
}

-(BOOL)isUserExists:(NSString *)emailText;
-(BOOL)saveUserDetails:(UserRegistrationDTO *)userDto;
-(NSManagedObjectContext *)managedObjectContext;
@end
