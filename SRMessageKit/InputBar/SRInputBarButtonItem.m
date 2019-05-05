//
//  SRInputBarButtonItem.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRInputBarButtonItem.h"
#import "SRMessageInputBar.h"

@interface SRInputBarButtonItem ()

@property (nonatomic, copy) SRInputBarButtonItemAction onTouchUpInsideAction;
@property (nonatomic, copy) SRInputBarButtonItemAction onKeyboardEditingBeginsAction;
@property (nonatomic, copy) SRInputBarButtonItemAction onKeyboardEditingEndsAction;
@property (nonatomic, copy) void (^onTextViewDidChangeAction)(SRInputBarButtonItem *item, UITextView *inputTextView);
@property (nonatomic, copy) SRInputBarButtonItemAction onSelectedAction;
@property (nonatomic, copy) SRInputBarButtonItemAction onDeselectedAction;
@property (nonatomic, copy) SRInputBarButtonItemAction onEnabledAction;
@property (nonatomic, copy) SRInputBarButtonItemAction onDisabledAction;

@end

@implementation SRInputBarButtonItem

@synthesize image = _image;
@synthesize title = _title;
@synthesize size = _size;

- (void)setSpacing:(SRSpacing)spacing {
    _spacing = spacing;
    switch (_spacing) {
        case SRSpacingFlexible:
            [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
            break;
        case SRSpacingFixed:
            [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            break;
        case SRSpacingNone:
            [self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
            break;
    }
}

- (CGSize)size {
    if (CGSizeEqualToSize(_size, CGSizeZero)) {
        _size = CGSizeMake(20, 20);
    }
    return _size;
}

- (void)setSize:(CGSize)size {
    _size = size;
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    CGSize contentSize = self.size;
    if (CGSizeEqualToSize(contentSize, CGSizeZero)) {
        contentSize = [super intrinsicContentSize];
    }
    switch (self.spacing) {
        case SRSpacingFixed:
            contentSize.width += self.spacingWidth;
            break;
        default:
            break;
    }
    return contentSize;
}

- (NSString *)title {
    return [self titleForState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (UIImage *)image {
    return [self imageForState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (self.isHighlighted) {
        self.onSelectedAction(self);
    } else {
        self.onDeselectedAction(self);
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (self.isEnabled) {
        if (self.onEnabledAction) {
            self.onEnabledAction(self);
        }
    } else {
        if (self.onDisabledAction) {
            self.onDisabledAction(self);
        }
    }
}


#pragma mark - Initialization
+ (instancetype)inputBarButtonItem {
    SRInputBarButtonItem *inputButtonItem = [[SRInputBarButtonItem alloc] initWithFrame:CGRectZero];
    return inputButtonItem;
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
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:0.3] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    self.adjustsImageWhenHighlighted = NO;
    [self addTarget:self action:@selector(touchUpInsideAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Size Adjustment
- (void)setSize:(CGSize)size animated:(BOOL)animated {
    self.size = size;
    if (animated) {
        SRInputStackViewPosition position = [self parentStackViewPosition];
        [self.messageInputBar performLayoutAnimated:animated animations:^{
            [self.messageInputBar layoutStackViewsWithPositions:@[@(position)]];
        }];
    }
}

#pragma mark - Hook Setup Methods
- (SRInputBarButtonItem *)configure:(SRInputBarButtonItemAction)item {
    item(self);
    return self;
}

- (SRInputBarButtonItem *)onKeyboardEditingBegins:(SRInputBarButtonItemAction)action {
    self.onKeyboardEditingEndsAction = action;
    return self;
}

- (SRInputBarButtonItem *)onKeyboardEditingEnds:(SRInputBarButtonItemAction)action {
    self.onKeyboardEditingEndsAction = action;
    return self;
}

- (SRInputBarButtonItem *)onTextViewDidChange:(void(^)(SRInputBarButtonItem *, UITextView *))action {
    self.onTextViewDidChangeAction = action;
    return self;
}

- (SRInputBarButtonItem *)onTouchUpInside:(SRInputBarButtonItemAction)action {
    self.onTouchUpInsideAction = action;
    return self;
}

- (SRInputBarButtonItem *)onSelected:(SRInputBarButtonItemAction)action {
    self.onSelectedAction = action;
    return self;
}

- (SRInputBarButtonItem *)onDeselected:(SRInputBarButtonItemAction)action {
    self.onDeselectedAction = action;
    return self;
}

- (SRInputBarButtonItem *)onEnabled:(SRInputBarButtonItemAction)action {
    self.onEnabledAction = action;
    return self;
}

- (SRInputBarButtonItem *)onDisabled:(SRInputBarButtonItemAction)action {
    self.onDisabledAction = action;
    return self;
}

#pragma mark - InputItem Protocol
- (void)textViewDidChangeAction:(UITextView *)textView {
    self.onTextViewDidChangeAction(self, textView);
}

- (void)keyboardEditingEndsAction {
    self.onKeyboardEditingEndsAction(self);
}

- (void)keyboardEditingBeginsAction {
    self.onKeyboardEditingBeginsAction(self);
}

- (void)touchUpInsideAction {
    self.onTouchUpInsideAction(self);
}

#pragma mark -
+ (SRInputBarButtonItem *)flexibleSpace {
    SRInputBarButtonItem *item = [[SRInputBarButtonItem alloc] init];
    [item setSize:CGSizeZero animated:NO];
    item.spacing = SRSpacingFlexible;
    return item;
}

+ (SRInputBarButtonItem *)fixedSpace:(CGFloat)width {
    SRInputBarButtonItem *item = [[SRInputBarButtonItem alloc] init];
    [item setSize:CGSizeZero animated:NO];
    item.spacing = SRSpacingFixed;
    item.spacingWidth = width;
    return item;
}

@end
