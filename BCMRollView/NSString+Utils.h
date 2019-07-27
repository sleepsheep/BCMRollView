//
//  NSString+Utils.h
//  BCMRollView
//
//  Created by Kevin on 2019/7/27.
//  Copyright © 2019 LY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utils)

- (BOOL)isNumber;

- (CGFloat)widthForSelf:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
