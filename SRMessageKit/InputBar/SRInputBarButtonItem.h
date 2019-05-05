//
//  SRInputBarButtonItem.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRInputStackView.h"
#import "SRInputItem.h"

NS_ASSUME_NONNULL_BEGIN

@class SRMessageInputBar;
@class SRInputBarButtonItem;
typedef void(^SRInputBarButtonItemAction)(SRInputBarButtonItem *);

typedef enum SRSpacing: NSUInteger {
    SRSpacingNone,
    SRSpacingFixed,
    SRSpacingFlexible,
} SRSpacing;

@interface SRInputBarButtonItem : SRInputItem

@property (nonatomic, assign) CGSize size;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) SRSpacing spacing;
@property (nonatomic, assign) CGFloat spacingWidth;

+ (instancetype)inputBarButtonItem;

- (SRInputBarButtonItem *)configure:(SRInputBarButtonItemAction)item;

- (void)setSize:(CGSize)size animated:(BOOL)animated;

- (SRInputBarButtonItem *)onTouchUpInside:(SRInputBarButtonItemAction)action;

@end

NS_ASSUME_NONNULL_END
