//
//  NSBundle+SRExtensions.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "NSBundle+SRExtensions.h"
#import "SRMessagesViewController.h"

@implementation NSBundle (SRExtensions)

+ (NSBundle *)messageKietAssetBundle {
    NSBundle *podBundle = [NSBundle bundleForClass:[SRMessagesViewController class]];
    NSURL *resourceBundleUrl = [podBundle URLForResource:@"SRMessageKitAssets" withExtension:@"bundle"];
//    NSAssert(resourceBundleUrl, <#desc, ...#>)
    NSBundle *resourceBundle = [NSBundle bundleWithURL:resourceBundleUrl];
//    NSAssert(resourceBundle, <#desc, ...#>)

    return resourceBundle;
}

@end
