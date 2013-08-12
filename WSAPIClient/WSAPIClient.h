//
//  WSAPIClient.h
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSMessageThreadStatus.h"

@class WSHTTPClient;
@class WSFeedbackSubmission;
@class WSLocation;
@class WSUserDetails;

// Base URL used for all requests
#define BASE_URL @"http://warmshowers.dev"

// Maximum number of results to return when fetching users
#define MAX_USER_RESULTS 50

// Error domain
extern NSString * const WSAPIClientErrorDomain;

// Error codes
typedef NS_ENUM(NSInteger, WSAPIClientErrorCode) {
    WSAPIClientErrorCodeUnexpectedFormat = 1001,
    WSAPIClientErrorCodeSessionDataMissing = 1002
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
 The recipients is a comma-delimited set of usernames (not user IDs).
 */
- (void)sendMessageToRecipients:(NSString *)recipients subject:(NSString *)subject message:(NSString *)message completionHandler:(void (^)(NSError *errorOrNil))completionHandler;

/**
 Replay to a message in a thread.
 */
- (void)replyToMessageInThreadId:(NSInteger)messageThreadId message:(NSString *)message completionHandler:(void (^)(NSError *errorOrNil))completionHandler;

/**
 Fetch an array of WSMessage objects for the currenly logged on user.
 */
- (void)getAllMessagesWithCompletionHandler:(void (^)(NSArray *messages, NSError *errorOrNil))completionHandler;

/**
 Fetch an array of WSMessage objects for a specific message thread.
 */
- (void)getMessagesInThreadWithId:(NSInteger)messageThreadId completionHandler:(void (^)(NSArray *messages, NSError *errorOrNil))completionHandler;

/**
 Change the read status for a message thread.
 */
- (void)setMessageThreadReadStatus:(WSMessageThreadStatus)messageThreadStatus forMessageThreadId:(NSInteger)messageThreadId completionHandler:(void (^)(NSError *errorOrNil))completionHandler;

@end
