//
//  SRCellSizeCalculator.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRCellSizeCalculator : NSObject

@property (nonatomic, weak) UICollectionViewFlowLayout *layout;

- (void)configure:(UICollectionViewLayoutAttributes *)attributes;

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
