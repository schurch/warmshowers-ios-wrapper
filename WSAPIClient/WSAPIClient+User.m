//
//  WSAPIClient+User.m
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

#import "WSAPIClient+Private.h"
#import "WSHTTPClient.h"
#import "WSLocation.h"
#import "WSUser.h"
#import "WSUserDetails.h"

@implementation WSAPIClient (User)

- (void)searchForUsersInLocation:(WSLocation *)location completionHandler:(void (^)(NSArray *users, NSError *error))completionHandler
{
    NSAssert(location != nil, @"Location information is required to search for users.");
    
    NSDictionary *postParamters = @{ @"minlat": [NSString stringWithFormat:@"%f", location.minimumCoordinateForBoundingArea.latitude],
                                     @"maxlat": [NSString stringWithFormat:@"%f", location.maximumCoordinateForBoundingArea.latitude],
                                     @"minlon": [NSString stringWithFormat:@"%f", location.minimumCoordinateForBoundingArea.longitude],
                                     @"maxlon": [NSString stringWithFormat:@"%f", location.maximumCoordinateForBoundingArea.longitude],
                                     @"centerlat": [NSString stringWithFormat:@"%f", [location centerCoordinateForBoundingArea].latitude],
                                     @"centerlon": [NSString stringWithFormat:@"%f", [location centerCoordinateForBoundingArea].longitude],
                                     @"limit": [NSString stringWithFormat:@"%i", MAX_USER_RESULTS] };

    [self.client postPath:@"/services/rest/hosts/by_location" parameters:postParamters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        NSArray *arrayOfUserData = responseObject[@"accounts"];
        if (arrayOfUserData) {
            NSMutableArray *results = [[NSMutableArray alloc] init];
            [arrayOfUserData enumerateObjectsUsingBlock:^(NSDictionary *userData, NSUInteger idx, BOOL *stop) {
                WSUser *user = [[WSUser alloc] initWithDictionary:userData];
                [results addObject:user];
            }];
            completionHandler(results, nil);
        }
        else {
            completionHandler(nil, [self unexpectedFormatReponseError]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil, error);
    }];
}

- (void)getUserWithId:(NSInteger)userId completionHandler:(void (^)(WSUserDetails *user, NSError *error))completionHandler
{
    NSString *getPath = [NSString stringWithFormat:@"/user/%i/json", userId];
    
    [self.client getPath:getPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        NSArray *users = responseObject[@"users"];
        if ([users count] > 0) {
            NSDictionary *userDictionary = users[0][@"user"];
            if (userDictionary) {
                WSUserDetails *user = [[WSUserDetails alloc] initWithDictionary:userDictionary];
                completionHandler(user, nil);
            }
            else {
                completionHandler(nil, [self unexpectedFormatReponseError]);
            }
        }
        else {
            completionHandler(nil, [self unexpectedFormatReponseError]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil , error);
    }];
}

@end
