//
//  SRMessageKind.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRMediaItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum SRMessagesKind: NSUInteger {
    SRMessagesKindText,
    SRMessagesKindAttributedText,
    SRMessagesKindPhoto,
    SRMessagesKindVideo,
    SRMessagesKindEmoji,
    SRMessagesKindCustom,
} SRMessagesKind;

@interface SRMessageKind : NSObject

@property (nonatomic, assign)SRMessagesKind kind;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributedText;
@property (nonatomic, strong) SRMediaItem *photo;
@property (nonatomic, strong) SRMediaItem *video;
@property (nonatomic, strong) NSString *emojiString;
@property (nonatomic, strong) NSObject *custom;

@end

NS_ASSUME_NONNULL_END
