//
//  BCMRollView.m
//  RollLabel
//
//  Created by Kevin on 2019/7/27.
//  Copyright © 2019 LY. All rights reserved.
//

/**
 Layer 视图
----------------------------
 |0|
 |1|
 |2|
 |3|0|
 |4|1|
 -------------------
 |5|2|,|0|0|0|.|0|0|
 -------------------
 |6|3| |1|1|1| |1|1|
 |7|4| |2|2|2| |2|2|
 |8|5| |3|3|3| |3|3|
 |9|6| |4|4|4| |4|4|
 |0|7| |5|5|5| |5|5|
   |8| |6|6|6| |6|6|
   |9| |7|7|7| |7|7|
       |8|8|8| |8|8|
       |9|9|9| |9|9|
----------------------------
 */

#import "BCMRollView.h"
#import "NSString+Utils.h"

@interface BCMRollView ()

@property (nonatomic, copy) NSArray *layerBaseTexts;
@property (nonatomic, strong) NSMutableArray *scrollLayers;
@property (nonatomic, strong) NSMutableArray *scrollLabels;

@end

@implementation BCMRollView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self initDefaultValue];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self initDefaultValue];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self initDefaultValue];
    
    return self;
}

- (void)initDefaultValue {
    self.duration = 1.5;
    self.isRevser = NO;
    self.maxFontSize = 27;
    self.textColor = [UIColor blackColor];
    
    self.scrollLayers = [NSMutableArray array];
    self.scrollLabels = [NSMutableArray array];
    self.layerBaseTexts = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0"];
}

- (void)setRollValue:(NSString *)rollValue {
    self->_rollValue = rollValue;
    
    if (!_rollValue||[_rollValue isEqualToString:@""]) {
        return;
    }
    
    [self recaluFontSize];
    
    [self prepareAnimationViews];
}

- (void)startAnimation {
    if (!self.rollValue||[self.rollValue isEqualToString:@""]) {
        return;
    }
    
    [self prepareAnimationViews];
    [self commitAnimation];
}

- (void)prepareAnimationViews {
    
    for(CALayer *layer in _scrollLayers){
        [layer removeFromSuperlayer];
    }
    
    [_scrollLabels removeAllObjects];
    [_scrollLayers removeAllObjects];

    [self createScrollLayer];
}

///> 重新根据需要规则2计算显示的字体大小
- (void)recaluFontSize {
    NSInteger length = self.rollValue.length - 6;
    if (length > 0) {
        _maxFontSize = _maxFontSize - ceil(length/3.0);
    }
}

- (void)createScrollLayer {
    NSInteger length = self.rollValue.length;
    CGFloat leftX = 0;
    CGFloat height = CGRectGetHeight(self.frame);
    for (NSInteger i = 0; i < length; i++) {
        NSString *text = [self.rollValue substringWithRange:NSMakeRange(i, 1)];
        CGFloat width = [text widthForSelf:_maxFontSize];
        CAScrollLayer *scrollLayer = [CAScrollLayer layer];
        [scrollLayer setFrame:CGRectMake(leftX, 0, width, height)];
        leftX = CGRectGetMaxX(scrollLayer.frame);
        [self.layer addSublayer:scrollLayer];
        scrollLayer.backgroundColor = [UIColor redColor].CGColor;
        [_scrollLayers addObject:scrollLayer];
    }
    
    CGFloat maxOriginX = CGRectGetMaxX([[_scrollLayers lastObject] frame]);
    CGFloat selfMaxOriginX = CGRectGetMaxX(self.frame);
    if (maxOriginX > selfMaxOriginX) {
        _maxFontSize -= 1;
        [self prepareAnimationViews];
        return;
    }
    
    for (NSInteger i = 0; i < _scrollLayers.count; i++) {
        CAScrollLayer *scrollLayer = [_scrollLayers objectAtIndex:i];
        NSString *text = [_rollValue substringWithRange:NSMakeRange(i, 1)];
        [self createContentForEveryScrollLayer:scrollLayer withText:text];
    }
    
}

