//
//  SRMessageInputBar.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageInputBar.h"
#import "NSLayoutConstraintSet.h"
#import "UIView+SRExtensions.h"

@interface SRMessageInputBar ()

@property (nonatomic, assign, readwrite) CGSize previousIntrinsicContentSize;

@property (nonatomic, assign, readwrite) BOOL isOverMaxTextViewHeight;

@property (nonatomic, assign, readwrite) BOOL shouldForceTextViewMaxHeight;

@property (nonatomic, assign, readwrite) CGFloat leftStackViewWidthConstant;

@property (nonatomic, assign, readwrite) CGFloat rightStackViewWidthConstant;

@property (nonatomic, strong, readwrite) NSArray *leftStackViewItems;

@property (nonatomic, strong, readwrite) NSArray *rightStackViewItems;

@property (nonatomic, strong, readwrite) NSArray *bottomStackViewItems;

@property (nonatomic, strong, readwrite) NSArray *topStackViewItems;

@property (nonatomic, assign) CGSize cachedIntrinsicContentSize;

@property (nonatomic, strong) NSLayoutConstraintSet *textViewLayoutSet;
@property (nonatomic, strong) NSLayoutConstraint *textViewHeightAnchor;
@property (nonatomic, strong) NSLayoutConstraintSet *topStackViewLayoutSet;
@property (nonatomic, strong) NSLayoutConstraintSet *leftStackViewLayoutSet;
@property (nonatomic, strong) NSLayoutConstraintSet *rightStackViewLayoutSet;
@property (nonatomic, strong) NSLayoutConstraintSet *bottomStackViewLayoutSet;
@property (nonatomic, strong) NSLayoutConstraintSet *contentViewLayoutSet;
@property (nonatomic, strong) NSLayoutConstraint *windowAnchor;
@property (nonatomic, strong) NSLayoutConstraint *backgroundViewBottomAnchor;

@end

@implementation SRMessageInputBar
@synthesize rightStackViewWidthConstant = _rightStackViewWidthConstant;
@synthesize contentView = _contentView;
@synthesize textViewPadding = _textViewPadding;
@synthesize padding = _padding;

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _backgroundView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}

