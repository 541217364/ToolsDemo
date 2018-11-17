
//
//  CustomViewController.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/23.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "CustomViewController.h"
#import "Masonry.h"
#define WeakSelf __weak typeof (self)weakself = self
@interface CustomViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *myScrollView;

@property(nonatomic,strong)UIView *contenView;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UITableView *mytableView;

@end

@implementation CustomViewController


-(UIScrollView *)myScrollView{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc]init];
        _myScrollView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        _myScrollView.delegate = self;
    }
    return _myScrollView;
}

-(UIView *)contenView{
    if (_contenView == nil) {
        _contenView = [[UIView alloc]init];
        _contenView.backgroundColor = [UIColor redColor];
    }
    return _contenView;
}

-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor redColor];
    }
    return _topView;
}

-(UITableView *)mytableView{
    if (_mytableView == nil) {
        _mytableView = [[UITableView alloc]init];
        _mytableView.backgroundColor = [UIColor greenColor];
    }
    return _mytableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.myScrollView];
    
    [self.myScrollView addSubview:self.contenView];
    
    [self.contenView addSubview:self.topView];
    
    [self.contenView addSubview:self.mytableView];
    
    WeakSelf;
    [self.myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.contenView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(weakself.myScrollView);
        make.height.width.mas_equalTo(weakself.myScrollView);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    [self.mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(weakself.topView.mas_bottom);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.myScrollView) {
        
        if (scrollView.contentOffset.y <= 0) {
            
            [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
               
                make.top.mas_equalTo(scrollView.contentOffset.y);
                make.height.mas_equalTo(200 - scrollView.contentOffset.y);
            }];
        }
    }
    if (scrollView.contentOffset.y < -200) {
        
        [scrollView setContentOffset:CGPointMake(0, -200)];
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.myScrollView setContentSize:CGSizeMake(0, 1000)];
}
@end
