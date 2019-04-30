//
//  SRMessagesViewController+Menu.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRMessagesViewController (Menu)

// MARK: - Register / Unregister Observers

- (void)addMenuControllerObservers;

- (void)removeMenuControllerObservers;

// MARK: - Notification Handlers
- (void)menuControllerWillShow:(NSNotification *)notification;


@end

NS_ASSUME_NONNULL_END
