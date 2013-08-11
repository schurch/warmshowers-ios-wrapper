//
//  WSAPIClientTests.m
//  WSAPIClientTests
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "WSAPI.h"

#define USERNAME @"stefan"
#define PASSWORD @"password"

@interface WSAPIClientTests : XCTestCase

@property (nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation WSAPIClientTests

- (void)setUp
{
    [super setUp];
    self.semaphore = dispatch_semaphore_create(0);
}

- (void)tearDown
{
    while (dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW)) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    
    [super tearDown];
}

#pragma mark - Login / logout

- (void)testLogin
{
    [[WSAPIClient sharedInstance] logoutWithCompletionHandler:^{
        [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when logging in: %@", errorOrNil.localizedDescription);
            XCTAssertNotNil(user, @"No user object was returned when logging in.");
            XCTAssertTrue([[WSAPIClient sharedInstance] canSignRequest], @"Unable to sign requests.");
            
            dispatch_semaphore_signal(self.semaphore);
        }];
    }];
}

- (void)testLogout
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] logoutWithCompletionHandler:^() {
            XCTAssertFalse([[WSAPIClient sharedInstance] canSignRequest], @"Can still sign requests.");
            
            dispatch_semaphore_signal(self.semaphore);
        }];
    }];
}

#pragma mark - User

- (void)testSearchForUsersInLocation
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        // build test location around Wellington
        WSLocation *location = [[WSLocation alloc] init];
        location.minimumLatitude = -41.317013;
        location.maximumLatitude = -41.198806;
        location.minimumLongitude = 174.703217;
        location.maximumLongitude = 174.987488;
        location.centerLatitude = (location.minimumLatitude + location.maximumLatitude) / 2;
        location.centerLongitude = (location.minimumLongitude + location.maximumLongitude) / 2;
        
        [[WSAPIClient sharedInstance] searchForUsersInLocation:location completionHandler:^(NSArray *users, NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when searching for users: %@", errorOrNil.localizedDescription);
            
            XCTAssertTrue([users count] > 0, @"No user objects were returned.");
            if ([users count] > 0) {
                XCTAssertTrue([users[0] isKindOfClass:[WSUser class]], @"Array does not contain WSUser objects.");
            }
            
            dispatch_semaphore_signal(self.semaphore);
        }];
    }];
}

- (void)testGetUserWithId
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] getUserWithId:24161 completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when fetching a user: %@", errorOrNil.localizedDescription);
            XCTAssertNotNil(user, @"No user object was returned.");
            
            dispatch_semaphore_signal(self.semaphore);
        }];
    }];
}

#pragma mark - Feedback

#pragma mark - Messages

@end
