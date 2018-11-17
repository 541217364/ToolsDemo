//
//  ShareViewController.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/22.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "ShareViewController.h"

#define WeakSelf __weak typeof (self)weakself = self

@interface ShareViewController ()

@property(nonatomic,strong)UIScrollView *myScrollView;

@property(nonatomic,strong)UILabel *topLable;

@property(nonatomic,strong)UIImageView *centerView;

@property(nonatomic,strong)UILabel *moreTypeLable;

@property(nonatomic,strong)UIButton *weixinBtn;

@property(nonatomic,strong)UIButton *QQBtn;

@property(nonatomic,strong)UIButton *weiboBtn;

@property(nonatomic,strong)UILabel *weixinLable;

@property(nonatomic,strong)UILabel *QQLable;

@property(nonatomic,strong)UILabel *weiboLable;

@property(nonatomic,strong)UIView *bottomView;

@property(nonatomic,strong)UIImageView *shareImageView;

@property(nonatomic,strong)UILabel *sharelable;

@property(nonatomic,strong)UILabel *shareIDlable;

@property(nonatomic,strong)UIImageView *VIPImageView;

@property(nonatomic,strong)UIImageView *codeImageView;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
}



-(void)setUI{
    
    [self.view addSubview:self.myScrollView];
    
    [self.myScrollView addSubview:self.topLable];
    [self.myScrollView addSubview:self.centerView];
    [self.myScrollView addSubview:self.moreTypeLable];
    [self.myScrollView addSubview:self.weixinBtn];
    [self.myScrollView addSubview:self.QQBtn];
    [self.myScrollView addSubview:self.weiboBtn];
    [self.myScrollView addSubview:self.QQLable];
    [self.myScrollView addSubview:self.weiboLable];
    [self.myScrollView addSubview:self.weixinLable];
    [self.myScrollView addSubview:self.bottomView];
    
    
    WeakSelf;
    [self.myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.left.right.mas_equalTo(0);
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(230, 280));
        make.top.mas_equalTo(weakself.topLable.mas_bottom).offset(30);
        make.centerX.mas_equalTo(0);
    }];
    
    [self.moreTypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakself.centerView.mas_bottom).offset(30);
        make.height.mas_equalTo(16);
        make.left.right.mas_equalTo(0);
    }];
    
    [self.QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakself.moreTypeLable.mas_bottom).offset(30);
    }];
    
    [self.weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(weakself.centerView);
        make.top.mas_equalTo(weakself.QQBtn);
    }];
    
    [self.weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(weakself.centerView);
        make.top.mas_equalTo(weakself.QQBtn);
    }];
    
    [self.QQLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 10));
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakself.QQBtn.mas_bottom).offset(10);
    }];
    
    [self.weixinLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 10));
        make.centerX.mas_equalTo(weakself.weixinBtn);
        make.top.mas_equalTo(weakself.QQLable);
    }];
    
    [self.weiboLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 10));
        make.centerX.mas_equalTo(weakself.weiboBtn);
        make.top.mas_equalTo(weakself.QQLable);
    }];
    
    

    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.QQLable.mas_bottom).offset(40);
        make.left.mas_equalTo(weakself.centerView.mas_left).offset(-20);
        make.right.mas_equalTo(weakself.centerView.mas_right).offset(20);
        make.height.mas_equalTo(100);
        
    }];
    
}



-(UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc]init];
        _myScrollView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    }
    return _myScrollView;
}

-(UILabel *)topLable{
    if (_topLable == nil) {
        _topLable = [[UILabel alloc]init];
        _topLable.text = @"天天邀请 赚分润金";
        _topLable.font = [UIFont fontWithName:@"Helvetica" size:30];
        _topLable.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
        _topLable.textAlignment = NSTextAlignmentCenter;
    }
    return _topLable;
}

-(UIImageView *)centerView{
    if (_centerView == nil) {
        _centerView = [[UIImageView alloc]init];
        _centerView.image = [UIImage imageNamed:@"组 3"];
        [self designCenterView];
    }
    return _centerView;
}


-(UILabel *)moreTypeLable{
    if (_moreTypeLable == nil) {
        _moreTypeLable = [[UILabel alloc]init];
        _moreTypeLable.text = @"更多分享方式";
        _moreTypeLable.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        _moreTypeLable.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
        _moreTypeLable.textAlignment = NSTextAlignmentCenter;
    }
    return _moreTypeLable;
}

