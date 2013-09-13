//
//  WSAPIClient+Login.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSAPIClient.h"

#import "SSKeychain.h"
#import "WSAPIClient+Private.h"
#import "WSHttpClient.h"
#import "WSKeychainConstants.h"
#import "WSUser.h"
#import "WSUserDetails.h"

@implementation WSAPIClient (Login)

- (BOOL)canSignRequest
{
    NSString *sessionId = [SSKeychain passwordForService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_ID_KEY];
    NSString *sessionName = [SSKeychain passwordForService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_NAME_KEY];
    
    if ([sessionId length] > 0 && [sessionName length] > 0) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password completionHandler:(void (^)(WSUserDetails *user, NSError *errorOrNil))completionHandler
{
    if ([username length] == 0) {
        completionHandler(nil, [self errorWithCode:WSAPICLientErrorCodeUsernameRequired reason:@"A username is requred."]);
        return;
    }
    
    if ([password length] == 0) {
        completionHandler(nil, [self errorWithCode:WSAPIClientErrorCodePasswordRequired reason:@"A password is required."]);
        return;
    }
    
    NSDictionary *postParameters = @{ @"username": username, @"password": password };
    
    [self.client postPath:@"/services/rest/user/login" parameters:postParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        NSString *sessionId = responseObject[@"sessid"];
        NSString *sessionName = responseObject[@"session_name"];
        WSUserDetails *user = [[WSUserDetails alloc] initWithDictionary:responseObject[@"user"]];
        
        if (sessionId && sessionName) {
            [SSKeychain setPassword:sessionId forService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_ID_KEY];
            [SSKeychain setPassword:sessionName forService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_NAME_KEY];
            completionHandler(user, nil);
        }
        else {
            completionHandler(nil, [self errorWithCode:WSAPIClientErrorCodeSessionDataMissing reason:@"The login response from the web server is missing session information."]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil, error);
    }];
}

- (void)logoutWithCompletionHandler:(void (^)())completionHandler
{
    [self.client postPath:@"/services/rest/user/logout" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        NSNumber *response;
        if ([responseObject count] > 0) {
            response = responseObject[0];
        }
        
        if ([response isEqualToNumber:@1]) {
            NSLog(@"Successfully logged out of site.");
        }
        else {
            NSLog(@"Wasn't logged into site.");
        }
        
        [SSKeychain deletePasswordForService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_ID_KEY];
        [SSKeychain deletePasswordForService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_NAME_KEY];
        completionHandler(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"There was an error logging out of the website: %@", error.localizedDescription);
        [SSKeychain deletePasswordForService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_ID_KEY];
        [SSKeychain deletePasswordForService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_NAME_KEY];
        completionHandler(nil);
    }];
}

@end