- (void)createContentForEveryScrollLayer:(CAScrollLayer *)scrollLayer withText:(NSString *)text {
    CGFloat height = CGRectGetHeight(scrollLayer.frame);
    NSInteger textInt = [text integerValue];
    
    if (![text isNumber]) {
        CGFloat width = CGRectGetWidth(scrollLayer.frame);
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.textColor;
        label.font = [UIFont systemFontOfSize:self.maxFontSize];
        label.text = text;
        [label setFrame:CGRectMake(0, 0, width, height)];
        [scrollLayer addSublayer:label.layer];
        [_scrollLabels addObject:label];
        
        return;
    }
    
    CGFloat originY = -1*textInt*height;
    for (NSInteger i = 0; i < _layerBaseTexts.count; i++) {
        NSString *text = _layerBaseTexts[i];
        CGFloat width = CGRectGetWidth(scrollLayer.frame);
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.textColor;
        label.font = [UIFont systemFontOfSize:self.maxFontSize];
        label.text = text;
        [label setFrame:CGRectMake(0, originY, width, height)];
        originY = CGRectGetMaxY(label.frame);
        [scrollLayer addSublayer:label.layer];
        [_scrollLabels addObject:label];
    }
}

- (void)commitAnimation {
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray<NSNumber *> *keyTimes = [NSMutableArray array];
    NSMutableArray<CAMediaTimingFunction *> *timingFunctions = [NSMutableArray array];
    CGFloat durationOffset = 0.2;
    for (NSInteger i = 0; i < _scrollLayers.count; i++) {
        NSString *text = [_rollValue substringWithRange:NSMakeRange(i, 1)];
        CAScrollLayer *scrollLayer = [_scrollLayers objectAtIndex:i];
        if (self.isRevser) {
            text = [_rollValue substringWithRange:NSMakeRange(_scrollLayers.count-i-1, 1)];
            scrollLayer = [_scrollLayers objectAtIndex:(_scrollLayers.count-i-1)];
        }
        if (![text isNumber]) {
            continue;
        }
        
        @autoreleasepool {
            [values removeAllObjects];
            [keyTimes removeAllObjects];
            [timingFunctions removeAllObjects];
            
            NSInteger textInt = [text integerValue];
            
            
            if (self.isRevser) {
                
            }
            CGFloat minY = -[[scrollLayer.sublayers firstObject] frame].origin.y;
            CGFloat maxY = -[[scrollLayer.sublayers lastObject] frame].origin.y;
            CGFloat targetY = 0;
            
            [values addObject:[NSNumber numberWithFloat:minY]];
            [keyTimes addObject:@(0)];
            
            double timeSpace = (double)(1.0/(_layerBaseTexts.count*i + textInt));
            
            for (NSInteger index = 0; index < i; index++) {
                @autoreleasepool {
                    [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];

                    [values addObject:[NSNumber numberWithFloat:maxY]];
                    [values addObject:[NSNumber numberWithFloat:minY]];
                    
                    [keyTimes addObject:[NSNumber numberWithDouble:(index+1)*timeSpace * _layerBaseTexts.count]];
                    [keyTimes addObject:[NSNumber numberWithDouble:(index+1)*timeSpace * _layerBaseTexts.count]];
                    
                    [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                }
            }
            
            [values addObject:[NSNumber numberWithFloat:targetY]];
            [keyTimes addObject:@(1)];
            [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            
            CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
            keyFrameAnimation.duration = self.duration + durationOffset*i;
            keyFrameAnimation.values = values;
            keyFrameAnimation.keyTimes = keyTimes;
            keyFrameAnimation.timingFunctions = timingFunctions;
            keyFrameAnimation.removedOnCompletion = NO;
            
            [scrollLayer addAnimation:keyFrameAnimation forKey:@"BCMRollView"];
        }
    }
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
