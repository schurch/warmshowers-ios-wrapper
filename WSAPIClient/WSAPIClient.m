//
//  WSAPIClient.m
//  WSAPIClient
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Stefan Church
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "WSAPIClient.h"

#import "WSHTTPClient.h"

NSString * const WSAPIClientErrorDomain = @"WSAPIClientErrorDomain";

@implementation WSAPIClient

#pragma mark - Init

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

#pragma mark - Error helpers

- (NSError *)errorWithCode:(WSAPIClientErrorCode)errorCode reason:(NSString *)reason
{
    NSDictionary *userInfo = @{ NSLocalizedFailureReasonErrorKey:reason };
    return [NSError errorWithDomain:WSAPIClientErrorDomain code:errorCode userInfo:userInfo];
}

- (NSError *)unexpectedFormatReponseError
{
    return [self errorWithCode:WSAPIClientErrorCodeUnexpectedFormat reason:NSLocalizedString(@"The response from the web server was in an unexpected format.", nil)];
}

@end
