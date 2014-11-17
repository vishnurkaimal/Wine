//
//  CartTable.h
//  Wine
//
//  Created by experion on 17/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CartTable : NSManagedObject {

}

@property (nonatomic, retain) NSString * wineName;
@property (nonatomic, retain) NSNumber * wineQuantity;
@property (nonatomic,retain) NSNumber  *unitPrice;
@property (nonatomic,retain)NSData *wineDetailImage;
@property (nonatomic,retain)NSData *wineThumbImage;
@property (nonatomic,retain)NSData *wineId;
@property (nonatomic,retain)NSNumber *wineQtyRemains;
@end
