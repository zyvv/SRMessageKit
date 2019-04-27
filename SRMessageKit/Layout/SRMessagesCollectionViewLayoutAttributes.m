//
//  SRMessagesCollectionViewLayoutAttributes.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesCollectionViewLayoutAttributes.h"

@implementation SRMessagesCollectionViewLayoutAttributes

- (SRAvatarPosition *)avatarPosition {
    if (!_avatarPosition) {
        _avatarPosition = [[SRAvatarPosition alloc] initWithVertical:SRAvatarPositionHorizontalMessageTop];
    }
    return _avatarPosition;
}

- (UIFont *)messageLabelFont {
    if (!_messageLabelFont) {
        _messageLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    return _messageLabelFont;
}

- (SRLabelAlignment *)cellTopLabelAlignment {
    if (!_cellTopLabelAlignment) {
        _cellTopLabelAlignment = [[SRLabelAlignment alloc] initWithTextAlignment:NSTextAlignmentCenter textInsets:UIEdgeInsetsZero];
    }
    return _cellTopLabelAlignment;
}

- (SRLabelAlignment *)messageTopLabelAlignment {
    if (!_messageTopLabelAlignment) {
        _messageTopLabelAlignment = [[SRLabelAlignment alloc] initWithTextAlignment:NSTextAlignmentCenter textInsets:UIEdgeInsetsZero];
    }
    return _messageTopLabelAlignment;
}

- (SRLabelAlignment *)messageBottomLabelAlignment {
    if (!_messageBottomLabelAlignment) {
        _messageBottomLabelAlignment = [[SRLabelAlignment alloc] initWithTextAlignment:NSTextAlignmentCenter textInsets:UIEdgeInsetsZero];
    }
    return _messageBottomLabelAlignment;
}

- (SRHorizontalEdgeInsets *)accessoryViewPadding {
    if (!_accessoryViewPadding) {
        _accessoryViewPadding = [SRHorizontalEdgeInsets zero];
    }
    return _accessoryViewPadding;
}

- (id)copyWithZone:(NSZone *)zone {
    SRMessagesCollectionViewLayoutAttributes *copy = [super copyWithZone:zone];
    if (copy) {
        copy.avatarSize = _avatarSize;
        copy.avatarPosition = _avatarPosition;
        copy.messageContainerSize = _messageContainerSize;
        copy.messageContainerPadding = _messageContainerPadding;
        copy.messageLabelFont = _messageLabelFont;
        copy.messageLabelInsets = _messageLabelInsets;
        copy.cellTopLabelAlignment = _cellTopLabelAlignment;
        copy.cellTopLabelSize = _cellTopLabelSize;
        copy.messageTopLabelAlignment = _messageTopLabelAlignment;
        copy.messageTopLabelSize = _messageTopLabelSize;
        copy.messageBottomLabelAlignment = _messageBottomLabelAlignment;
        copy.messageBottomLabelSize = _messageBottomLabelSize;
        copy.accessoryViewSize = _accessoryViewSize;
        copy.accessoryViewPadding = _accessoryViewPadding;
    }
    return copy;
}

- (BOOL)isEqual:(SRMessagesCollectionViewLayoutAttributes *)object {
    return [super isEqual:object] && object.avatarSize.width == _avatarSize.width && object.avatarSize.height == _avatarSize.height && object.avatarPosition == _avatarPosition && object.messageContainerSize.width == _messageContainerSize.width && object.messageContainerSize.height == _messageContainerSize.height && object.messageContainerPadding.top == _messageContainerPadding.top && object.messageContainerPadding.left == _messageContainerPadding.left && object.messageContainerPadding.bottom == _messageContainerPadding.bottom && object.messageContainerPadding.right == _messageContainerPadding.right && object.messageLabelFont == _messageLabelFont && object.messageLabelInsets.top == _messageLabelInsets.top && object.messageLabelInsets.left == _messageLabelInsets.left && object.messageLabelInsets.bottom == _messageLabelInsets.bottom == object.messageLabelInsets.right == _messageLabelInsets.right && object.cellTopLabelAlignment == _cellTopLabelAlignment && object.cellTopLabelSize.width == _cellTopLabelSize.width && object.cellTopLabelSize.height == _cellTopLabelSize.height && object.messageTopLabelAlignment == _messageTopLabelAlignment && object.messageTopLabelSize.width == _messageTopLabelSize.width && object.messageTopLabelSize.height == _messageTopLabelSize.height && object.messageBottomLabelAlignment == _messageBottomLabelAlignment && object.messageBottomLabelSize.width == _messageBottomLabelSize.width && object.messageBottomLabelSize.height == _messageBottomLabelSize.height && object.accessoryViewSize.width == _accessoryViewSize.width && object.accessoryViewSize.height == _accessoryViewSize.height &&  object.accessoryViewPadding == _accessoryViewPadding;
}

@end
