//
//  WineListDTO.h
//  Wine
//
//  Created by Vishnu on 11/17/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WineListDTO : NSObject
@property (nonatomic,retain)NSString   *winename;
@property (nonatomic,retain)NSData     *wineThumbImage;
@property (nonatomic,retain)NSString   *wineDescription;
@property (nonatomic,assign)NSInteger   score;
@property (nonatomic,retain)NSString    *tastePalate;
@property (nonatomic,retain)NSData     *wineDetailImage;
@property (nonatomic,assign)NSInteger   wineQtyRemains;
@property (nonatomic,assign)NSInteger   unitPrice;
@property (nonatomic,assign)NSInteger   wineId;
@end