-(UIButton *)weixinBtn{
    if (_weixinBtn == nil) {
        _weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weixinBtn.layer.cornerRadius = 20.0f;
        _weixinBtn.layer.masksToBounds = YES;
        [_weixinBtn setImage:[UIImage imageNamed:@"微信 拷贝"] forState:UIControlStateNormal];
        _weixinBtn.tag = 2001;
        [_weixinBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _weixinBtn;
}

-(UIButton *)QQBtn{
    if (_QQBtn == nil) {
        _QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _QQBtn.layer.cornerRadius = 20.0f;
        _QQBtn.layer.masksToBounds = YES;
        [_QQBtn setImage:[UIImage imageNamed:@"qq 拷贝"] forState:UIControlStateNormal];
        _QQBtn.tag = 2002;
        [_QQBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _QQBtn;
}

-(UIButton *)weiboBtn{
    if (_weiboBtn == nil) {
        _weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weiboBtn.layer.cornerRadius = 20.0f;
        _weiboBtn.layer.masksToBounds = YES;
        [_weiboBtn setImage:[UIImage imageNamed:@"微博 (1) 拷贝"] forState:UIControlStateNormal];
        _weiboBtn.tag = 2003;
        [_weiboBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _weiboBtn;
}

-(UILabel *)weixinLable{
    if (_weixinLable == nil) {
        _weixinLable = [[UILabel alloc]init];
        _weixinLable.text = @"微信分享";
        _weixinLable.textAlignment = NSTextAlignmentCenter;
        _weixinLable.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _weixinLable.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    }
    return _weixinLable;
}

-(UILabel *)QQLable{
    if (_QQLable == nil) {
        _QQLable = [[UILabel alloc]init];
        _QQLable.text = @"QQ分享";
        _QQLable.textAlignment = NSTextAlignmentCenter;
        _QQLable.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _QQLable.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    }
    return _QQLable;
}

-(UILabel *)weiboLable{
    if (_weiboLable == nil) {
        _weiboLable = [[UILabel alloc]init];
        _weiboLable.text = @"微博分享";
        _weiboLable.textAlignment = NSTextAlignmentCenter;
        _weiboLable.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _weiboLable.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    }
    return _weiboLable;
}

-(UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        [self designBottomView];
    }
    return _bottomView;
}



-(void)designBottomView{
    
    NSArray *descArray = @[@"发送邀请链接给好友",@"好友通过链接下载APP",@"好友完成任务可获奖励"];
    for (int i = 0; i < 3; i ++) {
        
        UILabel *label = [[UILabel alloc]init];
        label.layer.cornerRadius = 20.0f;
        label.layer.masksToBounds = YES;
        label.backgroundColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"0%d",i + 1];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor colorWithRed:49/255.0 green:195/255.0 blue:124/255.0 alpha:1];
        
        [_bottomView addSubview:label];
        
        if (i == 0) {
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
            
        }
        
        if (i == 1) {
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
        }
        
        if (i == 2) {
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
        }
        
        
        if (i != 2) {
            
            UIImageView *desImageV = [[UIImageView alloc]init];
            desImageV.image = [UIImage imageNamed:@"返回 拷贝"];
            [_bottomView addSubview:desImageV];
            
            [desImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(label);
                make.left.mas_equalTo(label.mas_right).offset(20);
                make.size.mas_equalTo(CGSizeMake(18, 18));
            }];
        }
        
        UILabel *desclabel = [[UILabel alloc]init];
        desclabel.text = descArray[i];
        desclabel.textAlignment = NSTextAlignmentCenter;
        desclabel.font = [UIFont systemFontOfSize:12];
        desclabel.numberOfLines = 0;
        desclabel.textColor = [UIColor colorWithRed:49/255.0 green:195/255.0 blue:124/255.0 alpha:1];
        
        [_bottomView addSubview:desclabel];
        [desclabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_bottom).offset(10);
            make.centerX.mas_equalTo(label);
            make.bottom.mas_equalTo(-20);
            make.width.mas_equalTo(70);
        }];
        
        
        
    }
    
}

-(UIImageView *)shareImageView{
    if (_shareImageView == nil) {
        _shareImageView = [[UIImageView alloc]init];
        _shareImageView.layer.cornerRadius = 15.0f;
        _shareImageView.layer.masksToBounds = YES;
        _shareImageView.backgroundColor = [UIColor redColor];
    }
    return _shareImageView;
}

-(UILabel *)sharelable{
    if (_sharelable == nil) {
        _sharelable = [[UILabel alloc]init];
        _sharelable.text = @"张三疯";
        _sharelable.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    }
    return _sharelable;
}

-(UILabel *)shareIDlable{
    if (_shareIDlable == nil) {
        _shareIDlable = [[UILabel alloc]init];
        _shareIDlable.text = @"ID:2168957";
        _shareIDlable.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _shareIDlable.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
    }
    return _shareIDlable;
}

-(UIImageView *)codeImageView{
    if (_codeImageView == nil) {
        _codeImageView = [[UIImageView alloc]init];
        _codeImageView.backgroundColor = [UIColor redColor];
    }
    return _codeImageView;
}



-(UIImageView *)VIPImageView{
    if (_VIPImageView == nil) {
        _VIPImageView = [[UIImageView alloc]init];
        _VIPImageView.backgroundColor = [UIColor redColor];
    }
    return _VIPImageView;
}

-(void)designCenterView{
    
    [_centerView addSubview:self.shareImageView];
    [_centerView addSubview:self.sharelable];
    [_centerView addSubview:self.shareIDlable];
    [_centerView addSubview:self.codeImageView];
    [_centerView addSubview:self.VIPImageView];
    WeakSelf;
    [self.shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.sharelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.shareImageView.mas_right).offset(10);
        make.top.mas_equalTo(weakself.shareImageView);
        make.height.mas_equalTo(15);
    }];
    
    [self.shareIDlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.sharelable);
        make.bottom.mas_equalTo(weakself.shareImageView);
        make.height.mas_equalTo(10);
    }];
    
    [self.VIPImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.shareIDlable.mas_right).offset(10);
        make.centerY.mas_equalTo(weakself.sharelable);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
   
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-30);
        make.size.mas_equalTo(CGSizeMake(170, 170));
    }];
   
    
    
}

-(void)clickLogin:(UIButton *)sender{
    
    if (sender.tag == 2001) {
        NSLog(@"微信分享");
    }
    
    if (sender.tag == 2002) {
        NSLog(@"QQ分享");
    }
    
    if (sender.tag == 2003) {
        NSLog(@"微博分享");
    }
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if (self.bottomView.frame.origin.y + self.bottomView.frame.size.height > self.myScrollView.frame.size.height -88) {
        [self.myScrollView setContentSize:CGSizeMake(0, self.bottomView.frame.origin.y + self.bottomView.frame.size.height)];
    }
    
}
@end
