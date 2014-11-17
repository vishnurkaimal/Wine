//
//  UserCartDTO.h
//  Wine
//
//  Created by experion on 17/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCartDTO : NSObject

@property (nonatomic,retain)NSNumber *quantity;
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSNumber *unitPrice;
@property (nonatomic,retain)NSData * thumbImage;
@property (nonatomic,retain)NSData * wineDetailsImage;



@end
