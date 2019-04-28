//
//  SRMessageKitDateFormatter.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageKitDateFormatter.h"

@implementation SRMessageKitDateFormatter

+ (instancetype)shareMessageKitDateFormatter {
    static SRMessageKitDateFormatter *shareMessageKitDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareMessageKitDateFormatter = [[SRMessageKitDateFormatter alloc] init];
        shareMessageKitDateFormatter.formatter = [[NSDateFormatter alloc] init];
    });
    return shareMessageKitDateFormatter;
}

- (NSString *)stringFromDate:(NSDate *)date {
    [self configureDateFormatterForDate:date];
    return [self.formatter stringFromDate:date];
}

- (NSAttributedString *)attributedStringFromDate:(NSDate *)date withAttributes:(NSArray *)attributes {
    NSString *dateString = [self stringFromDate:date];
    return [[NSAttributedString alloc] initWithString:dateString attributes:attributes];
}

- (void)configureDateFormatterForDate:(NSDate *)date {
    if ([[NSCalendar currentCalendar] isDateInToday:date] || [[NSCalendar currentCalendar] isDateInYesterday:date]) {
        self.formatter.doesRelativeDateFormatting = YES;
        self.formatter.dateStyle = NSDateIntervalFormatterShortStyle;
        self.formatter.timeStyle =NSDateFormatterShortStyle;
    } else if ([[NSCalendar currentCalendar] isDate:date equalToDate:[NSDate date] toUnitGranularity:NSCalendarUnitWeekOfYear]) {
        self.formatter.dateFormat = @"EEEE h:mm a";
    } else if ([[NSCalendar currentCalendar] isDate:date equalToDate:[NSDate date] toUnitGranularity:NSCalendarUnitYear]) {
        self.formatter.dateFormat = @"E, d MMM, h:mm a";
    } else {
        self.formatter.dateFormat = @"MMM d, yyyy, h:mm a";
    }
}

@end
