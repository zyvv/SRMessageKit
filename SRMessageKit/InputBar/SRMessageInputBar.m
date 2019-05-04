//
//  SRMessageInputBar.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageInputBar.h"

@implementation SRMessageInputBar

#pragma mark - Initialization
- (instancetype)messageInputBar {
    SRMessageInputBar *messageInputBar = [[SRMessageInputBar alloc] initWithFrame:CGRectZero];
    return messageInputBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Setup
- (void)setup {
    
}

- (void)setupObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(;) name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - Auto-Layout Constraint Sets

#pragma mark - Notifications/Hooks
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass || self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass) {
        if (self.shouldAutoUpdateMaxTextViewHeight) {
            self.maxTextViewHeight = self ca
        } else {
            [self invalidateIntrinsicContentSize];
        }
    }
}

- (void)orientationDidChange {
    if (self.shouldAutoUpdateMaxTextViewHeight) {
        self.maxTextViewHeight =
    }
    [self invalidateIntrinsicContentSize];
}

- (void)inputTextViewDidChange {
    NSString *trimmedText = [self.inputTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (self.shouldManageSendButtonEnabledState) {
        BOOL isEnabled = trimmedText.length > 0;
        if (!isEnabled) {
            isEnabled = self.inputTextView.images.count > 0;
        }
        self.sendButton.enabled = isEnabled;
    }
    
    BOOL shouldInvalidateIntrinsicContentSize = self.requiredInputTextViewHeight != self.inputTextView.bounds.size.height;
    
//    for (srinputitem in self.items) {
//        <#statements#>
//    }
}


@end
