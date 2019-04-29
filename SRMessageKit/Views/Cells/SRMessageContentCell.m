//
//  SRMessageContentCell.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageContentCell.h"

@implementation SRMessageContentCell

- (SRAvatarView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[SRAvatarView alloc] initWithFrame:CGRectZero];
    }
    return _avatarView;
}

- (SRMessageContainerView *)messageContainerView {
    if (!_messageContainerView) {
        _messageContainerView = [[SRMessageContainerView alloc] initWithFrame:CGRectZero];
        _messageContainerView.clipsToBounds = YES;
        _messageContainerView.layer.masksToBounds = YES;
    }
    return _messageContainerView;
}

- (SRInsetLabel *)cellTopLabel {
    if (!_cellTopLabel) {
        _cellTopLabel = [[SRInsetLabel alloc] initWithFrame:CGRectZero];
        _cellTopLabel.numberOfLines = 0;
        _cellTopLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cellTopLabel;
}

- (SRInsetLabel *)messageTopLabel {
    if (!_messageTopLabel) {
        _messageTopLabel = [[SRInsetLabel alloc] initWithFrame:CGRectZero];
        _messageTopLabel.numberOfLines = 0;
    }
    return _messageTopLabel;
}

- (SRInsetLabel *)messageBottomLabel {
    if (!_messageBottomLabel) {
        _messageBottomLabel = [[SRInsetLabel alloc] initWithFrame:CGRectZero];
        _messageBottomLabel.numberOfLines = 0;
    }
    return _messageBottomLabel;
}

- (UIView *)accessoryView {
    if (!_accessoryView) {
        _accessoryView = [UIView new];
    }
    return _accessoryView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    [self.contentView addSubview:self.accessoryView];
    [self.contentView addSubview:self.cellTopLabel];
    [self.contentView addSubview:self.messageTopLabel];
    [self.contentView addSubview:self.messageBottomLabel];
    [self.contentView addSubview:self.messageContainerView];
    [self.contentView addSubview:self.avatarView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.cellTopLabel.text = nil;
    self.messageTopLabel.text = nil;
    self.messageBottomLabel.text = nil;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    if (![layoutAttributes isKindOfClass:[SRMessagesCollectionViewLayoutAttributes class]]) {
        return;
    }
    SRMessagesCollectionViewLayoutAttributes *attributes = (SRMessagesCollectionViewLayoutAttributes *)layoutAttributes;
    [self layoutMessageContainerView:attributes];
    [self layoutBottomLabelWithAttributes:attributes];
    [self layoutCellTopLabel:attributes];
    [self layoutMessageTopLabel:attributes];
    [self layoutAvatarView:attributes];
    [self layoutAccessoryViewWithAttributes:attributes];
}

- (void)configureWithMessageType:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath messageCollectionView:(SRMessagesCollectionView *)messageCollectionView {
    id dataSource = messageCollectionView.messageDataSource;
    id displayDelegate = messageCollectionView.messageDisplayDelegate;
    self.delegate = messageCollectionView.messageCellDelegate;
    
    UIColor *messageColor = [displayDelegate backgroundColorForMessage:messageType atIndexPath:indexPath inMessageCollectionView:messageCollectionView];
    SRMessageStyle *messageStyle = [displayDelegate messageStyleForMessageType:messageType atIndexPath:indexPath inMessageCollectionView:messageCollectionView];
    
    [displayDelegate configureAvatarView:self.avatarView forMessage:messageType atIndexPath:indexPath inMessageCollectionView:messageCollectionView];
    [displayDelegate configureAccessoryView:self.accessoryView forMessage:messageType atIndexPath:indexPath inMessageCollectionView:messageCollectionView];
    
    self.messageContainerView.backgroundColor = messageColor;
    self.messageContainerView.style = messageStyle;
    
    NSAttributedString *topCellLabelText = [dataSource cellTopLabelAttributedTextForMessage:messageType atIndexPath:indexPath];
    NSAttributedString *topMessageLabelText = [dataSource messageTopLabelAttributedTextForMessage:messageType atIndexPath:indexPath];
    NSAttributedString *bottomText = [dataSource messageBottomLabelAttributedText:messageType atIndexPath:indexPath];
    
    self.cellTopLabel.attributedText = topCellLabelText;
    self.messageTopLabel.attributedText = topMessageLabelText;
    self.messageBottomLabel.attributedText = bottomText;
}

- (void)handleTapGesture:(UIGestureRecognizer *)gesture {
    CGPoint touchLocation = [gesture locationInView:self];
    
    if (CGRectContainsPoint(self.messageContainerView.frame, touchLocation) && ![self cellContentViewCanHandleTouchPoint:[self convertPoint:touchLocation toView:self.messageContainerView]]) {
        [self.delegate didTapMessageInCell:self];
    } else if (CGRectContainsPoint(self.avatarView.frame, touchLocation)) {
        [self.delegate didTapAvatarInCell:self];
    } else if (CGRectContainsPoint(self.cellTopLabel.frame, touchLocation)) {
        [self.delegate didTapCellTopLabelInCell:self];
    } else if (CGRectContainsPoint(self.messageBottomLabel.frame, touchLocation)) {
        [self.delegate didTapMessageBottomLabelInCell:self];
    } else if (CGRectContainsPoint(self.accessoryView.frame, touchLocation)) {
        [self.delegate didTapAccessoryViewInCell:self];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:self];
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return CGRectContainsPoint(self.messageContainerView.frame, touchPoint);
    }
    return NO;
}

- (BOOL)cellContentViewCanHandleTouchPoint:(CGPoint)touchPoint {
    return NO;
}

- (void)layoutAvatarView:(SRMessagesCollectionViewLayoutAttributes *)attributes {
    CGPoint origin = CGPointZero;
    switch (attributes.avatarPosition.horizontal) {
        case SRAvatarPositionHorizontalCellLeading:
            break;
        case SRAvatarPositionHorizontalCellTrailing:
            origin.x = attributes.frame.size.width - attributes.avatarSize.width;
            break;
        case SRAvatarPositionHorizontalNatural:
        default:
            break;
    }
    
    switch (attributes.avatarPosition.vertical) {
        case SRAvatarPositionHorizontalMessageLabelTop:
            origin.y = CGRectGetMinY(self.messageTopLabel.frame);
            break;
        case SRAvatarPositionHorizontalMessageTop:
            origin.y = CGRectGetMinY(self.messageContainerView.frame);
            break;
        case SRAvatarPositionHorizontalMessageBottom:
            origin.y = CGRectGetMaxY(self.messageContainerView.frame) - attributes.avatarSize.height;
            break;
        case SRAvatarPositionHorizontalMessageCenter:
            origin.y = CGRectGetMidY(self.messageContainerView.frame) - attributes.avatarSize.height / 2.0;
            break;
        case SRAvatarPositionHorizontalCellBottom:
            origin.y = attributes.frame.size.height - attributes.avatarSize.height;
        default:
            break;
    }
    self.avatarView.frame = CGRectMake(origin.x, origin.y, attributes.avatarSize.width, attributes.avatarSize.height);
}

- (void)layoutMessageContainerView:(SRMessagesCollectionViewLayoutAttributes *)attributes {
    CGPoint origin = CGPointZero;
    switch (attributes.avatarPosition.vertical) {
        case SRAvatarPositionHorizontalMessageBottom:
            origin.y = attributes.size.height - attributes.messageContainerPadding.bottom - attributes.messageBottomLabelSize.height - attributes.messageContainerSize.height - attributes.messageContainerPadding.top;
        case SRAvatarPositionHorizontalMessageCenter:
        {
            if (attributes.avatarSize.height > attributes.messageContainerSize.height) {
                CGFloat messageHeight = attributes.messageContainerSize.height + attributes.messageContainerPadding.top + attributes.messageContainerPadding.bottom;
                origin.y = (attributes.size.height / 2.0) - (messageHeight / 2.0);
                break;
            } else {
            }
        }
        default:
            if (attributes.accessoryViewSize.height > attributes.messageContainerSize.height) {
                CGFloat messageHeight = attributes.messageContainerSize.height + attributes.messageContainerPadding.bottom + attributes.messageContainerPadding.top;
                origin.y = (attributes.size.height / 2.0) - (messageHeight / 2.0);
            } else {
                origin.y = attributes.cellTopLabelSize.height + attributes.messageContainerSize.height + attributes.messageContainerPadding.top;
            }
            break;
    }

    switch (attributes.avatarPosition.horizontal) {
        case SRAvatarPositionHorizontalCellLeading:
            origin.x = attributes.avatarSize.width + attributes.messageContainerPadding.left;
            break;
        case SRAvatarPositionHorizontalCellTrailing:
            origin.x = attributes.frame.size.width - attributes.avatarSize.width - attributes.messageContainerSize.width - attributes.messageContainerPadding.right;
        case SRAvatarPositionHorizontalNatural:
            
        default:
            break;
    }
    self.messageContainerView.frame = CGRectMake(origin.x, origin.y, attributes.messageContainerSize.width, attributes.messageContainerSize.height);
}

- (void)layoutCellTopLabel:(SRMessagesCollectionViewLayoutAttributes *)attributes {
    self.cellTopLabel.frame = CGRectMake(0, 0, attributes.cellTopLabelSize.width, attributes.cellTopLabelSize.height);
}

- (void)layoutMessageTopLabel:(SRMessagesCollectionViewLayoutAttributes *)attributes {
    self.messageTopLabel.textAlignment = attributes.messageTopLabelAlignment.textAlignment;
    self.messageTopLabel.textInsets = attributes.messageTopLabelAlignment.textInsets;
    
    CGFloat y = CGRectGetMinY(self.messageContainerView.frame) - attributes.messageContainerPadding.top - attributes.messageTopLabelSize.height;
    CGPoint origin = CGPointMake(0, y);
    
    self.messageTopLabel.frame = CGRectMake(origin.x, origin.y, attributes.messageTopLabelSize.width, attributes.messageTopLabelSize.height);
}

- (void)layoutBottomLabelWithAttributes:(SRMessagesCollectionViewLayoutAttributes *)attributes {
    self.messageBottomLabel.textAlignment = attributes.messageBottomLabelAlignment.textAlignment;
    self.messageBottomLabel.textInsets = attributes.messageBottomLabelAlignment.textInsets;
    
    CGFloat y = CGRectGetMaxX(self.messageContainerView.frame) + attributes.messageContainerPadding.bottom;
    CGPoint origin = CGPointMake(0, y);
    
    self.messageBottomLabel.frame = CGRectMake(origin.x, origin.y, attributes.messageBottomLabelSize.width, attributes.messageBottomLabelSize.height);
}

- (void)layoutAccessoryViewWithAttributes:(SRMessagesCollectionViewLayoutAttributes *)attributes {
    CGFloat y = CGRectGetMidY(self.messageContainerView.frame) - (attributes.accessoryViewSize.height / 2.0);
    
    CGPoint origin = CGPointMake(0, y);
    
    switch (attributes.avatarPosition.horizontal) {
        case SRAvatarPositionHorizontalCellLeading:
            origin.x = CGRectGetMaxX(self.messageContainerView.frame) + attributes.accessoryViewPadding.left;
            break;
        case SRAvatarPositionHorizontalCellTrailing:
            origin.x = CGRectGetMinX(self.messageContainerView.frame) + attributes.accessoryViewPadding.right - attributes.accessoryViewSize.width;
            break;
        case SRAvatarPositionHorizontalNatural:
            
        default:
            break;
    }
    
    self.accessoryView.frame = CGRectMake(origin.x, origin.y, attributes.accessoryViewSize.width, attributes.accessoryViewSize.height);
}

@end
