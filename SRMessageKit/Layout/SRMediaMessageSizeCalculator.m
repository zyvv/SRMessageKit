//
//  SRMediaMessageSizeCalculator.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMediaMessageSizeCalculator.h"
#import "SRMessageType.h"

@implementation SRMediaMessageSizeCalculator

- (CGSize)messageContainerSizeForMessage:(SRMessageType *)message {
    CGFloat maxWidth = [self messageContainerMaxWidthForMessage:message];
    CGSize(^sizeForMediaItem)(CGFloat, SRMediaItem *) = ^(CGFloat maxsWidth, SRMediaItem *item) {
        if (maxWidth < item.size.width) {
            CGFloat height = maxWidth * item.size.height / item.size.width;
            return CGSizeMake(maxWidth, height);
        }
        return item.size;
    };
    
    switch (message.kind.kind) {
        case SRMessagesKindPhoto:
            return sizeForMediaItem(maxWidth, message.kind.photo);
            break;
        case SRMessagesKindVideo:
            return sizeForMediaItem(maxWidth, message.kind.video);
            break;
        default:
            break;
    }
    return CGSizeZero;
}

@end
