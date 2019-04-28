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

NSString * tailCornerRawValue(SRTailCorner corner) {
    switch (corner) {
        case SRTailCornerBottomRight:
            return @"bottomRight";
            break;
        case SRTailCornerBottomLeft:
            return @"bottomLeft";
            break;
        case SRTailCornerTopLeft:
            return @"topLeft";
            break;
        case SRTailCornerTopRigth:
            return @"topRight";
            break;
    }
}

UIImageOrientation imageOrientation(SRTailCorner corner) {
    switch (corner) {
        case SRTailCornerBottomRight:
            return UIImageOrientationUp;
            break;
        case SRTailCornerBottomLeft:
            return UIImageOrientationUpMirrored;
            break;
        case SRTailCornerTopLeft:
            return UIImageOrientationDown;
            break;
        case SRTailCornerTopRigth:
            return UIImageOrientationDownMirrored;
            break;
    }
}

typedef enum SRTailStyle: NSUInteger {
    SRTailStyleCurved,
    SRTailStylePointedEdge,
} SRTailStyle;

NSString * imageNameSuffix(SRTailStyle style) {
    switch (style) {
        case SRTailStyleCurved:
            return @"_tail_v2";
            break;
        case SRTailStylePointedEdge:
            return @"_tail_v1";
            break;
    }
}

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
