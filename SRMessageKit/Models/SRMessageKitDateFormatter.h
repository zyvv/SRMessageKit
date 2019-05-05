//
//  SRMessageKitDateFormatter.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRMessageKitDateFormatter : NSObject

@property (nonatomic, strong) NSDateFormatter *formatter;

+ (instancetype)shareMessageKitDateFormatter;

- (NSString *)stringFromDate:(NSDate *)date;

- (NSAttributedString *)attributedStringFromDate:(NSDate *)date withAttributes:(NSDictionary *)attributes;

- (void)configureDateFormatterForDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
