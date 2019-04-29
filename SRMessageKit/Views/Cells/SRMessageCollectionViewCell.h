//
//  SRMessageCollectionViewCell.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SRMessageCollectionViewCell;
@protocol SRMessageCellDelegate <NSObject>

- (void)didTapMessageInCell:(SRMessageCollectionViewCell *)cell;

- (void)didTapAvatarInCell:(SRMessageCollectionViewCell *)cell;

- (void)didTapCellTopLabelInCell:(SRMessageCollectionViewCell *)cell;

- (void)didTapMessageTopLabelInCell:(SRMessageCollectionViewCell *)cell;

- (void)didTapMessageBottomLabelInCell:(SRMessageCollectionViewCell *)cell;

- (void)didTapAccessoryViewInCell:(SRMessageCollectionViewCell *)cell;

@end

@interface SRMessageCollectionViewCell : UICollectionViewCell

@end

NS_ASSUME_NONNULL_END
