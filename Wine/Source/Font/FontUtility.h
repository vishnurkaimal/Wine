//
//  FontUtility.h
//
//
//  Created by Vishnu on 10/11/14.

//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FontUtility : NSObject

typedef enum{
    // Titles, headers
    FStandardHeader,
    
    FXLargeThinCopy,
    
    // Descriptive labels
    FLargeCopy,

    FMediumLightCopy,

    FStandardCopy,
    FStandardBoldCopy,

    FSmallCopy,
    FSmallItalicCopy,
    FSmallBoldCopy,
    
    FTinyCopy
    
} FontType;

+ (UIFont *)fontForFontTypeEnum:(FontType)fontType;

@end
