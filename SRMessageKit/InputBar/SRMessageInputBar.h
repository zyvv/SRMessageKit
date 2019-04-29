//
//  SRMessageInputBar.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SRMessageInputBar;
@protocol SRMessageInputBarDelegate <NSObject>

- (void)messageInputBar:(SRMessageInputBar *)inputBar didPressSendButtonWithText:(NSString *)text;

- (void)messageInputBar:(SRMessageInputBar *)inputBar didChangeIntrinsicContentToSize:(CGSize )size;

- (void)messageInputBar:(SRMessageInputBar *)inputBar textViewTextDidChangeTo:(NSString *)text;

@end

@interface SRMessageInputBar : UIView

@property (nonatomic, weak) id<SRMessageInputBarDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
