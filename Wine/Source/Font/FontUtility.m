//
//  FontUtility.m
//
//
//  Created by Vishnu on 10/11/14.

//

#import "FontUtility.h"

@implementation FontUtility

+ (UIFont *)fontForFontTypeEnum:(FontType)fontType
{
    switch(fontType) {
        
        case FXLargeThinCopy:
            return [UIFont fontWithName:@"HelveticaNeue-Thin" size:24];
        
        case FStandardHeader:
            return [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
        
        case FLargeCopy:
            return [UIFont fontWithName:@"HelveticaNeue" size:20];
            
        case FMediumLightCopy:
            return [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
        
        case FStandardCopy:
            return [UIFont fontWithName:@"HelveticaNeue" size:14];
            
        case FStandardBoldCopy:
            return [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        
        case FSmallCopy:
            return [UIFont fontWithName:@"HelveticaNeue" size:12];
            
        case FSmallItalicCopy:
            return [UIFont fontWithName:@"HelveticaNeue-Italic" size:12]; //[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:12]; (Fixes 7.0.3)
            
        case FSmallBoldCopy:
            return [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
            
        case FTinyCopy:
            return [UIFont fontWithName:@"HelveticaNeue" size:10];
            
        default:
            return [self fontForFontTypeEnum:FStandardCopy];
    }
}

@end
