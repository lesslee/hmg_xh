//
//  BusinessCell1.m
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "BusinessCell1.h"
#import "Masonry.h"
@implementation BusinessCell1
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
            make.left.mas_equalTo(self.contentView.mas_left).with.offset(0);
            make.top.mas_equalTo(self.contentView.mas_top).with.offset(5);
            make.right.mas_equalTo(self.contentView.mas_right).with.offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(5);
        }];
        
        self.BusinessName=[[UILabel alloc] init];
        self.BusinessName.font=[UIFont systemFontOfSize:18];
        self.BusinessName.textColor = [self colorWithHexString:@"#5cd1cc" alpha:1];
        [rootView addSubview:self.BusinessName];
        [self.BusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
        }];
        
        self.date=[[UILabel alloc] init];
        self.date.font=[UIFont systemFontOfSize:16];
        self.date.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        [rootView addSubview:self.date];
        [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
            make.left.mas_equalTo(self.BusinessName.mas_right).with.offset(10);
        }];
        
        
        self.province=[[UILabel alloc] init];
        self.province.font=[UIFont systemFontOfSize:16];
        self.province.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        [rootView addSubview:self.province];
        [self.province mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
                //make.left.mas_equalTo(self.date.mas_right).with.offset(10);
        }];
        
        
        UIView *line=[[UIView alloc] init];
        line.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:1];
        [rootView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.province.mas_centerY);
            make.left.mas_equalTo(self.province.mas_right).with.offset(5);
            make.height.mas_equalTo(@0.5);
            make.width.mas_equalTo(10);
        }];
        
        
        self.city=[[UILabel alloc] init];
        self.city.font=[UIFont systemFontOfSize:16];
        self.city.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        [rootView addSubview:self.city];
        [self.city mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
            make.left.mas_equalTo(line.mas_right).with.offset(5);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
        }];
        
        UIView *line1=[[UIView alloc] init];
        line1.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [rootView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.BusinessName.mas_bottom).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.height.mas_equalTo(@0.3);
        }];

        
        UILabel *lable = [[UILabel alloc]init];
        lable.text = @"出差:";
        lable.textColor =[self colorWithHexString:@"#7C7C7C" alpha:1];
        lable.font = [UIFont systemFontOfSize:16];
        [rootView addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rootView.mas_left).with.offset(5);
            make.top.mas_equalTo(line1.mas_bottom).with.offset(10);
            make.bottom.equalTo(rootView.mas_bottom).with.offset(-10);
        }];

        self.BusinessNU=[[UILabel alloc] init];
        self.BusinessNU.font=[UIFont systemFontOfSize:16];
        self.BusinessNU.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        [rootView addSubview:self.BusinessNU];
        [self.BusinessNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lable.mas_right).with.offset(2);
            make.top.mas_equalTo(line1.mas_bottom).with.offset(10);
            make.bottom.mas_equalTo(rootView.mas_bottom).with.offset(-10);
                //make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.5);
        }];
        
        UILabel *lable1 = [[UILabel alloc]init];
        lable1.text = @"流向:";
        lable1.textColor =[self colorWithHexString:@"#7C7C7C" alpha:1];
        lable1.font = [UIFont systemFontOfSize:16];
        [rootView addSubview:lable1];
        
        [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rootView.mas_centerX);
            make.top.mas_equalTo(line1.mas_bottom).with.offset(10);
            make.bottom.equalTo(rootView.mas_bottom).with.offset(-10);
        }];
        self.liuxiangScore=[[UILabel alloc] init];
        self.liuxiangScore.font=[UIFont systemFontOfSize:16];
        self.liuxiangScore.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        [rootView addSubview:self.liuxiangScore];
        [self.liuxiangScore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_bottom).with.offset(10);
            make.bottom.mas_equalTo(rootView.mas_bottom).with.offset(-10);
                //make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.5);
            make.left.mas_equalTo(lable1.mas_right).with.offset(2);
        }];
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"BusinessCell1Id";
    BusinessCell1 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BusinessCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
