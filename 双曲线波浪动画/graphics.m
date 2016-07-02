//
//  graphics.m
//  双曲线波浪动画
//
//  Created by 王奥东 on 16/6/29.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "graphics.h"

@interface graphics()

//定时器,通过定时器改变浮动的变化幅度
@property (nonatomic,strong)NSTimer * myTimer;

//自身的frame
@property (nonatomic,assign) CGRect MYframe;

//一个能够让水流滚动的页面
@property (nonatomic,assign) CGFloat fa;

//浮动的最大值
@property (nonatomic,assign) CGFloat bigNumber;



@end

@implementation graphics

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        _MYframe = frame;
        self.backgroundColor = [UIColor whiteColor];
        UILabel * presentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //数值的显示居左
        presentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:presentLabel];
        self.presentlabel = presentLabel;
        self.presentlabel.font = [UIFont systemFontOfSize:15];
        
        
    }
    return self;
}

- (void)createTimer{
    
    if (!self.myTimer) {
        //水流浮动的幅度
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(action) userInfo:nil repeats:YES];
    }
//    [timer setFireDate:[NSDate date]]; //继续。
//    [timer setFireDate:[NSDate distantPast]];//开启
//    [timer setFireDate:[NSDate distantFuture]];//暂停
    [self.myTimer setFireDate:[NSDate distantPast]];
}
- (void)action{
    //让波浪移动效果
    _fa = _fa+10;
    if (_fa >= _MYframe.size.width * 2.0) {
        _fa = 0;
    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    //水的颜色
    UIColor * blue = [UIColor colorWithRed:0.2 green:0.2 blue:8 alpha:0.3];
    CGContextSetFillColorWithColor(context, [blue CGColor]);
    
    //线条，让颜色填充线条内的路径
    float y= (1 - self.present) * rect.size.height;
    float y1= (1 - self.present) * rect.size.height;
    
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x=0;x<=rect.size.width * 3.0;x++){
        //正弦函数
        y=  sin( x/rect.size.width * M_PI + _fa/rect.size.width *M_PI ) *_bigNumber + (1 - self.present) * rect.size.height ;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, rect.size.width , rect.size.height );
    CGPathAddLineToPoint(path, nil, 0, rect.size.height );
    // CGPathAddLineToPoint(path, nil, 0, 200);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    
    CGMutablePathRef path1 = CGPathCreateMutable();
    //  float y1=200;
    //画外层的水
    CGContextSetLineWidth(context, 1);
    UIColor * blue1 = [UIColor colorWithRed:0.2 green:0.2 blue:0.8 alpha:0.8];
    CGContextSetFillColorWithColor(context, [blue1 CGColor]);
    
    
    //  float y1= 200;
    CGPathMoveToPoint(path1, NULL, 0, y1);
    for(float x=0;x<=rect.size.width;x++){
        
        y1= sin( x/rect.size.width * M_PI + _fa/rect.size.width *M_PI  +M_PI ) *_bigNumber + (1 - self.present) * rect.size.height ;
        CGPathAddLineToPoint(path1, nil, x, y1);
    }
    
    CGPathAddLineToPoint(path1, nil, rect.size.height, rect.size.width );
    CGPathAddLineToPoint(path1, nil, 0, rect.size.height );
    //CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
    
    CGContextAddPath(context, path1);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path1);
    
    
    //添加文字
    NSString *str = [NSString stringWithFormat:@"%.2f%%",self.present * 100.0];
    self.presentlabel.text = str;
    
}


- (void)setPresent:(CGFloat)present{
    _present = present;
    //启动定时器
    [self createTimer];
    //修改波浪的幅度
    if (present <= 0.5) {
        _bigNumber = _MYframe.size.height * 0.1 * present * 2;
    }else{
        _bigNumber = _MYframe.size.height * 0.1 * (1 - present) * 2;
    }
}

@end
