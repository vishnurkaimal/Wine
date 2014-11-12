//
//  UserRepository.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDTO.h"
#import <CoreData/CoreData.h>
@interface UserRepository : NSObject{
    
    
}

-(BOOL)isUserExists:(NSString *)emailText;
-(BOOL)saveUserDetails:(UserDTO *)userDto;
-(NSManagedObjectContext *)managedObjectContext;
@end
