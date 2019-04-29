//
//  SRDetectorType.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRDetectorType.h"

NSTextCheckingType textCheckingType(SRDetectorType type) {
    switch (type) {
        case SRDetectorTypeAddress:
            return NSTextCheckingTypeAddress;
            break;
        case SRDetectorTypeDate:
            return NSTextCheckingTypeDate;
            break;
        case SRDetectorTypePhoneNumber:
            return NSTextCheckingTypePhoneNumber;
            break;
        case SRDetectorTypeUrl:
            return NSTextCheckingTypeLink;
            break;
        case SRDetectorTypeTransitInformation:
            return NSTextCheckingTypeTransitInformation;
            break;
        default:
            break;
    }
}

//@implementation SRDetectorType
//
//@end
