//
//  BCMRollView.h
//  RollLabel
//
//  Created by Kevin on 2019/7/27.
//  Copyright © 2019 LY. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

/** 52,000.00
 1、数字从0开始滚动到9，数字滚动不要有跳跃性，比如第一个数字5滚动一圈为0->5，第二个数字2滚动两圈为0->9-0->2,第三个数字0滚动三圈为0-9-0-9-0 以此类推
 2、最大字体27，数字小于6位时，默认字体为27， 每增加三位，字号减一
 3、当数字太大导致按规则设置的字体显示不下时，字体依次减一，再重新准备视图
 4、只滚动数字，标点符号不滚动
 5、第一个数字滚动一圈，第二个数字滚动两圈，以此类推
 6、支持反向滚动 规则即最后一个数字滚动一圈，倒数第二个数字滚动两圈 以此类推
 7、所有数字的滚动时间都是一个固定的值 duration default 1.5秒
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BCMRollView : UIView

///> "52,000.00"
@property (nonatomic, copy) NSString *rollValue;
///> 规则2 default 27
@property (nonatomic, assign) CGFloat maxFontSize;
///> 规则6 是否支持反向滚动 default NO
@property (nonatomic, assign) BOOL isRevser;
///> 所有数字的滚动时长 default 1.5秒
@property (nonatomic, assign) NSTimeInterval duration;
///> 数字的颜色 default black
@property (nonatomic, strong) UIColor *textColor;

// 开始滚动动画
- (void)startAnimation;

@end

NS_ASSUME_NONNULL_END
