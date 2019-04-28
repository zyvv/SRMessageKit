//
//  SRMessageLabel.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SRMessageLabel;
@protocol SRMessageLabelDelegate <NSObject>

- (void)didSelectAddress:(NSDictionary *)addressComponents;

- (void)didSelectDate:(NSDate *)date;

- (void)didSelectPhoneNumber:(NSString *)phoneNumber;

- (void)didSelectURL:(NSURL *)url;

- (void)didSelectTransitInformation:(NSDictionary *)transitInformation;

@end

@interface SRMessageLabel : UILabel

@property (nonatomic, weak) id<SRMessageLabelDelegate>delegate;

@property (nonatomic, copy) NSArray *enabledDetectors;

@property (nonatomic, assign) UIEdgeInsets textInsets;

+ (NSDictionary *)defaultAttributes;


@end

NS_ASSUME_NONNULL_END
