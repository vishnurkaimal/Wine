//
//  VBFacebook.m
//  Veebow
//
//  Created by Layana on 19/10/13.
//
//

#import "WAFacebook.h"
#define FBAPPID_TEST @"573706196062557"


@interface WAFacebook ()
    -(void)getFBUserWithBlockString:(void (^)(id))getUser;
@end

@implementation WAFacebook

@synthesize WASession;
static WAFacebook *shareFacebook = nil;

+ (WAFacebook *) share
{
    if(shareFacebook == nil)
		shareFacebook = [[self alloc] init];
	return shareFacebook;
}

-(void)sessionCache{
    if (WASession.isOpen)
        [WASession closeAndClearTokenInformation];
}

- (void)LoginFacebook:(void (^)(id))setUser{
    if (!WASession.isOpen){
        WASession = [[FBSession alloc] init];
        [WASession closeAndClearTokenInformation];
    }
    NSArray *permissions = [[NSArray alloc]initWithObjects:@"publish_actions",@"user_birthday",@"publish_stream",@"user_about_me",@"email",@"public_profile",@"user_photos",nil];
    self.WASession = [[FBSession alloc]initWithAppID:FBAPPID_TEST permissions:permissions urlSchemeSuffix:nil tokenCacheStrategy:nil];
    [FBSession setActiveSession:self.WASession];
    
    [WASession openWithCompletionHandler:^(FBSession *session,
                                           FBSessionState status,
                                           NSError *error) {
        NSLog(@"Session : %@",session);
        FBSession.activeSession = session;
        [self getFBUserWithBlockString:^(id user) {
                setUser(user);
            }];
        
        
    }];
}

-(void)getFBUserWithBlockString:(void (^)(id))setUser{
    
    [FBRequestConnection startWithGraphPath:@"me" parameters:nil HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id user,  NSError *error) {
                              if(!error){
                                  NSLog(@"User : %@",user);
                                  if(user){
                                      setUser(user);
                                  }
                              }
                              else{
                                  setUser(nil);
                              }
                          }];
    
}
@end
