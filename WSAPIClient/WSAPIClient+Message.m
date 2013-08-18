//
//  WSAPIClient+Message.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSAPIClient.h"

#import "WSAPIClient+Private.h"
#import "WSHTTPClient.h"

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
        completionHandler(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(error);
    }];
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