- (UIVisualEffectView *)blurView {
    if (!_blurView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _blurView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _blurView;
}

- (void)setTranslucent:(BOOL)translucent {
    _translucent = translucent;
    if (translucent && self.blurView.superview == nil) {
        [self.backgroundView addSubview:self.blurView];
        [self.blurView fillSuperView];
    }
    self.blurView.hidden = !translucent;
}

- (UIView *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [UIView new];
        _separatorLine.backgroundColor = [UIColor magentaColor];
        _separatorLine.translatesAutoresizingMaskIntoConstraints = NO;
        [_separatorLine setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        
    }
    return _separatorLine;
}

- (SRInputStackView *)topStackView {
    if (!_topStackView) {
        _topStackView = [[SRInputStackView alloc] initWithAxis:UILayoutConstraintAxisVertical spacing:0];
        _topStackView.alignment = UIStackViewAlignmentFill;
    }
    return _topStackView;
}

- (SRInputStackView *)leftStackView {
    if (!_leftStackView) {
        _leftStackView = [[SRInputStackView alloc] initWithAxis:UILayoutConstraintAxisHorizontal spacing:0];
    }
    return _leftStackView;
}

- (SRInputStackView *)rightStackView {
    if (!_rightStackView) {
        _rightStackView = [[SRInputStackView alloc] initWithAxis:UILayoutConstraintAxisHorizontal spacing:0];
    }
    return _rightStackView;
}

- (SRInputStackView *)bottomStackView {
    if (!_bottomStackView) {
        _bottomStackView = [[SRInputStackView alloc] initWithAxis:UILayoutConstraintAxisHorizontal spacing:15];
    }
    return _bottomStackView;
}

- (SRInputTextView *)inputTextView {
    if (!_inputTextView) {
        _inputTextView = [SRInputTextView inputTextView];
        _inputTextView.translatesAutoresizingMaskIntoConstraints = NO;
        _inputTextView.messageInputBar = self;
    }
    return _inputTextView;
}

- (SRInputBarButtonItem *)sendButton {
    if (!_sendButton) {
        _sendButton = [SRInputBarButtonItem inputBarButtonItem];
        [[_sendButton configure:^(SRInputBarButtonItem *item) {
            [item setSize:CGSizeMake(52, 36) animated:NO];
            item.enabled = NO;
            [item setTitle:@"发送"];
            item.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        }] onTouchUpInside:^(SRInputBarButtonItem *item) {
            [item.messageInputBar didSelectSendButton];
        }];
    }
    return _sendButton;
}

- (UIEdgeInsets)padding {
    if (UIEdgeInsetsEqualToEdgeInsets(_padding, UIEdgeInsetsZero)) {
        return UIEdgeInsetsMake(6, 12, 6, 12);
    }
    return _padding;
}

- (void)setPadding:(UIEdgeInsets)padding {
    _padding = padding;
    [self updatePadding];
}

- (void)setTopStackViewPadding:(UIEdgeInsets)topStackViewPadding {
    _topStackViewPadding = topStackViewPadding;
    [self updateTopStackViewPadding];
}

- (UIEdgeInsets)textViewPadding {
    if (UIEdgeInsetsEqualToEdgeInsets(_textViewPadding, UIEdgeInsetsZero)) {
        return UIEdgeInsetsMake(0, 0, 0, 8);
    }
    return _textViewPadding;
}

- (void)setTextViewPadding:(UIEdgeInsets)textViewPadding {
    _textViewPadding = textViewPadding;
    [self updateTextViewPadding];
}

- (void)setMaxTextViewHeight:(CGFloat)maxTextViewHeight {
    _maxTextViewHeight = maxTextViewHeight;
    self.textViewHeightAnchor.constant = maxTextViewHeight;
    [self invalidateIntrinsicContentSize];
}

- (CGFloat)requiredInputTextViewHeight {
    CGSize maxTextViewSize = CGSizeMake(CGRectGetWidth(self.inputTextView.bounds), CGFLOAT_MAX);
    return floor([self.inputTextView sizeThatFits:maxTextViewSize].height);
}

- (void)setLeftStackViewWidthConstant:(CGFloat)leftStackViewWidthConstant {
    _leftStackViewWidthConstant = leftStackViewWidthConstant;
    self.leftStackViewLayoutSet.sr_width.constant = leftStackViewWidthConstant;
}

- (void)setRightStackViewWidthConstant:(CGFloat)rightStackViewWidthConstant {
    _rightStackViewWidthConstant = rightStackViewWidthConstant;
    self.rightStackViewLayoutSet.sr_width.constant = rightStackViewWidthConstant;
}

- (CGFloat)rightStackViewWidthConstant {
    if (_rightStackViewWidthConstant == 0) {
        _rightStackViewWidthConstant = 52;
    }
    return _rightStackViewWidthConstant;
}

- (NSArray *)leftStackViewItems {
    if (!_leftStackViewItems) {
        _leftStackViewItems = @[];
    }
    return _leftStackViewItems;
}

- (NSArray *)rightStackViewItems {
    if (!_rightStackViewItems) {
        _rightStackViewItems = @[];
    }
    return _rightStackViewItems;
}

- (NSArray *)bottomStackViewItems {
    if (!_bottomStackViewItems) {
        _bottomStackViewItems = @[];
    }
    return _bottomStackViewItems;
}

- (NSArray *)topStackViewItems {
    if (!_topStackViewItems) {
        _topStackViewItems = @[];
    }
    return _topStackViewItems;
}

- (NSArray *)nonStackViewItems {
    if (!_nonStackViewItems) {
        _nonStackViewItems = @[];
    }
    return _nonStackViewItems;
}

- (NSArray *)items {
    NSMutableArray *allItems = [NSMutableArray arrayWithArray:self.leftStackViewItems];
    [allItems addObjectsFromArray:self.rightStackViewItems];
    [allItems addObjectsFromArray:self.bottomStackViewItems];
    [allItems addObjectsFromArray:self.topStackViewItems];
    [allItems addObjectsFromArray:self.nonStackViewItems];
    return [allItems copy];
}

- (CGSize)intrinsicContentSize {
    return self.cachedIntrinsicContentSize;
}

- (CGSize)cachedIntrinsicContentSize {
    if (CGSizeEqualToSize(_cachedIntrinsicContentSize, CGSizeZero)) {
        _cachedIntrinsicContentSize = [self calculateIntrinsicContentSize];
    }
    return _cachedIntrinsicContentSize;
}

#pragma mark - Initialization
+ (instancetype)messageInputBar {
    SRMessageInputBar *messageInputBar = [[SRMessageInputBar alloc] initWithFrame:CGRectZero];
    return messageInputBar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self setupConstraintsToWindow:self.window];
}

