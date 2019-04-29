//
//  SRAvatarPosition.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum SRAvatarPositionHorizontal: NSUInteger {
    SRAvatarPositionHorizontalCellLeading,
    SRAvatarPositionHorizontalCellTrailing,
    SRAvatarPositionHorizontalNatural,
} SRAvatarPositionHorizontal;

typedef enum SRAvatarPositionVertical: NSUInteger {
    SRAvatarPositionHorizontalCellTop,
    SRAvatarPositionHorizontalMessageLabelTop,
    SRAvatarPositionHorizontalMessageTop,
    SRAvatarPositionHorizontalMessageCenter,
    SRAvatarPositionHorizontalMessageBottom,
    SRAvatarPositionHorizontalCellBottom,
} SRAvatarPositionVertical;

@interface SRAvatarPosition : NSObject

@property (nonatomic, assign) SRAvatarPositionVertical vertical;
@property (nonatomic, assign) SRAvatarPositionHorizontal horizontal;

- (instancetype)initWithHorizontal:(SRAvatarPositionHorizontal)horizontal vertical: (SRAvatarPositionVertical)vertical;
- (instancetype)initWithVertical:(SRAvatarPositionVertical)vertical;

- (BOOL)isEqual:(SRAvatarPosition *)object;

@end

NS_ASSUME_NONNULL_END
