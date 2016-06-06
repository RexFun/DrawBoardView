//
//  Quartz2DView.m
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import "DrawBoard.h"

@implementation DGPen
@end

@implementation DGLine
@end

@implementation DGCircular
@end

@implementation DGRectangle
@end

@implementation DrawBoard

- (NSMutableArray *)pens
{
    if (_pens == nil) {
        _pens = [NSMutableArray array];
    }
    return _pens;
}
- (NSMutableArray *)lines
{
    if (_lines == nil) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}
- (NSMutableArray *)circulars
{
    if (_circulars == nil) {
        _circulars = [NSMutableArray array];
    }
    return _circulars;
}
- (NSMutableArray *)rectangles
{
    if (_rectangles == nil) {
        _rectangles = [NSMutableArray array];
    }
    return _rectangles;
}
- (NSMutableArray *)graphs
{
    if (_graphs == nil) {
        _graphs = [NSMutableArray array];
    }
    return _graphs;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _lineWidth = 3;
        _strokeColor = [UIColor redColor];
    }
    return self;
}

// 触摸-开始
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch (_drawType)
    {
        case T_PEN:[self touchesBeganPen:touches withEvent:event];break;
        case T_LINE:[self touchesBeganLine:touches withEvent:event];break;
        case T_CIRCULAR:[self touchesBeganCircular:touches withEvent:event];break;
        case T_RECT:[self touchesBeganRectangle:touches withEvent:event];break;
        default:break;
    }
}
// 触摸-移动
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    switch (_drawType)
    {
        case T_PEN:[self touchesMovedPen:touches withEvent:event];break;
        case T_LINE:[self touchesMovedLine:touches withEvent:event];break;
        case T_CIRCULAR:[self touchesMovedCircular:touches withEvent:event];break;
        case T_RECT:[self touchesMovedRectangle:touches withEvent:event];break;
        default:break;
    }
}

// 离开view(停止触摸)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

// 重绘
- (void)drawRect:(CGRect)rect
{
    // 获取上下文
    _ctx = UIGraphicsGetCurrentContext();
    // 设置线条的起点和终点的样式
    CGContextSetLineCap(_ctx, kCGLineCapRound);
    // 设置线条的转角的样式
    CGContextSetLineJoin(_ctx, kCGLineJoinRound);
    // 遍历重绘
    for (id obj in self.graphs)
    {
        if([obj isMemberOfClass:[DGPen class]])
        {
            [self drawPen:(DGPen *)obj];
        }
        else if([obj isMemberOfClass:[DGLine class]])
        {
            [self drawLine:(DGLine *)obj];
            
        }
        else if([obj isMemberOfClass:[DGCircular class]])
        {
            [self drawCircular:(DGCircular *)obj];
            
        }
        else if([obj isMemberOfClass:[DGRectangle class]])
        {
            [self drawRectangle:(DGRectangle *)obj];
        }
    }
    
}

// 画笔-触摸-开始
- (void)touchesBeganPen:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint startPoint = [touch locationInView:touch.view];
    // 3.当用户手指按下的时候创建一条路径
    _pen = [[DGPen alloc]init];
    _pen.path = [UIBezierPath bezierPath];
    // 4.设置当前路径的起点
    [_pen.path moveToPoint:startPoint];
    // 5.将路径添加到数组中
    [self.pens addObject:_pen];
    // 6.调用drawRect方法重回视图
    [self setNeedsDisplay];
    // 7.将路径添加到图形数组中
    [self.graphs addObject:_pen];
}

// 画笔-触摸-移动
- (void)touchesMovedPen:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint movePoint = [touch locationInView:touch.view];
    // 3.取出当前的path
    DGPen* curPen = [self.pens lastObject];
    // 4.设置当前路径的终点
    [curPen.path addLineToPoint:movePoint];
    // 5.调用drawRect方法重回视图
    [self setNeedsDisplay];
}

// 画直线-触摸-开始
- (void)touchesBeganLine:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint startPoint = [touch locationInView:touch.view];
    // 3.获取起点坐标
    _line = [[DGLine alloc]init];
    _line.begin_x = startPoint.x;
    _line.begin_y = startPoint.y;
    [self.lines addObject:_line];
    // 4.将直线对象添加到图形数组中
    [self.graphs addObject:_line];
}

// 画直线-触摸-移动
- (void)touchesMovedLine:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint movePoint = [touch locationInView:touch.view];
    // 3.计算终点坐标
    _line.end_x = movePoint.x;
    _line.end_y = movePoint.y;
    // 4.重绘
    [self setNeedsDisplay];
}

