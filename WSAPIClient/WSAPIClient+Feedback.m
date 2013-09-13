//
//  WSAPIClient+Feedback.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSAPIClient.h"

#import "AFJSONRequestOperation.h"
#import "WSAPIClient+Private.h"
#import "WSHTTPClient.h"
#import "WSFeedback.h"
#import "WSFeedbackSubmission.h"

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
    NSAssert(feedbackSubmission != nil, @"Feedback information is required to submit feedback.");
    
    if ([feedbackSubmission.username length] == 0) {
        completionHandler([self errorWithCode:WSAPICLientErrorCodeUsernameRequired reason:@"A username is required."]);
        return;
    }
    
    if ([feedbackSubmission.feedbackText length] == 0) {
        completionHandler([self errorWithCode:WSAPIClientErrorCodeFeedbackMessageEmpty reason:@"A message is required."]);
        return;
    }
    
    NSAssert(feedbackSubmission.feedbackDate != nil, @"A date is required to submit feedback.");
    
    NSString *feedbackValue;
    switch (feedbackSubmission.feedbackValue) {
        case WSFeedbackValuePositive:
            feedbackValue = @"Positive";
            break;
        case WSFeedbackValueNeutral:
            feedbackValue = @"Neutral";
            break;
        case WSFeedbackValueNegative:
            feedbackValue = @"Negative";
            break;
        default:
            NSLog(@"Unrecognized feedback type.");
            break;
    }
    
    NSString *userTypeValue;
    switch (feedbackSubmission.feedbackUserType) {
        case WSFeedbackUserTypeGuest:
            userTypeValue = @"Guest";
            break;
        case WSFeedbackUserTypeHost:
            userTypeValue = @"Host";
            break;
        case WSFeedbackUserTypeMetTraveling:
            userTypeValue = @"Met Traveling";
            break;
        case WSFeedbackUserTypeOther:
            userTypeValue = @"Other";
            break;
        default:
            userTypeValue = @"Other";
            break;
    }
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:feedbackSubmission.feedbackDate];
    
    NSArray *username = @[@{ @"uid": @{ @"uid": feedbackSubmission.username }}];
    NSArray *date = @[@{ @"value": @{ @"year": [NSString stringWithFormat:@"%i", dateComponents.year],
                                      @"month": [NSString stringWithFormat:@"%i", dateComponents.month] }}];
    
    NSDictionary *postParamters = @{ @"type": @"trust_referral",
                                     @"field_rating": @{ @"value": feedbackValue },
                                     @"body": feedbackSubmission.feedbackText,
                                     @"field_guest_or_host": @{ @"value": userTypeValue },
                                     @"field_member_i_trust": username,
                                     @"field_hosting_date": date };
    
    [self.client postPath:@"/services/rest/node" parameters:postParamters success:^(AFHTTPRequestOperation *operation, id responseObject) {
#ifdef DEBUG
        NSLog(@"Service response: %@", responseObject);
#endif
        completionHandler(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(error);
    }];
}

@end
