//
//  ViewController.m
//  双曲线波浪动画
//
//  Created by 王奥东 on 16/6/29.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "graphics.h"

@interface ViewController ()
@property(nonatomic,strong)graphics *graphicsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    //创建一个浮动的View
    graphics *graph = [[graphics alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    //设置浮动的初始值
    graph.present = 0.5;
    //设置圆形界面减去多余的界面
    graph.layer.cornerRadius = graph.frame.size.width/2;
    graph.layer.masksToBounds = YES;
    //绘制边框
    graph.layer.borderColor = [UIColor greenColor].CGColor;
    graph.layer.borderWidth = 5;
    //保存并添加浮动界面
    self.graphicsView = graph;
    [self.view addSubview:graph];
    
    //设置一个slider动态改变浮动的数值
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 40, 300, 20)];
    // 设置最小值
    slider.minimumValue = 0;
    // 设置最大值
    slider.maximumValue = 100;
    // 设置初始值
    slider.value = (slider.minimumValue + slider.maximumValue) / 2;
    // 设置可连续变化
    slider.continuous = YES;
    //设置slider的滑动事件，动态改变值
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    [self.view addSubview:slider];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)sliderValueChanged:(id)sender {
    
    //获取slider，并设置浮动的值
    UISlider *slider = (UISlider *)sender;
    self.graphicsView.present = slider.value/100.0;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