// 画圆-触摸-开始
- (void)touchesBeganCircular:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint startPoint = [touch locationInView:touch.view];
    // 3.获取原点坐标
    _circular = [[DGCircular alloc]init];
    _circular.x = startPoint.x;
    _circular.y = startPoint.y;
    [self.circulars addObject:_circular];
    // 4.将圆对象添加到图形数组中
    [self.graphs addObject:_circular];
}

// 画圆-触摸-移动
- (void)touchesMovedCircular:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint movePoint = [touch locationInView:touch.view];
    // 3.计算宽高
    _circular.w = movePoint.x - _circular.x;
    _circular.h = movePoint.y - _circular.y;
    // 4.重绘
    [self setNeedsDisplay];
}

// 画矩形-触摸-开始
- (void)touchesBeganRectangle:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint startPoint = [touch locationInView:touch.view];
    // 3.获取原点坐标
    _rectangle = [[DGRectangle alloc]init];
    _rectangle.x = startPoint.x;
    _rectangle.y = startPoint.y;
    [self.rectangles addObject:_rectangle];
    // 4.将矩形对象添加到图形数组中
    [self.graphs addObject:_rectangle];
}

// 画矩形-触摸-移动
- (void)touchesMovedRectangle:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint movePoint = [touch locationInView:touch.view];
    // 3.计算宽高
    _rectangle.w = movePoint.x - _rectangle.x;
    _rectangle.h = movePoint.y - _rectangle.y;
    // 4.重绘
    [self setNeedsDisplay];
}

// 重绘-画笔
- (void)drawPen:(DGPen *)p
{
    // 设置对象的线条颜色和宽度
    if (p.lineWidth == 0)     p.lineWidth   = _lineWidth;
    if (p.strokeColor == nil) p.strokeColor = _strokeColor;
    // 设置线条颜色
    CGContextSetStrokeColorWithColor(_ctx, [p.strokeColor CGColor]);
    // 设置线条宽度
    [p.path setLineWidth:p.lineWidth];
    // 设置线条的起点和终点的样式
    [p.path setLineCapStyle:kCGLineCapRound];
    // 设置线条的转角的样式
    [p.path setLineJoinStyle:kCGLineJoinRound];
    // 绘制
    [p.path stroke];
}

// 重绘-画直线
- (void)drawLine:(DGLine *)l
{
    // 设置对象的线条颜色和宽度
    if (l.lineWidth == 0)     l.lineWidth   = _lineWidth;
    if (l.strokeColor == nil) l.strokeColor = _strokeColor;
    // 设置线条颜色
    CGContextSetStrokeColorWithColor(_ctx, [l.strokeColor CGColor]);
    // 设置线条宽度
    CGContextSetLineWidth(_ctx, l.lineWidth);
    
    // 1.设置起点、终点
    CGContextMoveToPoint(_ctx, l.begin_x, l.begin_y);
    CGContextAddLineToPoint(_ctx, l.end_x, l.end_y);
    // 2.绘制
    CGContextStrokePath(_ctx);
}

// 重绘-画圆
- (void)drawCircular:(DGCircular *)c
{
    // 设置对象的线条颜色和宽度
    if (c.lineWidth == 0)     c.lineWidth   = _lineWidth;
    if (c.strokeColor == nil) c.strokeColor = _strokeColor;
    // 设置线条颜色
    CGContextSetStrokeColorWithColor(_ctx, [c.strokeColor CGColor]);
    // 设置线条宽度
    CGContextSetLineWidth(_ctx, c.lineWidth);
    
    // 1.画圆
    CGContextAddEllipseInRect(_ctx, CGRectMake(c.x, c.y, c.w, c.h));
    // 2.绘制
    CGContextStrokePath(_ctx);
}

// 重绘-画矩形
- (void)drawRectangle:(DGRectangle *)r
{
    // 设置对象的线条颜色和宽度
    if (r.lineWidth == 0)     r.lineWidth   = _lineWidth;
    if (r.strokeColor == nil) r.strokeColor = _strokeColor;
    // 设置线条颜色
    CGContextSetStrokeColorWithColor(_ctx, [r.strokeColor CGColor]);
    // 设置线条宽度
    CGContextSetLineWidth(_ctx, r.lineWidth);
    
    // 1.绘制四边形
    CGContextAddRect(_ctx, CGRectMake(r.x, r.y, r.w, r.h));
    // 2.绘制
    CGContextStrokePath(_ctx);
}

// 清屏
- (void)clear
{
    [_pens removeAllObjects];
    [_lines removeAllObjects];
    [_circulars removeAllObjects];
    [_rectangles removeAllObjects];
    [_graphs removeAllObjects];
    [self setNeedsDisplay];
}

// 撤销
- (void)back
{
    [_pens removeLastObject];
    [_lines removeLastObject];
    [_circulars removeLastObject];
    [_rectangles removeLastObject];
    [_graphs removeLastObject];
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
