//
//  WSAPIClientTests.m
//  WSAPIClientTests
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

- (void)testSubmitFeedback
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        WSFeedbackSubmission *feedbackSubmission = [[WSFeedbackSubmission alloc] init];
        feedbackSubmission.username = @"stefanchurch";
        feedbackSubmission.feedbackText = @"Neutral, other, aye. This is some more feedback for this user. Yup, yup, yup. Testing.";
        feedbackSubmission.feedbackDate = [NSDate date];
        feedbackSubmission.feedbackUserType = WSFeedbackUserTypeOther;
        feedbackSubmission.feedbackValue = WSFeedbackValueNeutral;
        
       [[WSAPIClient sharedInstance] submitFeedback:feedbackSubmission completionHandler:^(NSError *errorOrNil) {
           XCTAssertNil(errorOrNil, @"An error was returned when submitting feedback: %@", errorOrNil.localizedDescription);
           
           dispatch_semaphore_signal(self.semaphore);
       }];
    }];
}

#pragma mark - Messages

- (void)testFetchUnreadMessageCount
{
    [[WSAPIClient sharedInstance] loginWithUsername:USERNAME password:PASSWORD completionHandler:^(WSUserDetails *user, NSError *errorOrNil) {
        [[WSAPIClient sharedInstance] fetchUnreadMessageCountWithCompletionHandler:^(NSInteger count, NSError *errorOrNil) {
            NSLog(@"Unread message count: %i", count);
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
        [[WSAPIClient sharedInstance] setMessageThreadReadStatus:WSMessageThreadStatusRead forThreadId:50859 completionHandler:^(NSError *errorOrNil) {
            XCTAssertNil(errorOrNil, @"An error was returned when changing the message read status: %@", errorOrNil.localizedDescription);
            
            dispatch_semaphore_signal(self.semaphore);
        }];
    }];
}

- (void)testGetAllMessageThreads
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