#pragma mark - Setup
- (void)setup {
    self.shouldManageSendButtonEnabledState = YES;
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self setupSubviews];
    [self setupConstraints];
    [self setupObservers];
}

- (void)setupObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextViewDidChange) name:UITextViewTextDidChangeNotification object:self.inputTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextViewDidBeginEditing) name:UITextViewTextDidBeginEditingNotification object:self.inputTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputTextViewDidEndEditing) name:UITextViewTextDidEndEditingNotification object:self.inputTextView];
}

- (void)setupSubviews {
    self.backgroundView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.backgroundView];
    self.topStackView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.topStackView];
    self.contentView.backgroundColor = [UIColor redColor];
    [self addSubview:self.contentView];
    self.separatorLine.backgroundColor = [UIColor blueColor];
    [self addSubview:self.separatorLine];
    self.inputTextView.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:self.inputTextView];
    self.leftStackView.backgroundColor = [UIColor brownColor];
    [self.contentView addSubview:self.leftStackView];
    
    self.rightStackView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.rightStackView];
    self.bottomStackView.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:self.bottomStackView];
    [self setStackViewItems:@[self.sendButton] forStackPostion:SRInputStackViewRight animated:NO];
}

- (void)setupConstraints {
    [self.separatorLine addConstraints:self.topAnchor
                                  left:self.leftAnchor
                                bottom:nil
                                 right:self.rightAnchor
                           topConstant:0
                          leftConstant:0
                        bottomConstant:0
                         rightConstant:0
                         widthConstant:0
                        heightConstant:1/[UIScreen mainScreen].scale];
    self.backgroundViewBottomAnchor = [self.backgroundView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    self.backgroundViewBottomAnchor.active = YES;
    [self.backgroundView addConstraints:self.topStackView.bottomAnchor
                                   left:self.leftAnchor
                                 bottom:nil
                                  right:self.rightAnchor
                            topConstant:0
                           leftConstant:0
                         bottomConstant:0
                          rightConstant:0
                          widthConstant:0
                         heightConstant:0];
    
    NSLayoutConstraint *top = [self.topStackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:self.topStackViewPadding.top];
    NSLayoutConstraint *bottom = [self.topStackView.bottomAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:-self.padding.top];
    NSLayoutConstraint *left = [self.topStackView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.topStackViewPadding.left];
    NSLayoutConstraint *right = [self.topStackView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-self.topStackViewPadding.right];

    NSLayoutConstraint *contentTop = [self.contentView.topAnchor constraintEqualToAnchor:self.topStackView.bottomAnchor constant:self.padding.top];
    NSLayoutConstraint *contentBottom = [self.contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-self.padding.bottom];
    NSLayoutConstraint *contentLeft = [self.contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.padding.left];
    NSLayoutConstraint *contentRight = [self.contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-self.padding.right];

    
    if (@available(iOS 11.0, *)) {
        contentBottom = [self.contentView.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-self.padding.bottom];
        contentLeft = [self.contentView.leftAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leftAnchor constant:self.padding.left];
        contentRight = [self.contentView.rightAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.rightAnchor constant:-self.padding.right];


        left = [self.topStackView.leftAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leftAnchor constant:self.topStackViewPadding.left];
        right = [self.topStackView.rightAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.rightAnchor constant:-self.topStackViewPadding.right];
    }
    
    self.topStackViewLayoutSet = [[NSLayoutConstraintSet alloc] initWithTop:top bottom:bottom left:left right:right centerX:nil centerY:nil width:nil height:nil];
    
    self.contentViewLayoutSet = [[NSLayoutConstraintSet alloc] initWithTop:contentTop bottom:contentBottom left:contentLeft right:contentRight centerX:nil centerY:nil width:nil height:nil];

    
    NSLayoutConstraint *textViewTop = [self.inputTextView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:self.textViewPadding.top];
    NSLayoutConstraint *textViewBottom = [self.inputTextView.bottomAnchor constraintEqualToAnchor:self.bottomStackView.topAnchor constant:-self.textViewPadding.bottom];
    NSLayoutConstraint *textViewLeft = [self.inputTextView.leftAnchor constraintEqualToAnchor:self.leftStackView.rightAnchor constant:self.textViewPadding.left];
    NSLayoutConstraint *textViewRight = [self.inputTextView.rightAnchor constraintEqualToAnchor:self.rightStackView.leftAnchor constant:-self.textViewPadding.right];
    self.textViewLayoutSet = [[NSLayoutConstraintSet alloc] initWithTop:textViewTop bottom:textViewBottom left:textViewLeft right:textViewRight centerX:nil centerY:nil width:nil height:nil];
    
    self.maxTextViewHeight = [self calculateMaxTextViewHeight];
    self.textViewHeightAnchor = [self.inputTextView.heightAnchor constraintEqualToConstant:self.maxTextViewHeight];

    NSLayoutConstraint *leftStackTop = [self.leftStackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0];
    NSLayoutConstraint *leftStackBottom = [self.leftStackView.bottomAnchor constraintEqualToAnchor:self.inputTextView.bottomAnchor constant:0];
    NSLayoutConstraint *leftStackLeft = [self.leftStackView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0];
    NSLayoutConstraint *leftStackWidth = [self.leftStackView.widthAnchor constraintEqualToConstant:self.leftStackViewWidthConstant];
    self.leftStackViewLayoutSet = [[NSLayoutConstraintSet alloc] initWithTop:leftStackTop bottom:leftStackBottom left:leftStackLeft right:nil centerX:nil centerY:nil width:leftStackWidth height:nil];

    NSLayoutConstraint *rightStackTop = [self.rightStackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:0];
    NSLayoutConstraint *rightStackBottom = [self.rightStackView.bottomAnchor constraintEqualToAnchor:self.inputTextView.bottomAnchor constant:0];
    NSLayoutConstraint *rightStackRight = [self.rightStackView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:0];
    NSLayoutConstraint *rightStackWidth = [self.rightStackView.widthAnchor constraintEqualToConstant:self.rightStackViewWidthConstant];
    self.rightStackViewLayoutSet = [[NSLayoutConstraintSet alloc] initWithTop:rightStackTop bottom:rightStackBottom left:nil right:rightStackRight centerX:nil centerY:nil width:rightStackWidth height:nil];

    NSLayoutConstraint *bottomStackTop = [self.bottomStackView.topAnchor constraintEqualToAnchor:self.inputTextView.bottomAnchor constant:self.textViewPadding.bottom];
    NSLayoutConstraint *bottomStackBottom = [self.bottomStackView.bottomAnchor  constraintEqualToAnchor:self.contentView.bottomAnchor constant:0];
    NSLayoutConstraint *bottomStackLeft = [self.bottomStackView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:0];
    NSLayoutConstraint *bottomStackRight = [self.bottomStackView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:0];
    self.bottomStackViewLayoutSet = [[NSLayoutConstraintSet alloc] initWithTop:bottomStackTop bottom:bottomStackBottom left:bottomStackLeft right:bottomStackRight centerX:nil centerY:nil width:nil height:nil];

    [self activateConstraints];
}

- (void)setupConstraintsToWindow:(UIWindow *)window {
    if (@available(iOS 11.0, *)) {
        if (CGRectGetHeight([UIScreen mainScreen].nativeBounds) != 2436) {
            return;
        }
        self.windowAnchor.active = NO;
        self.windowAnchor = [self.contentView.bottomAnchor constraintLessThanOrEqualToSystemSpacingBelowAnchor:window.safeAreaLayoutGuide.bottomAnchor multiplier:1];
        self.windowAnchor.constant = -self.padding.bottom;
        self.windowAnchor.priority = UILayoutPriorityDefaultHigh;
        self.windowAnchor.active = YES;
        self.backgroundViewBottomAnchor.constant = 34;
    }
}

#pragma mark - Auto-Layout Constraint Sets
- (void)updatePadding {
    self.topStackViewLayoutSet.sr_bottom.constant = -self.padding.top;
    self.contentViewLayoutSet.sr_top.constant = self.padding.top;
    self.contentViewLayoutSet.sr_left.constant = self.padding.left;
    self.contentViewLayoutSet.sr_right.constant = -self.padding.right;
    self.contentViewLayoutSet.sr_bottom.constant = -self.padding.bottom;
    self.windowAnchor.constant = -self.padding.bottom;
}

- (void)updateTextViewPadding {
    self.textViewLayoutSet.sr_top.constant = self.textViewPadding.top;
    self.textViewLayoutSet.sr_left.constant = self.textViewPadding.left;
    self.textViewLayoutSet.sr_right.constant = -self.textViewPadding.right;
    self.textViewLayoutSet.sr_bottom.constant = -self.textViewPadding.bottom;
    self.bottomStackViewLayoutSet.sr_top.constant = self.textViewPadding.bottom;
}

- (void)updateTopStackViewPadding {
    self.topStackViewLayoutSet.sr_top.constant = self.topStackViewPadding.top;
    self.topStackViewLayoutSet.sr_left.constant = self.topStackViewPadding.left;
    self.topStackViewLayoutSet.sr_right.constant = -self.topStackViewPadding.right;
}

- (void)invalidateIntrinsicContentSize {
    [super invalidateIntrinsicContentSize];
    self.cachedIntrinsicContentSize = [self cachedIntrinsicContentSize];
    if (!CGSizeEqualToSize(self.previousIntrinsicContentSize, [self cachedIntrinsicContentSize]) ) {
        if ([self.delegate respondsToSelector:@selector(messageInputBar:didChangeIntrinsicContentToSize:)]) {
            [self.delegate messageInputBar:self didChangeIntrinsicContentToSize:self.cachedIntrinsicContentSize];
        }
        self.previousIntrinsicContentSize = self.cachedIntrinsicContentSize;
    }
}

- (CGSize)calculateIntrinsicContentSize {
    CGFloat inputTextViewHeight = self.requiredInputTextViewHeight;
    if (inputTextViewHeight >= self.maxTextViewHeight) {
        if (!self.isOverMaxTextViewHeight) {
            self.textViewHeightAnchor.active = YES;
            self.inputTextView.scrollEnabled = YES;
            self.isOverMaxTextViewHeight = YES;
            [self.inputTextView layoutIfNeeded];
        }
        inputTextViewHeight = self.maxTextViewHeight;
    } else {
        if (self.isOverMaxTextViewHeight) {
            self.textViewHeightAnchor.active = NO;
            self.inputTextView.scrollEnabled = NO;
            self.isOverMaxTextViewHeight = NO;
            [self.inputTextView invalidateIntrinsicContentSize];
        }
    }
    
    CGFloat totalPadding = self.padding.top + self.padding.bottom + self.topStackViewPadding.top + self.textViewPadding.top + self.textViewPadding.bottom;
    CGFloat topStackViewHeight = self.topStackView.arrangedSubviews.count > 0 ? self.topStackView.bounds.size.height : 0;
    CGFloat bottomStackViewHeight = self.bottomStackView.arrangedSubviews.count > 0 ? self.bottomStackView.bounds.size.height : 0;
    CGFloat verticalStackViewHeight = topStackViewHeight + bottomStackViewHeight;
    CGFloat requiredHeight = inputTextViewHeight + totalPadding + verticalStackViewHeight;
    return CGSizeMake(CGRectGetWidth(self.bounds), requiredHeight);
}

- (CGFloat)calculateMaxTextViewHeight {
    if (self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
        return ceil([UIScreen mainScreen].bounds.size.height / 3);
    }
    return ceil([UIScreen mainScreen].bounds.size.height / 5);
}

#pragma mark - Layout Helper Methods
- (void)layoutStackViewsWithPositions:(NSArray *)positions {
    if (!self.superview) {
        return;
    }
    for (NSNumber *positionValue in positions) {
        switch (positionValue.intValue) {
            case SRInputStackViewLeft:
            {
                [self.leftStackView setNeedsLayout];
                [self.leftStackView layoutIfNeeded];
            }
                break;
            case SRInputStackViewRight:
            {
                [self.rightStackView setNeedsLayout];
                [self.rightStackView layoutIfNeeded];
            }
                break;
            case SRInputStackViewBottom:
            {
                [self.bottomStackView setNeedsLayout];
                [self.bottomStackView layoutIfNeeded];
            }
                break;
            case SRInputStackViewTop:
            {
                [self.topStackView setNeedsLayout];
                [self.topStackView layoutIfNeeded];
            }
                break;
            default:
                break;
        }
    }
}

- (void)performLayoutAnimated:(BOOL)animated animations:(void(^)(void))animations {
    [self deactivateConstraints];
    if (animated) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:animations];
        });
    } else {
        [UIView performWithoutAnimation:^{
            animations();
        }];
    }
    [self activateConstraints];
}

