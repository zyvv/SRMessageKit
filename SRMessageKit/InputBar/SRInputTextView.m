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
@synthesize placeholderLabelInsets = _placeholderLabelInsets;

- (void)setText:(NSString *)text {
    [super setText:text];
    [self postTextViewDidChangeNotification];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self postTextViewDidChangeNotification];
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

- (UIEdgeInsets)placeholderLabelInsets {
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, _placeholderLabelInsets)) {
        return UIEdgeInsetsMake(8, 4, 8, 4);
    }
    return _placeholderLabelInsets;
}

- (void)setPlaceholderLabelInsets:(UIEdgeInsets)placeholderLabelInsets {
    _placeholderLabelInsets = placeholderLabelInsets;
    [self updateConstraintsForPlaceholderLabel];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redrawTextAttachments) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidChangeNotification object:nil];
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
    NSAttributedString *attributedImageString = [NSAttributedString attributedStringWithAttachment:[self textAttachmentUsingImage:image]];
    BOOL isEmpty = self.attributedText.length == 0;
    NSMutableAttributedString *newAttributedStingComponent = isEmpty ? [[NSMutableAttributedString alloc] initWithString:@""] : [[NSMutableAttributedString alloc] initWithString:@"\n"];
    [newAttributedStingComponent appendAttributedString:attributedImageString];
    
    [newAttributedStingComponent appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                 NSForegroundColorAttributeName: [UIColor blackColor]
                                 };
    [newAttributedStingComponent addAttributes:attributes range:NSMakeRange(0, newAttributedStingComponent.length)];
    [self.textStorage beginEditing];
    [self.textStorage replaceCharactersInRange:self.selectedRange withAttributedString:newAttributedStingComponent];
    [self.textStorage endEditing];
    
    CGFloat location = self.selectedRange.location + (isEmpty ? 2 : 3);
    self.selectedRange = NSMakeRange(location, 0);
    [self postTextViewDidChangeNotification];
}

- (NSTextAttachment *)textAttachmentUsingImage:(UIImage *)image {
    CGImageRef cgImage = image.CGImage;
    if (!cgImage) {
        return [NSTextAttachment new];
    }
    CGFloat scale = image.size.width / (CGRectGetWidth(self.frame) - 2 * (self.textContainerInset.left + self.textContainerInset.right));
    NSTextAttachment *textAttachment = [NSTextAttachment new];
    textAttachment.image = [UIImage imageWithCGImage:cgImage scale:scale orientation:UIImageOrientationUp];
    return textAttachment;
}

- (NSArray *)parseForAttachedImages {
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    NSRange range = NSMakeRange(0, self.attributedText.length);
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:range options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSTextAttachment class]]) {
            NSTextAttachment *attachment = (NSTextAttachment *)value;
            if (attachment.image) {
                [images addObject:attachment.image];
            } else {
                UIImage *image = [attachment imageForBounds:attachment.bounds textContainer:nil characterIndex:range.location];
                if (image) {
                    [images addObject:image];
                }
            }
        }
    }];
    return images;
}

- (NSArray *)parseForComonests {
    NSMutableArray *components = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *attachments = [NSMutableArray arrayWithCapacity:0];
    NSInteger length = self.attributedText.length;
    NSRange range = NSMakeRange(0, length);
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:range options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSTextAttachment class]]) {
            NSTextAttachment *attachment = (NSTextAttachment *)value;
            if (attachment.image) {
                NSDictionary *item = @{@"range": [NSValue valueWithRange:range], @"image":attachment.image};
                [attachments addObject:item];
            } else {
                UIImage *image = [attachment imageForBounds:attachment.bounds textContainer:nil characterIndex:range.location];
                if (image) {
                    [attachments addObject:@{@"range": [NSValue valueWithRange:range], @"image":attachment.image}];
                }
            }
            
        }
    }];
    CGFloat curLocation = 0;
    if (attachments.count == 0) {
        NSString *text = [self.attributedText.string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (text.length > 0) {
            [components addObject:text];
        }
    } else {
        for (NSDictionary *attachment in attachments) {
            NSValue *rangeValue = attachment[@"range"];
            UIImage *image = attachment[@"image"];
            if (curLocation < rangeValue.rangeValue.location) {
                NSRange textRange = NSMakeRange(curLocation, rangeValue.rangeValue.location);
                NSString *text = [[self.attributedText attributedSubstringFromRange:textRange].string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                if (text.length > 0) {
                    [components addObject:text];
                }
            }
            curLocation = rangeValue.rangeValue.location + rangeValue.rangeValue.length;
            [components addObject:image];
        }
        if (curLocation < length - 1) {
            NSString *text = [[self.attributedText attributedSubstringFromRange:NSMakeRange(curLocation, length - curLocation)].string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (text.length > 0) {
                [components addObject:text];
            }
        }
    }
    return components;
}

- (void)redrawTextAttachments {
    if (self.images.count <= 0) {
        return;
    }
    NSRange range = NSMakeRange(0, self.attributedText.length);
    [self.attributedText enumerateAttribute:NSAttachmentAttributeName inRange:range options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSTextAttachment class]]) {
            NSTextAttachment *attachment = (NSTextAttachment *)value;
            if (!attachment.image) {
                return;
            }
            CGFloat newWidth = CGRectGetWidth(self.frame) - 2 * (self.textContainerInset.left + self.textContainerInset.right);
            CGFloat ratio = attachment.image.size.height / attachment.image.size.width;
            attachment.bounds = CGRectMake(0, 0, newWidth, ratio * newWidth);
        }
    }];
    [self.layoutManager invalidateLayoutForCharacterRange:range actualCharacterRange:nil];
}


@end
