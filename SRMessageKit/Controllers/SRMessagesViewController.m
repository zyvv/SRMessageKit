//
//  SRMessagesViewController.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesViewController.h"

@interface SRMessagesViewController ()

@end

@implementation SRMessagesViewController

- (SRMessagesCollectionView *)messagesCollectionView {
    if (!_messagesCollectionView) {
        _messagesCollectionView = [[SRMessagesCollectionView alloc] init];
    }
    return _messagesCollectionView;
}

- (SRMessageInputBar *)messageInputBar {
    if (!_messageInputBar) {
        _messageInputBar = [[SRMessageInputBar alloc] init];
    }
    return _messageInputBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (UIView *)inputAccessoryView {
    return self.messageInputBar;
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
