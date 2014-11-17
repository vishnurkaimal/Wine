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
         [cartObj setValue:userCartDto.unitPrice forKey:@"unitPrice"];
        [cartObj setValue:userCartDto.thumbImage forKey:@"wineThumbImage"];
        [cartObj setValue:userCartDto.wineDetailsImage forKey:@"wineDetailImage"];
        if (![context save:&error]) {
            return NO;
        }
        else{
            return YES;
        }
    
    return YES;
}

-(NSMutableArray *)fetchCartValuesFromTable{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Cart"];
    NSMutableArray *cartArray =  [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    return [self formatCartValuesFromTable:cartArray];
}

-(NSMutableArray *)formatCartValuesFromTable:(NSMutableArray *)cartArray {
    
    NSMutableArray *newsArray        = [[NSMutableArray alloc]init];
    for (CartTable *cartObject in cartArray) {
        UserCartDTO *cartDTO             = [[UserCartDTO alloc]init];
        cartDTO.quantity                 = [cartObject valueForKey:@"unitPrice"];
        cartDTO.name                     = [cartObject valueForKey:@"wineQuantity"];
        cartDTO.unitPrice                = [cartObject valueForKey:@"wineName"];
        cartDTO.thumbImage               = [cartObject valueForKey:@"wineThumbImage"];
        cartDTO.wineDetailsImage         = [cartObject valueForKey:@"wineDetailImage"];
        [newsArray addObject:cartDTO];
    }
    return newsArray;
}


@end
