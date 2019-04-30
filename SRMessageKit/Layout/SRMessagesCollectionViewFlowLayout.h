//
//  SRMessagesCollectionViewFlowLayout.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRMessagesCollectionView.h"

@class SRTextMessageSizeCalculator;
@class SRMediaMessageSizeCalculator;

NS_ASSUME_NONNULL_BEGIN

@interface SRMessagesCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) SRMessagesCollectionView *messagesCollectionView;

@property (nonatomic, weak) id<SRMessagesDataSource> messagesDataSource;

@property (nonatomic, weak) id<SRMessagesLayoutDelegate> messagesLayoutDelegate;

@property (nonatomic, assign) CGFloat itemWidth;

@property (nonatomic, strong) SRTextMessageSizeCalculator *textMessageSizeCalculator;

@property (nonatomic, strong) SRTextMessageSizeCalculator *attributedTextMessageSizeCalculator;

@property (nonatomic, strong) SRTextMessageSizeCalculator *emojiMessageSizeCalculator;

@property (nonatomic, strong) SRMediaMessageSizeCalculator *photoMessageSizeCalculator;

@property (nonatomic, strong) SRMediaMessageSizeCalculator *videoMessageSizeCalculator;

@property (nonatomic, strong) SRMediaMessageSizeCalculator *locationMessageSizeCalculator;

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
