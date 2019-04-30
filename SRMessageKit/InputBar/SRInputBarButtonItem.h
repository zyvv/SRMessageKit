//
//  SRInputBarButtonItem.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRInputStackView.h"

NS_ASSUME_NONNULL_BEGIN

@class SRMessageInputBar;
@class SRInputBarButtonItem;
typedef void(^SRInputBarButtonItemAction)(SRInputBarButtonItem *);

//@protocol SRInputItemDelegate <NSObject>
//
//
//
//@end

typedef enum SRSpacing: NSUInteger {
    SRSpacingNone,
    SRSpacingFixed,
    SRSpacingFlexible,
} SRSpacing;

@interface SRInputBarButtonItem : UIButton

@property (nonatomic, weak) SRMessageInputBar *messageInputBar;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) SRInputStackViewPosition parentStackViewPosition;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) SRSpacing spacing;
@property (nonatomic, assign) CGFloat spacingWidth;

+ (instancetype)inputBarButtonItem;

@end

NS_ASSUME_NONNULL_END
