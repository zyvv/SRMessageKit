//
//  SRMessageStyle.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum SRTailCorner: NSUInteger {
    SRTailCornerTopLeft,
    SRTailCornerBottomLeft,
    SRTailCornerTopRigth,
    SRTailCornerBottomRight,
} SRTailCorner;

NSString * tailCornerRawValue(SRTailCorner corner);

UIImageOrientation imageOrientation(SRTailCorner corner);

typedef enum SRTailStyle: NSUInteger {
    SRTailStyleCurved,
    SRTailStylePointedEdge,
} SRTailStyle;

NSString * imageNameSuffix(SRTailStyle style);

typedef enum SRMessagesStyle: NSUInteger {
    SRMessagesStyleNone,
    SRMessagesStyleBubble,
    SRMessagesStyleBubbleOutline,
    SRMessagesStyleBubbleTail,
    SRMessagesStyleBubbleTailOutline,
    SRMessagesStyleCustom,
} SRMessagesStyle;

@class SRMessageContainerView;
@interface SRMessageStyle : NSObject

@property (nonatomic, assign) SRMessagesStyle style;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIColor *bubbleOutlineColor;

@property (nonatomic, assign) SRTailCorner bubbleTailCorner;
@property (nonatomic, assign) SRTailStyle bubbleTailStyle;

@property (nonatomic, strong) UIColor *bubbleTailOutlineColor;
@property (nonatomic, assign) SRTailCorner bubbleTailOutlineCorner;
@property (nonatomic, assign) SRTailStyle bubbleTailOutlineStyle;
@property (nonatomic, copy) void(^custom) (SRMessageContainerView *messageContainerView);

- (instancetype)initWithStyle:(SRMessagesStyle)style;

@end

NS_ASSUME_NONNULL_END
