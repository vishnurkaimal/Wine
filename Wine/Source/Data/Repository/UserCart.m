//
//  UserCart.m
//  Wine
//
//  Created by experion on 17/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "UserCart.h"
#import "CartTable.h"

#import <UIKit/UIKit.h>
#define ENTITY_USER @"User"

@implementation UserCart

-(NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(BOOL)saveUserDetails:(UserCartDTO *)userCartDto{
    NSManagedObjectContext *context = [self managedObjectContext];

        NSError *error = nil;
    CartTable *cartObj = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:context];
        [cartObj setValue:userCartDto.name forKey:@"wineName"];
        [cartObj setValue:userCartDto.quantity forKey:@"wineQuantity"];
    
        if (![context save:&error]) {
            return NO;
        }
        else{
            return YES;
        }
    
    return YES;
}


@end
