//
//  SRLocationItem.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRLocationItem : NSObject

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, assign) CGSize size;
@end

NS_ASSUME_NONNULL_END
