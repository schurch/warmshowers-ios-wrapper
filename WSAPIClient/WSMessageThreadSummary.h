//
//  WSMessage.h
//  WSAPIClient
//
//  Created by Stefan Church on 23/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMessageThreadSummary : NSObject

@property (nonatomic, strong) NSString *threadSubject;
@property (nonatomic, strong) NSArray *participants;
@property (nonatomic, strong) NSDate *lastUpdated;
@property (nonatomic, strong) NSDate *started;

@property (nonatomic) NSInteger messageCount;
@property (nonatomic, getter = isThreadNew) BOOL threadNew;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
