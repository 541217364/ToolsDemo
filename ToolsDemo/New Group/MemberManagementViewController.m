//
//  MemberManagementViewController.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/22.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "MemberManagementViewController.h"
#import "CommenTableViewCell.h"
#define WeakSelf __weak typeof (self)weakself = self
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface MemberManagementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;

@property(nonatomic,strong)UIView *topView;

@property (nonatomic, strong) UIView *guideView;

@property (nonatomic, strong) UIView *guideLine;

@property (nonatomic, strong) UIButton *lastButton;

@property (nonatomic, strong) CALayer *buttonBottomBorder;

@property (nonatomic, assign) NSInteger nowIndex;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic, strong) UILabel *userIDLable;

@property (nonatomic, strong) UILabel *cardTypeLable;

@property (nonatomic, strong) UIButton *vipBtn;

@property (nonatomic, strong) UIButton *upgradeBtn;



@end

static CGFloat TOPVIEWHEIGHT = 350;
@implementation MemberManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self setUI];
}


-(UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.frame = CGRectMake(0, 0, kWidth, TOPVIEWHEIGHT);
        [self designHeaderView];
    }
    return _topView;
}

-(UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc]init];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _myTableView;
}


-(void)setUI{
    
    [self.view addSubview:self.myTableView];
    self.myTableView.tableHeaderView = self.topView;
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}



-(void)designHeaderView{
    
    UIImageView *backView = [[UIImageView alloc]init];
    backView.image = [UIImage imageNamed:@"矩形 27"];
    [_topView addSubview:backView];
    
    UIImageView *cardImageView = [[UIImageView alloc]init];
    cardImageView.image = [UIImage imageNamed:@"会员卡"];
    cardImageView.userInteractionEnabled = YES;
    [_topView addSubview:cardImageView];
    [self designCardView:cardImageView];
    
    _guideView = [[UIView alloc] init];
    _guideView.backgroundColor = [UIColor whiteColor];
    [_topView addSubview:_guideView];
    _buttonBottomBorder = [CALayer layer];
    _buttonBottomBorder.backgroundColor = [UIColor brownColor].CGColor;
    NSArray *typeArray = @[@"黄金会员",@"白金会员",@"钻石会员"];
    for (int i = 0; i < typeArray.count; i++)
    {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(i*kWidth/3, 0, kWidth/3, 50);
        [titleButton setTitle:typeArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        titleButton.tag = i + 100;
        if (i == 0)
        {
            titleButton.selected = YES;
            _lastButton = titleButton;
            [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
            _buttonBottomBorder.frame = CGRectMake((kWidth/3-50)/2, 45, 50, 2);
            [titleButton.layer addSublayer:_buttonBottomBorder];
        }
        [titleButton addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_guideView addSubview:titleButton];
    }
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];;
    [_topView addSubview:lineView];

    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    
    [cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 175));
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(backView.mas_bottom);
    }];
    
    [self.guideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(50);
        make.left.right.mas_equalTo(0);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
        make.left.right.mas_equalTo(0);
    }];
}



-(void)designCardView:(UIImageView *)contentView{
    
    [contentView addSubview:self.headImageView];
    [contentView addSubview:self.nameLable];
    [contentView addSubview:self.userIDLable];
    [contentView addSubview:self.cardTypeLable];
    [contentView addSubview:self.vipBtn];
    [contentView addSubview:self.upgradeBtn];
    
    WeakSelf;
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(30);
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.headImageView.mas_right).offset(10);
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(weakself.headImageView);
    }];

    [self.userIDLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.nameLable);
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(weakself.headImageView);
    }];

    [self.cardTypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.headImageView);
        make.height.mas_equalTo(15);
        make.bottom.mas_equalTo(-30);
    }];

    [self.vipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(weakself.headImageView);
    }];

    [self.upgradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakself.vipBtn);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
        make.centerY.mas_equalTo(weakself.cardTypeLable);
    }];
    
    
}


-(UIImageView *)headImageView{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc]init];
        _headImageView.layer.cornerRadius = 22.5f;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.backgroundColor = [UIColor redColor];
    }
    return _headImageView;
}

-(UILabel *)nameLable{
    if (_nameLable == nil) {
        _nameLable = [[UILabel alloc]init];
        _nameLable.textColor = [UIColor whiteColor];
        _nameLable.text = @"张三疯";
        _nameLable.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:16];
    }
    return _nameLable;
}

-(UILabel *)userIDLable{
    if (_userIDLable == nil) {
        _userIDLable = [[UILabel alloc]init];
        _userIDLable.textColor = [UIColor whiteColor];
        _userIDLable.text = @"ID: 123445";
        _userIDLable.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    }
    return _userIDLable;
}

-(UILabel *)cardTypeLable{
    if (_cardTypeLable == nil) {
        _cardTypeLable = [[UILabel alloc]init];
        _cardTypeLable.text = @"点呗卡管家";
        _cardTypeLable.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        _cardTypeLable.textColor =[UIColor whiteColor];
    }
    return _cardTypeLable;
}

-(UIButton *)vipBtn{
    if (_vipBtn == nil) {
        _vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _vipBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        [_vipBtn setImage:[UIImage imageNamed:@"黄金"] forState:UIControlStateNormal];
        [_vipBtn setTitle:@"普通会员" forState:UIControlStateNormal];
        [_vipBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        _vipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    }
    return _vipBtn;
}

-(UIButton *)upgradeBtn{
    if (_upgradeBtn == nil) {
        _upgradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _upgradeBtn.backgroundColor = [UIColor whiteColor];
        _upgradeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_upgradeBtn setTitle:@"立即升级" forState:UIControlStateNormal];
        [_upgradeBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
        [_upgradeBtn addTarget:self action:@selector(upgtadeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upgradeBtn;
}



- (void)didClickHeadButtonAction:(UIButton *)button
{
    if (!button.selected)
    {
    }
    _nowIndex = button.tag;
    [_lastButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _lastButton.selected = NO;
    _lastButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _lastButton = button;
    button.selected = !button.selected;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [UIView animateWithDuration:0.4 animations:^{
        self.buttonBottomBorder.frame = CGRectMake(button.frame.origin.x+(kWidth/3-50)/2, 45, 50, 2);
        [self.guideView.layer addSublayer:self.buttonBottomBorder];
    }];
    if (button.tag == 100) {
       // self.iconImageView.image = [UIImage imageNamed:@"huangjin"];
       // [self loadDataWithLevel:@"1"];
    }else if (button.tag == 101){
//        self.iconImageView.image = [UIImage imageNamed:@"bojin"];
//        [self loadDataWithLevel:@"2"];
    }else{
//        self.iconImageView.image = [UIImage imageNamed:@"zuanshi"];
//        [self loadDataWithLevel:@"3"];
    }
   
}


-(void)upgtadeAction{
    
    NSLog(@"立即升级");
}


#pragma mark tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    
   
    
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        
        cell.textLabel.text = @"分润";
        
        return cell;
        
    }else{
        
        CommenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[CommenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    
        cell.leftLabel.text = @"好友升级银卡（直接邀请）";
        
        cell.rightLabel.text = @"0元";
        
        return cell;
    }
    
    return nil;
}

@end
