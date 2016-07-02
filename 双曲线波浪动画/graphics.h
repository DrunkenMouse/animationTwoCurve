//
//  graphics.h
//  双曲线波浪动画
//
//  Created by 王奥东 on 16/6/29.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface graphics : UIView
//浮动的值
@property (nonatomic,assign)CGFloat present;
//显示浮动的值
@property (nonatomic,strong)UILabel * presentlabel;
//绘制的范围
- (instancetype)initWithFrame:(CGRect)frame;

@end
