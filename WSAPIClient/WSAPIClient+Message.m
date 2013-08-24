//
//  WSAPIClient+Message.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSAPIClient.h"

#import "WSMessageThread.h"
#import "WSMessageThreadSummary.h"
#import "WSHTTPClient.h"

#import "WSAPIClient+Private.h"

@implementation WSAPIClient (Message)

- (void)fetchUnreadMessageCountWithCompletionHandler:(void (^)(NSInteger count, NSError *errorOrNil))completionHandler
{
    [self.client postPath:@"/services/rest/message/unreadCount" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        if ([responseObject count] == 1) {
            NSInteger count = [responseObject[0] integerValue];
            completionHandler(count, nil);
        }
        else {
            completionHandler(0, [self unexpectedFormatReponseError]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(0, error);
    }];
}

- (void)sendMessageToRecipients:(NSArray *)recipients subject:(NSString *)subject message:(NSString *)message completionHandler:(void (^)(NSError *errorOrNil))completionHandler
{
    if ([recipients count] == 0) {
        completionHandler([self errorWithCode:WSAPIClientErrorCodeNoRecipients reason:@"There were no recipients specified."]);
    }
    
    NSDictionary *postParamters = @{ @"recipients": [recipients componentsJoinedByString:@","],
                                     @"subject": subject,
                                     @"body": message };
    
    [self.client postPath:@"/services/rest/message/send" parameters:postParamters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        if ([responseObject count] == 1 && [responseObject[0] integerValue] == 1) {
            completionHandler(nil);
        }
        else {
            completionHandler([self errorWithCode:WSAPIClientErrorCodeActionUnsucessful reason:@"There was an error sending the message."]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(error);
    }];
}

- (void)replyToMessageWithThreadId:(NSInteger)messageThreadId message:(NSString *)message completionHandler:(void (^)(NSError *errorOrNil))completionHandler
{
    NSDictionary *postParamters = @{ @"thread_id": [NSNumber numberWithInt:messageThreadId],
                                     @"body": message };
    
    [self.client postPath:@"/services/rest/message/reply" parameters:postParamters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        if ([responseObject count] == 1 && [responseObject[0] integerValue] == 1) {
            completionHandler(nil);
        }
        else {
            completionHandler([self errorWithCode:WSAPIClientErrorCodeActionUnsucessful reason:@"There was an error replying to the message."]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(error);
    }];
}

- (void)getAllMessageThreadsWithCompletionHandler:(void (^)(NSArray *messageThreadSummaries, NSError *errorOrNil))completionHandler
{
    [self.client postPath:@"/services/rest/message/get" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *messages = [[NSMutableArray alloc] init];
            [responseObject enumerateObjectsUsingBlock:^(NSDictionary *messageData, NSUInteger idx, BOOL *stop) {
                WSMessageThreadSummary *message = [[WSMessageThreadSummary alloc] initWithDictionary:messageData];
                [messages addObject:message];
            }];
            
            completionHandler(messages, nil);
        }
        else {
            completionHandler(nil, [self unexpectedFormatReponseError]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil, error);
    }];
}

- (void)getMessageThreadWithId:(NSInteger)messageThreadId completionHandler:(void (^)(WSMessageThread *messageThread, NSError *errorOrNil))completionHandler
{
    NSDictionary *postParamters = @{ @"thread_id": [NSNumber numberWithInt:messageThreadId] };
    
    [self.client postPath:@"/services/rest/message/getThread" parameters:postParamters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        WSMessageThread *messageThread = [[WSMessageThread alloc] initWithDictionary:responseObject];
        completionHandler(messageThread, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil, error);
    }];
}

- (void)setMessageThreadReadStatus:(WSMessageThreadStatus)messageThreadStatus forThreadId:(NSInteger)messageThreadId completionHandler:(void (^)(NSError *errorOrNil))completionHandler
{
    NSDictionary *postParamters = @{ @"thread_id": [NSNumber numberWithInt:messageThreadId],
                                     @"status": messageThreadStatus == WSMessageThreadStatusRead ? @0 : @1 };
    
    [self.client postPath:@"/services/rest/message/markThreadRead" parameters:postParamters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        if ([responseObject count] == 1 && [responseObject[0] integerValue] == 1) {
            completionHandler(nil);
        }
        else {
            completionHandler([self errorWithCode:WSAPIClientErrorCodeActionUnsucessful reason:@"There was an error chaning the message status."]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(error);
    }];
}

@end
