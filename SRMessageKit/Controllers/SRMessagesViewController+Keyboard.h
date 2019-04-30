//
//  SRMessagesViewController+Keyboard.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRMessagesViewController (Keyboard)

- (void)addKeyboardObservers;

- (void)removeKeyboardObservers;

- (CGFloat)requiredInitialScrollViewBottomInset;

@end

NS_ASSUME_NONNULL_END
