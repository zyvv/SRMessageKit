//
//  SRInputTextView.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SRMessageInputBar;
@interface SRInputTextView : UITextView

@property (nonatomic, copy) NSArray *images;

@property (nonatomic, copy) NSArray *components;

@property (nonatomic, assign) BOOL isImagePasteEnabled;

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) UIColor *placeholderTextColor;

@property (nonatomic, assign) UIEdgeInsets placeholderLabelInsets;

@property (nonatomic, weak) SRMessageInputBar *messageInputBar;

+ (instancetype)inputTextView;

@end

NS_ASSUME_NONNULL_END
