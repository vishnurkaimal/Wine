//
//  WA_WinedetailsViewController.h
//  Wine
//
//  Created by experion on 17/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractViewController.h"
#import "WineListDTO.h"
@interface WA_WinedetailsViewController : AbstractViewController<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
}

@property (nonatomic,retain)WineListDTO *wineListDTO;
//@property(nonatomic,strong)NSString *selectedWineTitle;
//@property(nonatomic,strong)NSString *selectedWineImageName;
//@property(nonatomic,strong)NSInteger score;
//@property(nonatomic,strong)NSString *tastePlate;



@end
