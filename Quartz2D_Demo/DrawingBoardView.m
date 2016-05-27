//
//  Quartz2DView.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "DrawingBoardView.h"

@implementation DrawingBoardView

- (NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

// 开始触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint startPoint = [touch locationInView:touch.view];
    
    // 3.当用户手指按下的时候创建一条路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 3.1设置路径的相关属性
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineWidth:10];
    
    
    // 4.设置当前路径的起点
    [path moveToPoint:startPoint];
    // 5.将路径添加到数组中
    [self.paths addObject:path];
}
// 移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint movePoint = [touch locationInView:touch.view];
    
    // 3.取出当前的path
    UIBezierPath *currentPaht = [self.paths lastObject];
    // 4.设置当前路径的终点
    [currentPaht addLineToPoint:movePoint];
    
    // 6.调用drawRect方法重回视图
    [self setNeedsDisplay];
    
}

// 离开view(停止触摸)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    /*
     // 1.获取手指对应UITouch对象
     UITouch *touch = [touches anyObject];
     // 2.通过UITouch对象获取手指触摸的位置
     CGPoint endPoint = [touch locationInView:touch.view];
     
     // 3.取出当前的path
     UIBezierPath *currentPaht = [self.paths lastObject];
     // 4.设置当前路径的终点
     [currentPaht addLineToPoint:endPoint];
     
     // 6.调用drawRect方法重回视图
     [self setNeedsDisplay];
     */
}

// 画线
- (void)drawRect:(CGRect)rect
{
    [[UIColor redColor] set];
    // 边路数组绘制所有的线段
    for (UIBezierPath *path in self.paths) {
        [path stroke];
    }
}


- (void)clearScreen
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)backScreen
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}











//- (void)drawRect:(CGRect)rect {
////    [self drawLine];
////    [self drawTriangle];
////    [self drawCircular];
//    [self drawRectgrange];
////    [self drawArc];
////    [self drawCake];
//}

// 画线
//- (void) drawLine {
//    // 1.取得和当前视图相关联的图形上下文(因为图形上下文决定绘制的输出目标)/
//    
//    // 如果是在drawRect方法中调用UIGraphicsGetCurrentContext方法获取出来的就是Layer的上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    // 2.绘图(绘制直线), 保存绘图信息
//    // 设置起点
//    CGContextMoveToPoint(ctx, 10, 100);
//    // 设置终点
//    CGContextAddLineToPoint(ctx, 100, 100);
//    
//    // 设置绘图状态
//    // 设置线条颜色 红色
//    CGContextSetRGBStrokeColor(ctx, 1.0, 0, 0, 1.0);
//    // 设置线条宽度
//    CGContextSetLineWidth(ctx, 10);
//    // 设置线条的起点和终点的样式
//    CGContextSetLineCap(ctx, kCGLineCapRound);
//    // 设置线条的转角的样式
//    CGContextSetLineJoin(ctx, kCGLineJoinRound);
//    // 绘制一条空心的线
//    CGContextStrokePath(ctx);
//    
//    /*------------------华丽的分割线---------------------*/
//    
//    // 重新设置第二条线的起点
//    CGContextMoveToPoint(ctx, 150, 200);
//    // 设置第二条直线的终点(自动把上一条直线的终点当做起点)
//    CGContextAddLineToPoint(ctx, 100, 50);
//    // 设置第二条线的颜色 绿色
//    //    [[UIColor greenColor] set];
//    CGContextSetRGBStrokeColor(ctx, 0, 1.0, 0, 1.0);
//    
//    // 绘制图形(渲染图形到view上)
//    // 绘制一条空心的线
//    CGContextStrokePath(ctx);
//}
//
//// 画三角形
//- (void) drawTriangle {
//    // 1.获取图形上下文
//    CGContextRef ctx =  UIGraphicsGetCurrentContext();
//    
//    // 2. 绘制三角形
//    // 设置起点
//    CGContextMoveToPoint(ctx, 100, 10);
//    // 设置第二个点
//    CGContextAddLineToPoint(ctx, 50, 100);
//    // 设置第三个点
//    CGContextAddLineToPoint(ctx, 150, 100);
//    // 设置终点
//    //    CGContextAddLineToPoint(ctx, 100, 10);
//    // 关闭起点和终点
//    CGContextClosePath(ctx);
//    // 3.渲染图形到layer上
//    CGContextStrokePath(ctx);
//}
//
//// 画圆
//- (void) drawCircular {
//    // 1.获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 2.画圆
//    CGContextAddEllipseInRect(ctx, CGRectMake(50, 100, 100, 100));
//    
//    [[UIColor greenColor] set];
//    
//    // 3.渲染
//    CGContextStrokePath(ctx);
////    CGContextFillPath(ctx);
//}
//
//// 矩形
//- (void) drawRectgrange {
//    // Drawing code
//    // 绘制四边形
//    // 1.获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 2.绘制四边形
//    CGContextAddRect(ctx, CGRectMake(50, 50, 150, 100));
//    
//    // 如果要设置绘图的状态必须在渲染之前
//    //    CGContextSetRGBStrokeColor(ctx, 1.0, 0, 0, 1.0);
//    // 绘制什么类型的图形(空心或者实心).就要通过什么类型的方法设置状态
//    //    CGContextSetRGBFillColor(ctx, 1.0, 0, 0, 1.0);
//    
//    // 调用OC的方法设置绘图的颜色
//    //    [[UIColor purpleColor] setFill];
//    //    [[UIColor blueColor] setStroke];
//    // 调用OC的方法设置绘图颜色(同时设置了实心和空心)
//    //    [[UIColor greenColor] set];
//    [[UIColor colorWithRed:1.0 green:0 blue:0 alpha:1.0] set];
//    
//    // 3.渲染图形到layer上
////    CGContextStrokePath(ctx);
//    CGContextFillPath(ctx);
//}
//
//// 圆弧
//- (void) drawArc {
//    // 画圆弧
//    // 1.获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 2.画圆弧
//    // x/y 圆心
//    // radius 半径
//    // startAngle 开始的弧度
//    // endAngle 结束的弧度
//    // clockwise 画圆弧的方向 (0 顺时针, 1 逆时针)
//    //    CGContextAddArc(ctx, 100, 100, 50, -M_PI_2, M_PI_2, 0);
//    CGContextAddArc(ctx, 100, 100, 50, M_PI_2, M_PI, 0);
//    CGContextClosePath(ctx);
//    
//    // 3.渲染
//    //     CGContextStrokePath(ctx);
//    CGContextFillPath(ctx);
//}
//
//// 饼图
//- (void) drawCake {
//    // 1.获取上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 2.画饼状图
//    // 画线
//    CGContextMoveToPoint(ctx, 100, 100);
//    CGContextAddLineToPoint(ctx, 100, 150);
//    // 画圆弧
//    CGContextAddArc(ctx, 100, 100, 50, M_PI_2, M_PI, 0);
//    //    CGContextAddArc(ctx, 100, 100, 50, -M_PI, M_PI_2, 1);
//    
//    // 关闭路径
//    CGContextClosePath(ctx);
//    
//    
//    // 3.渲染 (注意, 画线只能通过空心来画)
//    CGContextFillPath(ctx);
//    //    CGContextStrokePath(ctx);
//}
@end
