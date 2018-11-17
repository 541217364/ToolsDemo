//
//  ZLMaskView.h
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/15.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLMaskView : UIView
 /*
  * 滑动视图上边距
  */
@property(nonatomic,assign)CGFloat limitHeight;

 /*
  *   是否开始边界回弹  默认关
  */
@property(nonatomic)BOOL openBouce;

 /*
  *  内容视图
  */
@property(nonatomic,strong)UIView *contentView;

/*
 *  内容视图初始坐标
 */
@property(nonatomic)CGFloat contentView_y;

@end
