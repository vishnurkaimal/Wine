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
        [cartObj setValue:userCartDto.wineId  forKey:@"wineId"];
        [cartObj setValue:userCartDto.wineQtyRemains forKey:@"wineQtyRemains"];
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
        cartDTO.unitPrice                 = [cartObject valueForKey:@"unitPrice"];
        cartDTO.name                     = [cartObject valueForKey:@"wineName"]; 
        cartDTO.quantity                = [cartObject valueForKey:@"wineQuantity"];
        cartDTO.thumbImage               = [cartObject valueForKey:@"wineThumbImage"];
        cartDTO.wineDetailsImage         = [cartObject valueForKey:@"wineDetailImage"];
        cartDTO.wineId                   = [cartObject valueForKey:@"wineId"];
        [newsArray addObject:cartDTO];
    }
    return newsArray;
}
-(void)deleteAnItemfromCart:(UserCartDTO *)usrCartDto{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    CartTable *cartObj = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:managedObjectContext];
    [cartObj setValue:usrCartDto.name forKey:@"wineName"];
    [cartObj setValue:usrCartDto.quantity forKey:@"wineQuantity"];
    [cartObj setValue:usrCartDto.unitPrice forKey:@"unitPrice"];
    [cartObj setValue:usrCartDto.thumbImage forKey:@"wineThumbImage"];
    [cartObj setValue:usrCartDto.wineDetailsImage forKey:@"wineDetailImage"];
    [cartObj setValue:usrCartDto.wineId forKey:@"wineId"];
    [managedObjectContext deleteObject:cartObj];
    [managedObjectContext save:&error];
    
}




@end
