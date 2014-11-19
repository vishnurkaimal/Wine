//
//  WineRepository.h
//  Wine
//
//  Created by Vishnu on 11/17/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum WineStatus : NSInteger WineStatus;
enum WineStatus : NSInteger {
    wineStatus_Success,
    wineStatus_NoWineExists,
    wineStatus_Error
};

@interface WineRepository : NSObject{
    
}
-(void)updateQtyremains:(NSNumber*)qtyremains andId:(NSNumber *)wineId;
-(void)getWineStatusWithResponseBlock:(void (^)(NSMutableArray *,WineStatus))responseValue;
-(void)getRemainingWineQuantityFromServer:(NSNumber *)wineId andQuantity:(NSNumber *)wineQuantity isSubstract:(BOOL)isSubstract WithResponseBlock:(void (^)(WineStatus))responseValue;
@end
