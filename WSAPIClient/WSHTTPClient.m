//
//  WSHttpClient.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSHTTPClient.h"

#import "AFJSONRequestOperation.h"
#import "SSKeychain.h"
#import "WSKeychainConstants.h"

@implementation WSHTTPClient

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.parameterEncoding = AFJSONParameterEncoding;
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }    
    return self;
}

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters
{
    if (!parameters) {
        parameters = @{};
    }
    
    NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:parameters];
    
    NSString *sessionId = [SSKeychain passwordForService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_ID_KEY];
    NSString *sessionName = [SSKeychain passwordForService:[[NSBundle bundleForClass:[self class]] bundleIdentifier] account:KEYCHAIN_SESSION_NAME_KEY];
    
    if ([sessionId length] > 0 && [sessionName length] > 0) {
        NSString *cookieValue = [NSString stringWithFormat:@"%@=%@", sessionName, sessionId];
        [request setValue:cookieValue forHTTPHeaderField:@"Cookie"];
    }
    
    return request;
}

@end
