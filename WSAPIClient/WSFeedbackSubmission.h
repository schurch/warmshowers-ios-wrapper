//
//  WSFeedbackSubmission.h
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSFeedbackValue.h"
#import "WSFeedbackUserType.h"

@interface WSFeedbackSubmission : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *feedbackText;
@property (nonatomic, strong) NSDate *feedbackDate;

@property (nonatomic) WSFeedbackUserType feedbackUserType;
@property (nonatomic) WSFeedbackValue feedbackValue;

@end
