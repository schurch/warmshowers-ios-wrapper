//
//  WSAPIClient+Feedback.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSAPIClient.h"

#import "WSAPIClinet+Private.h"
#import "WSHTTPClient.h"
#import "WSFeedback.h"

@implementation WSAPIClient (Feedback)

- (void)getFeedbackForUserWithId:(NSInteger)userId completionHandler:(void (^)(NSArray *feedback, NSError *errorOrNil))completionHandler
{
    NSString *getPath = [NSString stringWithFormat:@"/user/%i/json_recommendations", userId];
    
    [self.client getPath:getPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        
        NSArray *arrayOfFeedbackData = responseObject[@"recommendations"];
        if (arrayOfFeedbackData) {
            NSMutableArray *results = [[NSMutableArray alloc] init];
            [arrayOfFeedbackData enumerateObjectsUsingBlock:^(NSDictionary *feedbackData, NSUInteger idx, BOOL *stop) {
                NSDictionary *feedbackDataItem = feedbackData[@"recommendation"];
                if (feedbackDataItem) {
                    WSFeedback *feedback = [[WSFeedback alloc] initWithDictionary:feedbackDataItem];
                    [results addObject:feedback];                    
                }
            }];
            
            completionHandler(results , nil);
        }
        else {
            completionHandler(nil , [self unexpectedFormatReponseError]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil , error);
    }];
}

- (void)submitFeedback:(WSFeedbackSubmission *)feedbackSubmission completionHandler:(void (^)(NSError *errorOrNil))completionHandler
{
    
}

@end
