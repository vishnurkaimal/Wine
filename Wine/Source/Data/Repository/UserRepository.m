//
//  UserRepository.m
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "UserRepository.h"
#import "UserTable.h"

#import <UIKit/UIKit.h>
#define ENTITY_USER @"User"
@implementation UserRepository

-(NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(BOOL)saveUserDetails:(UserRegistrationDTO *)userDto{
    NSManagedObjectContext *context = [self managedObjectContext];
    if([self isUserExists:userDto.email]){
        return NO;
    }
    else{
        NSError *error = nil;
        UserTable *userObj = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_USER inManagedObjectContext:context];
        [userObj setValue:userDto.email forKey:@"email"];
        [userObj setValue:userDto.password forKey:@"password"];
        [userObj setValue:userDto.age forKey:@"age"];
        if (![context save:&error]) {
            return NO;
        }
        else{
            return YES;
        }
    }
    return YES;
}

-(BOOL)isUserExists:(NSString *)emailText{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request= [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_USER inManagedObjectContext:context];
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"email==%@",emailText];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    if (array.count != 0) {
        NSUInteger count = [array count]; // may be 0 if the object has been deleted.
        NSLog(@"Username may exist, %i",count);
        return YES;
    }
    
    else {
        NSLog(@"Username does not exist.");
        return NO;
    }
}
@end
