//
//  Quartz2DView.h
//  Quartz2D_Demo
//
//  Created by mac373 on 16/5/27.
//  Copyright © 2016年 ole. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 画图类型 */
typedef NS_ENUM(uint, DrawType)
{
    T_LINE,
    T_CIRCULAR,
    T_RECT
};

/* 圆形 */
@interface DGCircular : NSObject
@property CGFloat x;
@property CGFloat y;
@property CGFloat r;
@end

/* 矩形 */
@interface DGRectangle : NSObject
@property CGFloat x;
@property CGFloat y;
@property CGFloat w;
@property CGFloat h;
@end

/* 画板 */
@interface DrawBoard : UIView
@property DrawType drawType;                            //当前画图类型
@property (nonatomic,strong)NSMutableArray* paths;      //直线路径数组
@property (nonatomic,strong)NSMutableArray* circulars;  //圆数组
@property (nonatomic,strong)NSMutableArray* rectangles; //矩形数组
@property (nonatomic,strong)NSMutableArray* graphs;     //全部图形数组
@property DGCircular* circular;                         //圆形对象
@property DGRectangle* rectangle;                       //矩形对象

-(void)clear;
-(void)back;
@end
