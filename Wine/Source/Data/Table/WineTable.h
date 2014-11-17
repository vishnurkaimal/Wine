//
//  WineTable.h
//  Wine
//
//  Created by experion on 18/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface WineTable : NSManagedObject
@property (nonatomic, retain) NSString *   wineName;
@property (nonatomic,retain) NSNumber  *   unitPrice;
@property (nonatomic,retain)NSData     *   wineDetailImage;
@property (nonatomic,retain)NSData     *   wineThumbImage;
@property (nonatomic,retain)NSNumber   *   wineId;
@property (nonatomic,retain)NSNumber   *   wineQtyRemains;
@property (nonatomic,retain)NSNumber   *   score;
@property (nonatomic,retain)NSString   *   tastePalate;
@property (nonatomic,retain)NSString   *   wineDescription;
@end
