//
//  SRInputItem.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/5/5.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRInputStackView.h"

NS_ASSUME_NONNULL_BEGIN

@class SRInputTextView;
@class SRMessageInputBar;
@interface SRInputItem : UIButton

@property (nonatomic, weak) SRMessageInputBar *messageInputBar;

@property (nonatomic, assign) SRInputStackViewPosition parentStackViewPosition;

- (void)textViewDidChangeAction:(SRInputTextView *)textView;

- (void)keyboardEditingEndsAction;

- (void)keyboardEditingBeginsAction;

@end

NS_ASSUME_NONNULL_END
