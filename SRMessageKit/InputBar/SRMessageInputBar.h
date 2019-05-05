//
//  SRMessageInputBar.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRInputStackView.h"
#import "SRInputTextView.h"
#import "SRInputBarButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SRInputPluginDelegate <NSObject>

- (void)reloadData;

- (void)invalidate;

- (BOOL)handleInputOfObject:(id)object;

@end

@class SRMessageInputBar;
@protocol SRMessageInputBarDelegate <NSObject>
@optional
- (void)messageInputBar:(SRMessageInputBar *)inputBar didPressSendButtonWithText:(NSString *)text;

- (void)messageInputBar:(SRMessageInputBar *)inputBar didChangeIntrinsicContentToSize:(CGSize )size;

- (void)messageInputBar:(SRMessageInputBar *)inputBar textViewTextDidChangeTo:(NSString *)text;

@end

@interface SRMessageInputBar : UIView

@property (nonatomic, weak) id<SRMessageInputBarDelegate> delegate;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong, readonly) UIView *contentView;

@property (nonatomic, strong) UIVisualEffectView *blurView;

@property (nonatomic, assign) BOOL translucent;

@property (nonatomic, strong) UIView *separatorLine;

@property (nonatomic, strong) SRInputStackView *topStackView;

@property (nonatomic, strong) SRInputStackView *leftStackView;

@property (nonatomic, strong) SRInputStackView *rightStackView;

@property (nonatomic, strong) SRInputStackView *bottomStackView;

@property (nonatomic, strong) SRInputTextView *inputTextView;

@property (nonatomic, strong) SRInputBarButtonItem *sendButton;

@property (nonatomic, assign) UIEdgeInsets padding;

@property (nonatomic, assign) UIEdgeInsets topStackViewPadding;

@property (nonatomic, assign) UIEdgeInsets textViewPadding;

@property (nonatomic, assign, readonly) CGSize previousIntrinsicContentSize;

@property (nonatomic, assign, readonly) BOOL isOverMaxTextViewHeight;

@property (nonatomic, assign, readonly) BOOL shouldForceTextViewMaxHeight;

@property (nonatomic, assign) BOOL shouldAutoUpdateMaxTextViewHeight;

@property (nonatomic, assign) CGFloat maxTextViewHeight;

@property (nonatomic, assign) BOOL shouldManageSendButtonEnabledState;

@property (nonatomic, assign) CGFloat requiredInputTextViewHeight;

@property (nonatomic, assign, readonly) CGFloat leftStackViewWidthConstant;

@property (nonatomic, assign, readonly) CGFloat rightStackViewWidthConstant;

@property (nonatomic, strong) NSArray *plugins;

@property (nonatomic, strong, readonly) NSArray *leftStackViewItems;

@property (nonatomic, strong, readonly) NSArray *rightStackViewItems;

@property (nonatomic, strong, readonly) NSArray *bottomStackViewItems;

@property (nonatomic, strong, readonly) NSArray *topStackViewItems;

@property (nonatomic, strong) NSArray *nonStackViewItems;

@property (nonatomic, strong) NSArray *items;

+ (instancetype)messageInputBar;

- (void)performLayoutAnimated:(BOOL)animated animations:(void(^)(void))animations;

- (void)layoutStackViewsWithPositions:(NSArray *)positions;

@end

NS_ASSUME_NONNULL_END
