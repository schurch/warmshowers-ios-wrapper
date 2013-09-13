//
//  WSAPIClient+User.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
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
