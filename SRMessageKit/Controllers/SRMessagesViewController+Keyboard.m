//
//  SRMessagesViewController+Keyboard.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesViewController+Keyboard.h"

@implementation SRMessagesViewController (Keyboard)

// MARK: - Register / Unregister Observers
- (void)addKeyboardObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidChangeState:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustScrollViewTopInset) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)removeKeyboardObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

// MARK: - Notification Handlers
- (void)handleTextViewDidBeginEditing:(NSNotification *)notification {
    if (self.scrollsToBottomOnKeyboardBeginsEditing) {
        
        [self.messagesCollectionView scrollToBottom:YES];
    }
}

- (void)handleKeyboardDidChangeState:(NSNotification *)notification {
    if (self.isMessagesControllerBeingDismissed) {
        return;
    }
   NSValue *keyboardStartFrameInScreenCoordsValue =  notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    if (!keyboardStartFrameInScreenCoordsValue) {
        return;
    }
    CGRect keyboardStartFrameInScreenCoords = keyboardStartFrameInScreenCoordsValue.CGRectValue;
    if (CGRectIsEmpty(keyboardStartFrameInScreenCoords)) {
        return;
    }
    NSValue *keyboardEndFrameInScreenCoordsValue =  notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    if (!keyboardEndFrameInScreenCoordsValue) {
        return;
    }
    CGRect keyboardEndFrameInScreenCoords = keyboardEndFrameInScreenCoordsValue.CGRectValue;
    
    CGRect keyboardEndFrame = [self.view convertRect:keyboardEndFrameInScreenCoords fromView:self.view.window];
    CGFloat newBottomInset = [self requiredScrollViewBottomInsetForKeyboardFrame:keyboardEndFrame];
    CGFloat differenceOfBottomInset = newBottomInset - self.messageCollectionViewBottomInset;
    
    if (self.maintainPositionOnKeyboardFrameChanged && differenceOfBottomInset != 0) {
        CGPoint contentOffset = CGPointMake(self.messagesCollectionView.contentOffset.x, self.messagesCollectionView.contentOffset.y + differenceOfBottomInset);
        [self.messagesCollectionView setContentOffset:contentOffset animated:NO];
    }
    self.messageCollectionViewBottomInset = newBottomInset;
}

// MARK: - Inset Computation
- (void)adjustScrollViewTopInset {
    if (@available(iOS 11.0, *)) {
    } else {
        CGFloat navigationBarInset = self.navigationController.navigationBar.frame.size.height;
        CGFloat statusBarInset = [UIApplication sharedApplication].isStatusBarHidden ? 0 : 20;
        CGFloat topInset = navigationBarInset + statusBarInset;
        self.messagesCollectionView.contentInset = UIEdgeInsetsMake(topInset, self.messagesCollectionView.contentInset.left, self.messagesCollectionView.contentInset.bottom, self.messagesCollectionView.contentInset.right);
        self.messagesCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(topInset, self.messagesCollectionView.scrollIndicatorInsets.left, self.messagesCollectionView.scrollIndicatorInsets.bottom, self.messagesCollectionView.scrollIndicatorInsets.right);
    }
}

- (CGFloat)requiredScrollViewBottomInsetForKeyboardFrame:(CGRect)keyboardFrame {
    CGRect intersection = CGRectIntersection(self.messagesCollectionView.frame, keyboardFrame);
    if (CGRectIsNull(intersection) || CGRectGetMaxY(intersection) < CGRectGetMaxY(self.messagesCollectionView.frame)) {
        return MAX(0, self.additionalBottomInset - [self automaticallyAddedBottomInset]);
    } else {
        return MAX(0, CGRectGetHeight(intersection) + self.additionalBottomInset - [self automaticallyAddedBottomInset]);
    }
}

- (CGFloat)requiredInitialScrollViewBottomInset {
    if (self.inputAccessoryView) {
        return MAX(0, CGRectGetHeight(self.inputAccessoryView.frame) + self.additionalBottomInset - self.automaticallyAddedBottomInset);
    }
    return 0;
}

- (CGFloat)automaticallyAddedBottomInset {
    if (@available(iOS 11.0, *)) {
        return self.messagesCollectionView.adjustedContentInset.bottom - self.messagesCollectionView.contentInset.bottom;
    } else {
        return 0;
    }
}

@end
