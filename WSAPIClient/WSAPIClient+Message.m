//
//  WSAPIClient+Message.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSAPIClient.h"

#import "WSAPIClinet+Private.h"
#import "WSHTTPClient.h"

@implementation WSAPIClient (Message)

- (void)fetchUnreadMessageCountWithCompletionHandler:(void (^)(NSInteger count, NSError *errorOrNil))completionHandler
{
    
}

- (void)sendMessageToRecipients:(NSString *)recipients subject:(NSString *)subject message:(NSString *)message completionHandler:(void (^)(NSError *errorOrNil))completionHandler
{
    
}

- (void)replyToMessageInThreadId:(NSInteger)messageThreadId message:(NSString *)message completionHandler:(void (^)(NSError *errorOrNil))completionHandler
{
    
}

- (void)getAllMessagesWithCompletionHandler:(void (^)(NSArray *messages, NSError *errorOrNil))completionHandler
{
    
}

- (void)getMessagesInThreadWithId:(NSInteger)messageThreadId completionHandler:(void (^)(NSArray *messages, NSError *errorOrNil))completionHandler
{
    
}

- (void)setMessageThreadReadStatus:(WSMessageThreadStatus)messageThreadStatus forMessageThreadId:(NSInteger)messageThreadId completionHandler:(void (^)(NSError *errorOrNil))completionHandler
{
    
}

@end