- (void)activateConstraints {
    [self.contentViewLayoutSet acctivate];
    [self.textViewLayoutSet acctivate];
    [self.leftStackViewLayoutSet acctivate];
    [self.rightStackViewLayoutSet acctivate];
    [self.bottomStackViewLayoutSet acctivate];
    [self.topStackViewLayoutSet acctivate];
}

- (void)deactivateConstraints {
    [self.contentViewLayoutSet deactivate];
    [self.textViewLayoutSet deactivate];
    [self.leftStackViewLayoutSet deactivate];
    [self.rightStackViewLayoutSet deactivate];
    [self.bottomStackViewLayoutSet deactivate];
    [self.topStackViewLayoutSet deactivate];
}

- (void)setStackViewItems:(NSArray *)items forStackPostion:(SRInputStackViewPosition)position animated:(BOOL)animated {
    [self performLayoutAnimated:animated animations:^{
        switch (position) {
            case SRInputStackViewLeft:
            {
                for (UIView *view in self.leftStackView.arrangedSubviews) {
                    [view removeFromSuperview];
                }
                self.leftStackViewItems = items;
                for (SRInputItem *item in self.leftStackViewItems) {
                    item.messageInputBar = self;
                    item.parentStackViewPosition = position;
                    [self.leftStackView addArrangedSubview:item];
                }
                if (self.superview != nil) {
                    [self.leftStackView layoutIfNeeded];
                }
            }
                break;
            case SRInputStackViewRight:
            {
                for (UIView *view in self.rightStackView.arrangedSubviews) {
                    [view removeFromSuperview];
                }
                self.rightStackViewItems = items;
                for (SRInputItem *item in self.rightStackViewItems) {
                    item.messageInputBar = self;
                    item.parentStackViewPosition = position;
                    [self.rightStackView addArrangedSubview:item];
                }
                if (self.superview != nil) {
                    [self.rightStackView layoutIfNeeded];
                }
            }
                break;
            case SRInputStackViewBottom:
            {
                for (UIView *view in self.bottomStackView.arrangedSubviews) {
                    [view removeFromSuperview];
                }
                self.bottomStackViewItems = items;
                for (SRInputItem *item in self.bottomStackViewItems) {
                    item.messageInputBar = self;
                    item.parentStackViewPosition = position;
                    [self.bottomStackView addArrangedSubview:item];
                }
                if (self.superview != nil) {
                    [self.bottomStackView layoutIfNeeded];
                }
            }
                break;
            case SRInputStackViewTop:
            {
                for (UIView *view in self.topStackView.arrangedSubviews) {
                    [view removeFromSuperview];
                }
                self.topStackViewItems = items;
                for (SRInputItem *item in self.topStackViewItems) {
                    item.messageInputBar = self;
                    item.parentStackViewPosition = position;
                    [self.topStackView addArrangedSubview:item];
                }
                if (self.superview != nil) {
                    [self.topStackView layoutIfNeeded];
                }
            }
                break;
            default:
                break;
        }
    }];
}

