//
//  WSAPIClient.h
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

#import <Foundation/Foundation.h>

#import "WSMessageThreadStatus.h"

@class WSHTTPClient;
@class WSFeedbackSubmission;
@class WSLocation;
@class WSMessageThread;
@class WSUserDetails;

// Base URL used for all requests
#define BASE_URL @"http://warmshowers.dev"

// Maximum number of results to return when fetching users
#define MAX_USER_RESULTS 50

// Error domain
extern NSString * const WSAPIClientErrorDomain;

// Error codes
typedef NS_ENUM(NSInteger, WSAPIClientErrorCode) {
    WSAPIClientErrorCodeUnexpectedFormat = 1,
    WSAPIClientErrorCodeSessionDataMissing = 2,
    WSAPIClientErrorCodeNoRecipients = 3,
    WSAPIClientErrorCodeActionUnsucessful = 4,
    WSAPICLientErrorCodeUsernameRequired = 5,
    WSAPIClientErrorCodePasswordRequired = 6,
    WSAPIClientErrorCodeNoSubject = 7,
    WSAPIClientErrorCodeMessageEmpty = 8,
    WSAPIClientErrorCodeFeedbackMessageEmpty = 9,
    WSAPIClientErrorCodeFeedbackDateMissing = 10
};

@interface WSAPIClient : NSObject

@property (nonatomic, strong) WSHTTPClient *client;

/**
 Singleton instance of the Warmshowers API Client.
 */
+ (instancetype)sharedInstance;

@end

@interface WSAPIClient (Login)

/**
 Returns true if we have credentials which we can use to sign requests; otherwise returns false.
 */
- (BOOL)canSignRequest;

/**
 Attempts to login to Warmshowers using the specified username and password.
 If successfull will cache the login credentials which are used by all further API calls.
 */
- (void)loginWithUsername:(NSString *)username password:(NSString *)password completionHandler:(void (^)(WSUserDetails *user, NSError *errorOrNil))completionHandler;

/**
 Performs a logout and clears the cached login credentials.
 */
- (void)logoutWithCompletionHandler:(void (^)())completionHandler;

@end

@interface WSAPIClient (User)

/**
 Search for users that are offering to host in the specified location.
 Returns an array of WSUser objects.
 */
- (void)searchForUsersInLocation:(WSLocation *)location completionHandler:(void (^)(NSArray *users, NSError *errorOrNil))completionHandler;

/**
 Fetch a user's details.
 */
- (void)getUserWithId:(NSInteger)userId completionHandler:(void (^)(WSUserDetails *user, NSError *errorOrNil))completionHandler;

@end

@interface WSAPIClient (Feedback)

/**
 Fetch the feedback for the specified user ID.
 If successfull, returns an array of WSFeedback objects.
 */
- (void)getFeedbackForUserWithId:(NSInteger)userId completionHandler:(void (^)(NSArray *feedback, NSError *errorOrNil))completionHandler;

/**
 Submit feedback for a user.
 */
- (void)submitFeedback:(WSFeedbackSubmission *)feedbackSubmission completionHandler:(void (^)(NSError *errorOrNil))completionHandler;

@end

@interface WSAPIClient (Message)

/**
 Fetch the unread message count for the currently logged in user.
 */
- (void)fetchUnreadMessageCountWithCompletionHandler:(void (^)(NSInteger count, NSError *errorOrNil))completionHandler;

/**
 Send a message to the specified recpients.
 Recipients is an array of usernames (not user IDs).
 */
- (void)sendMessageToRecipients:(NSArray *)recipients subject:(NSString *)subject message:(NSString *)message completionHandler:(void (^)(NSError *errorOrNil))completionHandler;

/**
 Replay to a messages in a thread.
 */
- (void)replyToMessageWithThreadId:(NSInteger)messageThreadId message:(NSString *)message completionHandler:(void (^)(NSError *errorOrNil))completionHandler;

/**
 Fetch an array of WSMessageThreadSummary objects for the currenly logged on user.
 */
- (void)getAllMessageThreadsWithCompletionHandler:(void (^)(NSArray *messageThreadSummaries, NSError *errorOrNil))completionHandler;

/**
 Fetch a specific message thread.
 */
- (void)getMessageThreadWithId:(NSInteger)messageThreadId completionHandler:(void (^)(WSMessageThread *messageThread, NSError *errorOrNil))completionHandler;

/**
 Change the read status for a message thread.
 */
- (void)setMessageThreadReadStatus:(WSMessageThreadStatus)messageThreadStatus forThreadId:(NSInteger)messageThreadId completionHandler:(void (^)(NSError *errorOrNil))completionHandler;

@end
