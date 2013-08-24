//
//  WSMessage.h
//  WSAPIClient
//
//  Created by Stefan Church on 24/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WSMessageAuthor;

@interface WSMessage : NSObject

@property (nonatomic, strong) NSNumber *messageId;
@property (nonatomic, strong) NSNumber *messageThreadId;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) WSMessageAuthor *author;
@property (nonatomic, strong) NSDate *createdAt;

@property (nonatomic, getter = isNewMessage) BOOL newMessage;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
