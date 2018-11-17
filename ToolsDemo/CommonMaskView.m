//
//  CommonMaskView.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/18.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "CommonMaskView.h"

@interface CommonMaskView ()

@property(nonatomic,strong)UIView *hideView;

@property(nonatomic,strong)UIImageView *centerImageView;

@property(nonatomic,strong)UIButton *cancleBtn;

@end

@implementation CommonMaskView


-(UIView *)hideView{
    if (_hideView == nil) {
        _hideView = [[UIView alloc]init];
        _hideView.frame = self.bounds;
        _hideView.backgroundColor = [UIColor blackColor];
        _hideView.alpha = 0.3;
    }
    return _hideView;
}

-(UIImageView *)centerImageView{
    if (_centerImageView == nil) {
        _centerImageView = [[UIImageView alloc]init];
        //_centerImageView.contentMode = UIViewContentModeScaleAspectFit;
        _centerImageView.frame = CGRectMake(0, 0, 270, 250);
        _centerImageView.backgroundColor = [UIColor redColor];
        _centerImageView.center = self.center;
    }
    return _centerImageView;
}

-(UIButton *)cancleBtn{
    if (_cancleBtn == nil) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setImage:[UIImage imageNamed:@"X3"] forState:UIControlStateNormal];
        CGRect rect = _centerImageView.frame;
        _cancleBtn.frame = CGRectMake(self.center.x - 15, rect.origin.y + rect.size.height + 20, 30, 30);
        _cancleBtn.layer.cornerRadius = 15;
        _cancleBtn.layer.masksToBounds = YES;
        [_cancleBtn addTarget:self action:@selector(dimiss) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancleBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.hideView];
        
        [self addSubview:self.centerImageView];
        
        [self addSubview:self.cancleBtn];
        
    }
    
    return self;
}



-(void)show{
    
    if (self.imageType == 0) {
        
        self.centerImageView.image = [UIImage imageNamed:@"X3"];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}


-(void)dimiss{
    
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