- (void)setLeftStackViewWidthConstant:(CGFloat)newValue animated:(BOOL)animated {
    [self performLayoutAnimated:animated animations:^{
        self.leftStackViewWidthConstant = newValue;
        [self layoutStackViewsWithPositions:@[@(SRInputStackViewLeft)]];
        if (self.superview.superview) {
            [self.superview.superview layoutIfNeeded];
        }
    }];
}

- (void)setRightStackViewWidthConstant:(CGFloat)newValue animated:(BOOL)animated {
    [self performLayoutAnimated:animated animations:^{
        self.rightStackViewWidthConstant = newValue;
        [self layoutStackViewsWithPositions:@[@(SRInputStackViewRight)]];
        if (self.superview.superview) {
            [self.superview.superview layoutIfNeeded];
        }
    }];
}

- (void)setShouldForceTextViewMaxHeight:(BOOL)shouldForceTextViewMaxHeight animated:(BOOL)animated {
    [self performLayoutAnimated:animated animations:^{
        self.shouldForceTextViewMaxHeight = shouldForceTextViewMaxHeight;
        self.textViewHeightAnchor.active = shouldForceTextViewMaxHeight;
        if (self.superview.superview) {
            [self.superview.superview layoutIfNeeded];
        }
    }];
}

#pragma mark - Notifications/Hooks
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass || self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass) {
        if (self.shouldAutoUpdateMaxTextViewHeight) {
            self.maxTextViewHeight = [self calculateMaxTextViewHeight];
        } else {
            [self invalidateIntrinsicContentSize];
        }
    }
}

- (void)orientationDidChange {
    if (self.shouldAutoUpdateMaxTextViewHeight) {
        self.maxTextViewHeight = [self calculateMaxTextViewHeight];
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
//    }
    
    [self.delegate messageInputBar:self textViewTextDidChangeTo:trimmedText];
    if (shouldInvalidateIntrinsicContentSize) {
        [self invalidateIntrinsicContentSize];
    }
}

- (void)inputTextViewDidBeginEditing {
    
}

- (void)inputTextViewDidEndEditing {
    
}

#pragma mark - Plugins
- (void)reloadPlugins {
    
}

- (void)invalidatePlugins {
    
}

#pragma mark - User Actions
- (void)didSelectSendButton {
    [self.delegate messageInputBar:self didPressSendButtonWithText:self.inputTextView.text];
}

@end
