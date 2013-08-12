//
//  WSAPIClient.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSAPIClient.h"

#import "WSHTTPClient.h"

NSString * const WSAPIClientErrorDomain = @"WSAPIClientErrorDomain";

@implementation WSAPIClient

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static WSAPIClient *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[WSAPIClient alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.client = [[WSHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    }
    return self;
}

- (NSError *)unexpectedFormatReponseError
{
    NSDictionary *userInfo = @{ NSLocalizedFailureReasonErrorKey: @"The response from the web server was in an unexpected format." };
    return [NSError errorWithDomain:WSAPIClientErrorDomain code:WSAPIClientErrorCodeUnexpectedFormat userInfo:userInfo];
}

@end
