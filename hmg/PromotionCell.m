//
//  PromotionCell.m
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "PromotionCell.h"
#import "Masonry.h"

@implementation PromotionCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            //@weakify(self);
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor=[self colorWithHexString:@"#e9f1f6" alpha:1];
        
#pragma 白色方框容器
        UIView  *rootView=[[UIView alloc] init];
        rootView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:rootView];
        
        [rootView mas_makeConstraints:^(MASConstraintMaker *make) {
                //@strongify(self);
            make.left.mas_equalTo(self.contentView.mas_left).with.offset(5);
            make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
            make.right.mas_equalTo(self.contentView.mas_right).with.offset(-5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0);
        }];
        
        self.storeLabel=[[UILabel alloc] init];
        self.storeLabel.font=[UIFont systemFontOfSize:18];
        self.storeLabel.textColor=[self colorWithHexString:@"#00CC99" alpha:1];
        [rootView addSubview:self.storeLabel];
        
        [self.storeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rootView.mas_left).with.offset(10);
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
        }];
        
        self.posLabel=[[UILabel alloc] init];
        self.posLabel.font=[UIFont systemFontOfSize:18];
        self.posLabel.textColor=[self colorWithHexString:@"#FF6600" alpha:1];
        [rootView addSubview:self.posLabel];
        [self.posLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-10);
        }];
        
        self.productLabel=[[UILabel alloc] init];
        self.productLabel.font=[UIFont systemFontOfSize:16];
        [rootView addSubview:self.productLabel];
        [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                //@strongify(self);
            make.left.mas_equalTo(rootView.mas_left).with.offset(10);
            make.top.mas_equalTo(self.storeLabel.mas_bottom).with.offset(15);
            make.width.mas_lessThanOrEqualTo(rootView.mas_width).multipliedBy(0.65);
        }];
        
        UIView *round1=[[UIView alloc] init];
        round1.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:1];
        round1.layer.cornerRadius=2;
        round1.layer.masksToBounds=YES;
        [rootView addSubview:round1];
        [round1 mas_makeConstraints:^(MASConstraintMaker *make) {
                // @strongify(self);
            make.centerY.mas_equalTo(self.productLabel.mas_centerY);
            make.left.mas_equalTo(self.productLabel.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(4, 4));
        }];
        
        self.specLabel=[[UILabel alloc] init];
        self.specLabel.font=[UIFont systemFontOfSize:16];
        [rootView addSubview:self.specLabel];
        [self.specLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(round1.mas_centerY);
            make.left.mas_equalTo(round1.mas_right).with.offset(5);
            make.width.lessThanOrEqualTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        UIView *round2=[[UIView alloc] init];
        round2.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:1];
        round2.layer.cornerRadius=2;
        round2.layer.masksToBounds=YES;
        [rootView addSubview:round2];
        [round2 mas_makeConstraints:^(MASConstraintMaker *make) {
                // @strongify(self);
            make.centerY.mas_equalTo(self.specLabel.mas_centerY);
            make.left.mas_equalTo(self.specLabel.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(4, 4));
        }];
        
        self.countLabel=[[UILabel alloc] init];
        self.countLabel.font=[UIFont systemFontOfSize:16];
        self.countLabel.textColor=[self colorWithHexString:@"#FF6600" alpha:1];
        [rootView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(round2.mas_centerY);
            make.left.mas_equalTo(round2.mas_right).with.offset(5);
        }];
        
        UIView *line=[[UIView alloc] init];
        line.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [rootView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.productLabel.mas_bottom).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(10);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-10);
            make.height.mas_equalTo(@0.3);
        }];
        
        self.userLabel=[[UILabel alloc] init];
        self.userLabel.font=[UIFont systemFontOfSize:16];
        self.userLabel.textColor=[UIColor lightGrayColor];
        [rootView addSubview:self.userLabel];
        [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rootView.mas_left).with.offset(10);
            make.top.mas_equalTo(line.mas_bottom).with.offset(5);
            make.bottom.mas_equalTo(rootView.mas_bottom).with.offset(-5);
        }];
        
        UIView *verticalLine=[[UIView alloc] init];
        verticalLine.backgroundColor=[UIColor lightGrayColor];
        [rootView addSubview:verticalLine];
        [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userLabel.mas_right).with.offset(5);
            make.top.mas_equalTo(line.mas_bottom).with.offset(5);
            make.bottom.mas_equalTo(rootView.mas_bottom).with.offset(-5);
            make.width.mas_equalTo(@0.3);
        }];
        
        self.promotionDateLabel=[[UILabel alloc] init];
        self.promotionDateLabel.font=[UIFont systemFontOfSize:16];
        self.promotionDateLabel.textColor=[UIColor lightGrayColor];
        [rootView addSubview:self.promotionDateLabel];
        [self.promotionDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom).with.offset(5);
            make.left.mas_equalTo(verticalLine.mas_right).with.offset(5);
            make.bottom.mas_equalTo(rootView.mas_bottom).with.offset(-5);
        }];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"promotionCellId";
    PromotionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PromotionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
        //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        // String should be 6 or 8 characters
    if ([cString length] < 6)
        {
        return [UIColor clearColor];
        }
        // strip 0X if it appears
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
        {
        cString = [cString substringFromIndex:2];
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
        {
        cString = [cString substringFromIndex:1];
        }
    if ([cString length] != 6)
        {
        return [UIColor clearColor];
        }
    
        // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
        //r
    NSString *rString = [cString substringWithRange:range];
        //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
        //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
        // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
