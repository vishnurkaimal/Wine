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
@end
