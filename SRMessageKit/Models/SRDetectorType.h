//
//  SRDetectorType.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum SRDetectorType: NSUInteger {
    DetectorTypeAddress,
    DetectorTypeDate,
    DetectorTypePhoneNumber,
    DetectorTypeUrl,
    DetectorTypeTransitInformation,
} SRDetectorType;

NSTextCheckingType textCheckingType(SRDetectorType type) {
    switch (type) {
        case DetectorTypeAddress:
            return NSTextCheckingTypeAddress;
            break;
        case DetectorTypeDate:
            return NSTextCheckingTypeDate;
            break;
        case DetectorTypePhoneNumber:
            return NSTextCheckingTypePhoneNumber;
            break;
        case DetectorTypeUrl:
            return NSTextCheckingTypeLink;
            break;
        case DetectorTypeTransitInformation:
            return NSTextCheckingTypeTransitInformation;
            break;
        default:
            break;
    }
}

//@interface SRDetectorType : NSObject
//
//@end

NS_ASSUME_NONNULL_END
