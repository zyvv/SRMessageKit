//
//  NSArray+SRExtensions.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (SRExtensions)

- (NSArray *)map:(id (^)(id obj))block;

- (NSArray *)filter:(BOOL (^)(id obj))block;

- (id)reduce:(id)initial block:(id (^)(id obj1, id obj2))block;

- (NSArray *)flatMap:(id (^)(id obj))block;
@end

NS_ASSUME_NONNULL_END
