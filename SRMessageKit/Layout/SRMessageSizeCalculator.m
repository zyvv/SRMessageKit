//
//  SRMessageSizeCalculator.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageSizeCalculator.h"
#import "SRMessagesCollectionViewLayoutAttributes.h"

@implementation SRMessageSizeCalculator

- (void)configure:(UICollectionViewLayoutAttributes *)attributes {
    if (![attributes isKindOfClass:[SRMessagesCollectionViewLayoutAttributes class]]) {
        return;
    }
    SRMessagesCollectionViewLayoutAttributes *messageAttributes = (SRMessagesCollectionViewLayoutAttributes *)attributes;
//    let dataSource = messagesLayout.messagesDataSource;
    NSIndexPath *indexPath = messageAttributes.indexPath;
//    let message = dataSource.messageForItem(at: indexPath, in: messagesLayout.messagesCollectionView)
    messageAttributes.avatarSize = 
    
}

#pragma mark - Helpers
- (SRMessagesCollectionViewFlowLayout *)messageLayout {
    NSAssert([self.layout isKindOfClass:[SRMessagesCollectionViewFlowLayout class]], @"Layout object is missing or is not a SRMessagesCollectionViewFlowLayout");
    return (SRMessagesCollectionViewFlowLayout *)self.layout;
}

@end
