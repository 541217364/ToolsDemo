//
//  ZLMaskView.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/15.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "ZLMaskView.h"

#define S_Width [UIScreen mainScreen].bounds.size.width
#define S_Height [UIScreen mainScreen].bounds.size.height

@interface ZLMaskView ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIView *hideView;

@property(nonatomic,strong)UIScrollView *contentScrollView;

@end

@implementation ZLMaskView




-(UIView *)hideView{
    
    if (_hideView == nil) {
        _hideView = [[UIView alloc]init];
        _hideView.frame = self.bounds;
        _hideView.backgroundColor = [UIColor grayColor];
        _hideView.alpha = 0.3;
    }
    return _hideView;
}

-(UIScrollView *)contentScrollView{
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc]init];
        _contentScrollView.frame = self.bounds;
    }
    return _contentScrollView;
}

-(UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.frame = CGRectMake(0, S_Height / 2, self.frame.size.width, self.frame.size.height);
        _contentView.backgroundColor = [UIColor redColor];
        _contentView.tag = 2000;
    }
    return _contentView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.hideView];
        [self addSubview:self.contentScrollView];
        [self.contentScrollView addSubview:self.contentView];
        [self addTapGes];
    }
    return self;
}



#pragma mark 返回手势

-(void)addTapGes{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(retuenTopView)];
    tap.delegate =self;
    [self.contentScrollView addGestureRecognizer:tap];
    
}

-(void)retuenTopView{
    
    for (UIView *tempV in self.subviews) {
        
        [tempV removeFromSuperview];
    }
    
    [self removeFromSuperview];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.contentView_y > 0) {
        
        CGRect rect  = self.contentView.frame;
        self.contentView.frame = CGRectMake(rect.origin.x, self.contentView_y, rect.size.width, rect.size.height);
        
    }
    
    
    if(self.limitHeight > 0) {
    [self.contentScrollView setContentSize:CGSizeMake(0, self.contentView.frame.origin.y + self.contentView.frame.size.height -self.limitHeight)];
    }else{
        
       [self.contentScrollView setContentSize:CGSizeMake(0, self.contentView.frame.origin.y + self.contentView.frame.size.height)];
    }
    
    self.contentScrollView.bounces = self.openBouce;
    
 
}

#pragma mark - UIGestureRecognizerDelegate 手势冲突问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}


@end
