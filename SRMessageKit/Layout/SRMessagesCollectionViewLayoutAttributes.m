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
    return [super isEqual:object]
        && CGSizeEqualToSize(object.avatarSize, _avatarSize)
        && object.avatarPosition == _avatarPosition
        && CGSizeEqualToSize(object.messageContainerSize, _messageContainerSize)
        && UIEdgeInsetsEqualToEdgeInsets(object.messageContainerPadding, _messageContainerPadding)
        && object.messageLabelFont == _messageLabelFont
        && UIEdgeInsetsEqualToEdgeInsets(object.messageLabelInsets, _messageLabelInsets)
        && object.cellTopLabelAlignment == _cellTopLabelAlignment
        && CGSizeEqualToSize(object.cellTopLabelSize, _cellTopLabelSize)
        && object.messageTopLabelAlignment == _messageTopLabelAlignment
        && CGSizeEqualToSize(object.messageTopLabelSize, _messageTopLabelSize)
        && object.messageBottomLabelAlignment == _messageBottomLabelAlignment
        && CGSizeEqualToSize(object.messageBottomLabelSize, _messageBottomLabelSize)
        && CGSizeEqualToSize(object.accessoryViewSize, _accessoryViewSize)
        && object.accessoryViewPadding == _accessoryViewPadding;
}

@end
