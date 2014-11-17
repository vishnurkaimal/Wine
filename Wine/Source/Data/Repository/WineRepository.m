//
//  WineRepository.m
//  Wine
//
//  Created by Vishnu on 11/17/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "WineRepository.h"
#import "WineListDTO.h"
#import "WineTable.h"
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>
@implementation WineRepository

-(NSManagedObjectContext *)managedObjectContext {
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)getWineStatusWithResponseBlock:(void (^)(NSMutableArray *,WineStatus))responseValue{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Wine_Details"];
    query.cachePolicy = kPFCachePolicyIgnoreCache;//kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *resultArray, NSError *error) {
    if(!error){
        if(resultArray.count!=0){
            
            NSMutableArray *wineListArray = [self getWineDetailsFromPFObject:resultArray];
            responseValue(wineListArray,wineStatus_Success);
        }
        else{
           responseValue((NSMutableArray *)resultArray,wineStatus_NoWineExists);
        }
    }
    else{
        responseValue(nil,wineStatus_Error);
    }
    }];
}
-(NSMutableArray *)getWineDetailsFromPFObject:(NSArray *)resultArray{
    
    NSMutableArray *newsArray   = [[NSMutableArray alloc]init];
    for (PFObject *pfObject  in resultArray) {
        WineListDTO *wineListDto = [[WineListDTO alloc]init];
        wineListDto.winename = [pfObject objectForKey:@"wine_name"];
        wineListDto.wineThumbImage = [self convertPFFileToImage:[pfObject objectForKey:@"wine_thumb_image"]];
        wineListDto.wineDescription = [pfObject objectForKey:@"wine_description"];
        wineListDto.wineDetailImage = [self convertPFFileToImage:[pfObject objectForKey:@"wine_detail_image"]];
        wineListDto.score = [[pfObject objectForKey:@"wine_score"]integerValue];
        wineListDto.tastePalate = [pfObject objectForKey:@"wine_taste_palate"];
        wineListDto.score = [[pfObject objectForKey:@"wine_score"]integerValue];
        wineListDto.unitPrice = [[pfObject objectForKey:@"wine_price"]integerValue];
        wineListDto.wineId = [[pfObject objectForKey:@"wine_id"]integerValue];
        wineListDto.wineQtyRemains = [[pfObject objectForKey:@"wine_qty_remains"]integerValue];
       [newsArray addObject:wineListDto];
    }
    NSMutableArray *winArray;
    if([self saveAllWinedetails:newsArray]){
        return [self fetchWineValuesFromTable];
    }
    return winArray;
    
}

-(NSMutableArray *)fetchWineValuesFromTable{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Wine"];
    NSMutableArray *wineArray =  [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    return [self getWinedetailsFromTable:wineArray];
}

-(NSMutableArray *)getWinedetailsFromTable:(NSMutableArray *)aArray{
    NSMutableArray *wineArray        = [[NSMutableArray alloc]init];
    for (WineTable *winetbl in aArray) {
        WineListDTO *wineListDTO         = [[WineListDTO alloc]init];
        wineListDTO.winename             = [winetbl valueForKey:@"wineName"];
        wineListDTO.unitPrice            = [[winetbl valueForKey:@"unitPrice"]integerValue];
        wineListDTO.wineDetailImage      = [winetbl valueForKey:@"wineDetailImage"];
        wineListDTO.wineThumbImage       = [winetbl valueForKey:@"wineThumbImage"];
        wineListDTO.wineId               = [[winetbl valueForKey:@"wineId"]integerValue];
        wineListDTO.wineQtyRemains       = [[winetbl valueForKey:@"wineQtyRemains"] integerValue];
        wineListDTO.score                = [[winetbl valueForKey:@"score"]integerValue];
        wineListDTO.tastePalate          = [winetbl valueForKey:@"tastePalate"];
        wineListDTO.wineDescription      = [winetbl valueForKey:@"wineDescription"];
        [wineArray addObject:wineListDTO];
    }
    return wineArray;
}

-(BOOL)saveAllWinedetails:(NSMutableArray *)wineArray{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    if([self deleteAllWineDetails]){
        for(WineListDTO *winelistDTO in wineArray){
            NSError *error = nil;
            WineTable *wineObj = [NSEntityDescription insertNewObjectForEntityForName:@"Wine" inManagedObjectContext:context];
            [wineObj setValue:winelistDTO.winename forKey:@"wineName"];
            [wineObj setValue:[NSNumber numberWithInteger:winelistDTO.unitPrice] forKey:@"unitPrice"];
            [wineObj setValue:winelistDTO.wineDetailImage forKey:@"wineDetailImage"];
            [wineObj setValue:winelistDTO.wineThumbImage forKey:@"wineThumbImage"];
            [wineObj setValue:[NSNumber numberWithInteger:winelistDTO.wineId]forKey:@"wineId"];
            [wineObj setValue:[NSNumber numberWithInteger:winelistDTO.wineQtyRemains] forKey:@"wineQtyRemains"];
            [wineObj setValue:[NSNumber numberWithInteger:winelistDTO.wineQtyRemains] forKey:@"score"];
            [wineObj setValue:winelistDTO.tastePalate forKey:@"tastePalate"];
            [wineObj setValue:winelistDTO.wineDescription forKey:@"wineDescription"];
            if (![context save:&error]) {
                return NO;
            }
        }
    }
    else{
        return NO;
    }
    return YES;
}

-(NSData *)convertPFFileToImage:(PFFile *)pfFileImage{
    
    return  [pfFileImage getData];
    
}

- (BOOL)deleteAllWineDetails
{
    BOOL statusValue = TRUE;
    
    NSError *error;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest1=[[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Wine"inManagedObjectContext:context];
    [fetchRequest1 setEntity:entityDescription];
    NSArray *wineArray = [context executeFetchRequest:fetchRequest1 error:&error];
    for (WineTable *newsObj in wineArray)
    {
        [context deleteObject:newsObj];
        [context save:&error];
    }
    return statusValue;
}

-(void)updateQtyremains:(NSNumber*)qtyremains andId:(NSNumber *)wineId{
    NSError *error;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest1=[[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Wine"inManagedObjectContext:context];
    [fetchRequest1 setEntity:entityDescription];
    NSArray *results = [context executeFetchRequest:fetchRequest1 error:&error];
    WineTable *wintbl = [results objectAtIndex:[wineId integerValue]-1];
    wintbl.wineQtyRemains = qtyremains;
    if (![context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }
}
@end
