//
//  WineRepository.m
//  Wine
//
//  Created by Vishnu on 11/17/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "WineRepository.h"
#import "WineListDTO.h"
#import <Parse/Parse.h>
@implementation WineRepository
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
       [newsArray addObject:wineListDto];
    }
    return newsArray;
    
}
-(NSData *)convertPFFileToImage:(PFFile *)pfFileImage{
    
    return  [pfFileImage getData];
    
}
@end
