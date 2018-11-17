//
//  CommenTableViewCell.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/23.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "CommenTableViewCell.h"
#import "Masonry.h"
@implementation CommenTableViewCell

-(UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1];;
        _leftLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = [UIColor redColor];;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    }
    return _rightLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(13);
        }];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(15);
        }];
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [self.contentView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(1);
        }];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
