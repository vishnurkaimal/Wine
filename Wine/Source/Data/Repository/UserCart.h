//
//  UserCart.h
//  Wine
//
//  Created by experion on 17/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserCartDTO.h"
#import <CoreData/CoreData.h>

@interface UserCart : NSObject

-(NSManagedObjectContext *)managedObjectContext;
-(BOOL)saveUserDetails:(UserCartDTO *)userDto;
-(NSMutableArray *)fetchCartValuesFromTable;


@end
