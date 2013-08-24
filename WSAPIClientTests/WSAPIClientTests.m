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
        location.minimumCoordinateForBoundingArea = CLLocationCoordinate2DMake(-41.317013, 174.703217);
        location.maximumCoordinateForBoundingArea = CLLocationCoordinate2DMake(-41.198806, 174.987488);
        
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

- (void)testGetFeedback
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] getFeedbackForUserWithId:13510 completionHandler:^(NSArray *feedback, NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when fetching feedback: %@", errorOrNil.localizedDescription);
            
            XCTAssertTrue([feedback count] > 0, @"No feedback objects were returned.");
            if ([feedback count] > 0) {
                XCTAssertTrue([feedback[0] isKindOfClass:[WSFeedback class]], @"Array does not contain WSFeedback objects.");
            }
            
            dispatch_semaphore_signal(self.semaphore);
        }];
    }];
}

#warning Feedback submission is always returning a 401 error
//- (void)testSubmitFeedback
//{
//    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
//        WSFeedbackSubmission *feedbackSubmission = [[WSFeedbackSubmission alloc] init];
//       [[WSAPIClient sharedInstance] submitFeedback:feedbackSubmission completionHandler:^(NSError *errorOrNil) {
//           XCTAssertNil(errorOrNil, @"An error was returned when submitting feedback: %@", errorOrNil.localizedDescription);
//           
//           dispatch_semaphore_signal(self.semaphore);
//       }];
//    }];
//}

#pragma mark - Messages

- (void)testFetchUnreadMessageCount
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] fetchUnreadMessageCountWithCompletionHandler:^(NSInteger count, NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when fetching unread message count: %@", errorOrNil.localizedDescription);
            
            dispatch_semaphore_signal(self.semaphore);
            
        }];
    }];
}

- (void)testSendMessageToRecipients
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] sendMessageToRecipients:@[@"stefan", @"stefanchurch"] subject:@"Test subject" message:@"This is my test message. Testing, testing, testing, 1, 2, 3." completionHandler:^(NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when sending a message: %@", errorOrNil.localizedDescription);
            
            dispatch_semaphore_signal(self.semaphore);
            
        }];
    }];
}

- (void)testReplyToMessage
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] replyToMessageWithThreadId:50857 message:@"Aye, received that ok." completionHandler:^(NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when replaying to a message: %@", errorOrNil.localizedDescription);
            
            dispatch_semaphore_signal(self.semaphore);
            
        }];
    }];
}

- (void)testMessageReadStatus
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] setMessageThreadReadStatus:WSMessageThreadStatusRead forThreadId:50855 completionHandler:^(NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when changing the message read status: %@", errorOrNil.localizedDescription);
            
            dispatch_semaphore_signal(self.semaphore);
        }];
    }];
}

- (void)testGetAllMessages
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] getAllMessageThreadsWithCompletionHandler:^(NSArray *messageThreadSummaries, NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"There was an error fetching all the message threads: %@", errorOrNil.localizedDescription);
            
            XCTAssertTrue([messageThreadSummaries count] > 0, @"No message objects were returned.");
            if ([messageThreadSummaries count] > 0) {
                XCTAssertTrue([messageThreadSummaries[0] isKindOfClass:[WSMessageThreadSummary class]], @"Array does not contain WSMessageThreadSummary objects.");
            }
            
            dispatch_semaphore_signal(self.semaphore);
            
        }];
    }];
}

- (void)testGetMessageThread
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] getMessageThreadWithId:50857 completionHandler:^(WSMessageThread *messageThread, NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"There was an error fetching the message thread: %@", errorOrNil.localizedDescription);
            XCTAssertNotNil(messageThread, @"no message thread object was returned.");
            
            dispatch_semaphore_signal(self.semaphore);
        }];
    }];
}

@end
