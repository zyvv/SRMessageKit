//
//  SRMessagesViewController.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRMessagesCollectionView.h"
#import "SRMessageInputBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRMessagesViewController : UIViewController

@property (nonatomic, strong) SRMessagesCollectionView *messagesCollectionView;

@property (nonatomic, strong) SRMessageInputBar *messageInputBar;

@property (nonatomic, assign) BOOL scrollsToBottomOnKeyboardBeginsEditing;

@property (nonatomic, assign) BOOL maintainPositionOnKeyboardFrameChanged;

@property (nonatomic, assign) CGFloat additionalBottomInset;

@property (nonatomic, assign) CGFloat messageCollectionViewBottomInset;

@property (nonatomic, strong) NSIndexPath *_Nullable selectedIndexPathForMenu;

@property (nonatomic, assign) BOOL isMessagesControllerBeingDismissed;


@end

NS_ASSUME_NONNULL_END
