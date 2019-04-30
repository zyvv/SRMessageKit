//
//  SRInputTextView.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRInputTextView.h"
#import "NSLayoutConstraintSet.h"

@interface SRInputTextView ()
@property (nonatomic, strong) NSLayoutConstraintSet *placeholderLabelConstraintSet;
@end

@implementation SRInputTextView
@synthesize placeholder = _placeholder;

- (void)setText:(NSString *)text {
    [super setText:text];
    
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
}

- (NSArray *)images {
    return @[];
}

- (NSArray *)components {
    return @[];
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.text = @"新信息";
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _placeholderLabel;
}

- (NSString *)placeholder {
    if (!_placeholder) {
        _placeholder = @"新消息";
    }
    return _placeholder;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = _placeholder;
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    _placeholderTextColor = placeholderTextColor;
    self.placeholderLabel.textColor = _placeholderTextColor;
}

- (void)setPlaceholderLabelInsets:(UIEdgeInsets)placeholderLabelInsets {
    _placeholderLabelInsets = placeholderLabelInsets;
    
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    self.placeholderLabel.textAlignment = textAlignment;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset{
    [super setTextContainerInset:textContainerInset];
    self.placeholderLabelInsets = textContainerInset;
}

- (void)setScrollIndicatorInsets:(UIEdgeInsets)scrollIndicatorInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(scrollIndicatorInsets, UIEdgeInsetsZero)) {
        [super setScrollIndicatorInsets:UIEdgeInsetsMake(CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN)];
    } else {
        [super setScrollIndicatorInsets:scrollIndicatorInsets];
    }
}

#pragma mark - Initializers
+ (instancetype)inputTextView {
    SRInputTextView *inputTextView = [[SRInputTextView alloc] initWithFrame:CGRectZero];
    return inputTextView;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setup
- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.scrollEnabled = NO;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN, CGFLOAT_MIN);
    [self setupPlaceholderLabel];
    [self setupObservers];
}

- (void)setupPlaceholderLabel {
    [self addSubview:self.placeholderLabel];
    
    NSLayoutConstraint *top = [self.placeholderLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.placeholderLabelInsets.top];
    NSLayoutConstraint *bottom = [self.placeholderLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-self.placeholderLabelInsets.bottom];
    NSLayoutConstraint *left = [self.placeholderLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.placeholderLabelInsets.left];
    NSLayoutConstraint *right = [self.placeholderLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-self.placeholderLabelInsets.right];
    NSLayoutConstraint *centerX = [self.placeholderLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor];
    NSLayoutConstraint *centerY = [self.placeholderLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
    self.placeholderLabelConstraintSet = [[NSLayoutConstraintSet alloc] initWithTop:top bottom:bottom left:left right:right centerX:centerX centerY:centerY width:nil height:nil];
    self.placeholderLabelConstraintSet.sr_centerX.priority = UILayoutPriorityDefaultLow;
    self.placeholderLabelConstraintSet.sr_centerY.priority = UILayoutPriorityDefaultLow;
    [self.placeholderLabelConstraintSet acctivate];
}

- (void)setupObservers {
    
}

- (void)updateConstraintsForPlaceholderLabel {
    self.placeholderLabelConstraintSet.sr_top.constant = self.placeholderLabelInsets.top;
    self.placeholderLabelConstraintSet.sr_bottom.constant = -self.placeholderLabelInsets.bottom;
    self.placeholderLabelConstraintSet.sr_left.constant = self.placeholderLabelInsets.left;
    self.placeholderLabelConstraintSet.sr_right.constant = -self.placeholderLabelInsets.right;
}

#pragma mark - Notification
- (void)postTextViewDidChangeNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:self];
}

- (void)textViewTextDidChange {
    self.placeholderLabel.hidden = self.text.length == 0 ? NO : YES;
}

#pragma mark - Image Paste Support
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:) && [UIPasteboard generalPasteboard].image != nil) {
        return self.isImagePasteEnabled;
    }
    return [super canPerformAction:action withSender:sender];
}

- (void)paste:(id)sender {
    UIImage *image = [UIPasteboard generalPasteboard].image;
    if (!image) {
        return [super paste:sender];
    }
    if (self.isImagePasteEnabled) {
        [self pasteImageInTextContainerWithImage:image];
    } else {
        
    }
}

- (void)pasteImageInTextContainerWithImage:(UIImage *)image {
    NSAttributedString *attributedImageString = [NSAttributedString attributedStringWithAttachment:<#(nonnull NSTextAttachment *)#>]
}

@end
