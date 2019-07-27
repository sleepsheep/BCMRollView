//
//  ViewController.m
//  BCMRollView
//
//  Created by Kevin on 2019/7/27.
//  Copyright © 2019 LY. All rights reserved.
//

#import "ViewController.h"
#import "BCMRollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Demo 1 default 正向
    BCMRollView *rollView1 = [[BCMRollView alloc] initWithFrame:CGRectMake(10, 100, 200, 40)];
    rollView1.backgroundColor = [UIColor orangeColor];
    rollView1.tag = 100;
    [self.view addSubview:rollView1];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [rollView1 setRollValue:@"654,00"];
    });
    
    // Demo2 反向
    BCMRollView *rollView2 = [[BCMRollView alloc] initWithFrame:CGRectMake(10, 150, 200, 40)];
    rollView2.backgroundColor = [UIColor orangeColor];
    rollView2.tag = 101;
    rollView2.isRevser = YES;
    [self.view addSubview:rollView2];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [rollView2 setRollValue:@"654,300"];
    });
    
    // Demo3 数字字数大于6位 字号递减
    BCMRollView *rollView3 = [[BCMRollView alloc] initWithFrame:CGRectMake(10, 200, 200, 40)];
    rollView3.backgroundColor = [UIColor orangeColor];
    rollView3.tag = 102;
    [self.view addSubview:rollView3];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [rollView3 setRollValue:@"654,321.00"];
    });
    
    // Demo4 数字过大，按照字号递减规则，视图无法容纳时，字号递减尝试
    BCMRollView *rollView4 = [[BCMRollView alloc] initWithFrame:CGRectMake(10, 250, 200, 40)];
    rollView4.backgroundColor = [UIColor orangeColor];
    rollView4.tag = 103;
    [self.view addSubview:rollView4];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [rollView4 setRollValue:@"654,321,000,000,000,000.00"];
    });
    
    // Demo5 纯数字
    BCMRollView *rollView5 = [[BCMRollView alloc] initWithFrame:CGRectMake(10, 300, 200, 40)];
    rollView5.backgroundColor = [UIColor orangeColor];
    rollView5.tag = 104;
    [self.view addSubview:rollView5];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [rollView5 setRollValue:@"9876543210"];
    });
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BCMRollView *rollView1 = [self.view viewWithTag:100];
    [rollView1 startAnimation];
    
    BCMRollView *rollView2 = [self.view viewWithTag:101];
    [rollView2 startAnimation];
    
    BCMRollView *rollView3 = [self.view viewWithTag:102];
    [rollView3 startAnimation];
    
    BCMRollView *rollView4 = [self.view viewWithTag:103];
    [rollView4 startAnimation];
    
    BCMRollView *rollView5 = [self.view viewWithTag:104];
    [rollView5 startAnimation];
    
    
}

@end
