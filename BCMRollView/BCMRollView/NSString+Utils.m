//
//  NSString+Utils.m
//  BCMRollView
//
//  Created by Kevin on 2019/7/27.
//  Copyright © 2019 LY. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

- (BOOL)isNumber {
    if ([self isEqualToString:@"0"]
        || [self isEqualToString:@"1"]
        || [self isEqualToString:@"2"]
        || [self isEqualToString:@"3"]
        || [self isEqualToString:@"4"]
        || [self isEqualToString:@"5"]
        || [self isEqualToString:@"6"]
        || [self isEqualToString:@"7"]
        || [self isEqualToString:@"8"]
        || [self isEqualToString:@"9"]) {
        return YES;
    }
    return NO;
}

- (CGFloat)widthForSelf:(CGFloat)fontSize {
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size.width;
}

@end
