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

// Delegate Setter
- (void)setDelegate:(id <DrawBoardDelegate>)_delegate
{
    delegate = _delegate;
}
// Delegate Getter
- (id <DrawBoardDelegate>)delegate
{
    return delegate;
}

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

// 保存
-(void)save
{
    //开始图像绘制上下文
    UIGraphicsBeginImageContext(self.bounds.size);
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
    
    //获取绘制的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束图像绘制上下文
    UIGraphicsEndImageContext();
    
    //保存图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil;
    if(error)
    {
        msg = @"图片保存失败!";
    }
    else
    {
        msg = @"图片保存成功!";
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma marks -- UIAlertViewDelegate --
//AlertView已经消失时执行的事件
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.delegate afterSave];
}
@end
