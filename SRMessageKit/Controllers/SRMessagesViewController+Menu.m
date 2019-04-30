//
//  SRMessagesViewController+Menu.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesViewController+Menu.h"
#import "SRMessageContentCell.h"

@implementation SRMessagesViewController (Menu)

// MARK: - Register / Unregister Observers

- (void)addMenuControllerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillShow:) name:UIMenuControllerWillShowMenuNotification object:nil];
}

- (void)removeMenuControllerObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
}

// MARK: - Notification Handlers
- (void)menuControllerWillShow:(NSNotification *)notification {
    if (!notification.object || ![notification.object isKindOfClass:[UIMenuController class]]) {
        return;
    }
    UIMenuController *currentMenuController = (UIMenuController *)notification.object;
    if (!self.selectedIndexPathForMenu) {
        return;
    }
    NSIndexPath *selectedIndexPath = self.selectedIndexPathForMenu;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
    
    [currentMenuController setMenuVisible:NO animated:NO];
    
    SRMessageContentCell *selectedCell = (SRMessageContentCell *)[self.messagesCollectionView cellForItemAtIndexPath:selectedIndexPath];
    if (!selectedCell) {
        return;
    }
    CGRect selectedCellMessageBubbleFrame = [selectedCell convertRect:selectedCell.messageContainerView.frame toView:self.view];
    
    CGRect messageInputBarFrame = CGRectZero;
    UIView *messageInputBarSuperview = self.messageInputBar.superview;
    messageInputBarFrame = [self.view convertRect:self.messageInputBar.frame toView:messageInputBarSuperview];
    
    CGRect topNavigationBarFrame = [self navigationBarFrame];
    if (topNavigationBarFrame.origin.x != 0 && topNavigationBarFrame.origin.y != 0 && topNavigationBarFrame.size.width != 0 && topNavigationBarFrame.size.height != 0) {
        UIView *navigationBarSuperView = self.navigationController.navigationBar.superview;
        if (navigationBarSuperView) {
            topNavigationBarFrame = [self.view convertRect:self.navigationController.navigationBar.frame fromView:navigationBarSuperView];
        }
    }
    
    CGFloat menuHeight = currentMenuController.menuFrame.size.height;
    
    CGRect selectedCellMessageBubblePlusMenuFrame = CGRectMake(selectedCellMessageBubbleFrame.origin.x, selectedCellMessageBubbleFrame.origin.y - menuHeight, selectedCellMessageBubbleFrame.size.width, selectedCellMessageBubbleFrame.size.height + 2 * menuHeight);
    
    CGRect targetRect = selectedCellMessageBubbleFrame;
    currentMenuController.arrowDirection = UIMenuControllerArrowDefault;
    
    if (CGRectIntersectsRect(selectedCellMessageBubblePlusMenuFrame, topNavigationBarFrame) && CGRectIntersectsRect(selectedCellMessageBubblePlusMenuFrame, messageInputBarFrame)) {
        CGFloat centerY = (CGRectGetMinY( CGRectIntersection(selectedCellMessageBubblePlusMenuFrame, messageInputBarFrame)) + CGRectGetMaxY(CGRectIntersection(selectedCellMessageBubblePlusMenuFrame, topNavigationBarFrame))) / 2.0;
        targetRect = CGRectMake(CGRectGetMidX(selectedCellMessageBubblePlusMenuFrame), centerY, 1, 1);
    } else if (CGRectIntersectsRect(selectedCellMessageBubblePlusMenuFrame, topNavigationBarFrame)) {
        currentMenuController.arrowDirection = UIMenuControllerArrowUp;
    }
    
    [currentMenuController setTargetRect:targetRect inView:self.view];
    [currentMenuController setMenuVisible:YES animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillShow:) name:UIMenuControllerWillShowMenuNotification object:nil];
    self.selectedIndexPathForMenu = nil;
    
}

// MARK: - Helpers
- (CGRect)navigationBarFrame {
    if (self.navigationController && !self.navigationController.navigationBar.isHidden) {
        return  self.navigationController.navigationBar.frame;
    }
    return CGRectZero;
}

@end
