//
//  WSAPIClient+Login.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSAPIClient.h"

#import "SSKeychain.h"
#import "WSHttpClient.h"
#import "WSKeychainConstants.h"
#import "WSAPIErrorConstants.h"
#import "WSUser.h"

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

- (void)loginWithUsername:(NSString *)username password:(NSString *)password completionHandler:(void (^)(WSUser *user, NSError *errorOrNil))completionHandler
{
    NSDictionary *postParameters = @{ @"username": username, @"password": password };
    
    [self.client postPath:@"/services/rest/user/login" parameters:postParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *sessionId = [responseObject objectForKey:@"sessid"];
        NSString *sessionName = [responseObject objectForKey:@"session_name"];
        WSUser *user = [[WSUser alloc] initWithDictionary:[responseObject objectForKey:@"user"]];
        
        if (sessionId && sessionName) {
            [SSKeychain setPassword:sessionId forService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_ID_KEY];
            [SSKeychain setPassword:sessionName forService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_NAME_KEY];
            completionHandler(user, nil);
        }
        else {
            NSDictionary *errorDetails = @{ NSLocalizedDescriptionKey: @"Session ID or Session Name missing from server response." };
            completionHandler(nil, [NSError errorWithDomain:WS_API_CLIENT_ERROR_DOMAIN code:MISSING_SESSION_INFORMATION userInfo:errorDetails]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil, error);
    }];
}

- (void)logoutWithCompletionHandler:(void (^)())completionHandler
{
    [self.client postPath:@"/services/rest/user/logout" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
