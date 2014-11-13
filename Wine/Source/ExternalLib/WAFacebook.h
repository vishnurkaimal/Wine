//
//  VBFacebook.h
//  Veebow
//
//  Created by Layana on 19/10/13.
//
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface WAFacebook : NSObject
{
    FBSession *WASession;
}


@property (strong, nonatomic) FBSession *WASession;
+ (WAFacebook *) share;
//-(void)sessionType:(NSString *)type WithBlock:(void (^)(id))getUser;
-(void)sessionType:(NSString *) type Description:(NSString *)fbDescription image:(NSString *)image WithBlock:(void (^)(id))setUser;

- (void)LoginFacebook:(void (^)(id))setUser;
@end
