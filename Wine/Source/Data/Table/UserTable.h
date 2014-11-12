//
//  UserTable.h
//  Wine
//
//  Created by Vishnu on 11/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface UserTable : NSManagedObject{
    
    
}
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * age;
@end
