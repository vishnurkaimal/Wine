//
//  CartListTableViewCell.h
//  Wine
//
//  Created by experion on 17/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartListTableViewCell : UITableViewCell{
    
}
@property (nonatomic,retain)IBOutlet UIImageView *wineImageView;
@property (nonatomic,retain)IBOutlet UILabel *wineName;
@property (nonatomic,retain)IBOutlet UILabel *winePrice;
@property (nonatomic,retain)IBOutlet UILabel *wineQty;
@end
