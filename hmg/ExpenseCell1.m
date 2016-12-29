//
//  ExpenseCell1.m
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "ExpenseCell1.h"
#import "Masonry.h"
@implementation ExpenseCell1

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
        
        self.Provincial=[[UILabel alloc] init];
        self.Provincial.font=[UIFont systemFontOfSize:18];
        self.Provincial.textColor = [self colorWithHexString:@"#5cd1cc" alpha:1];
        [rootView addSubview:self.Provincial];
        [self.Provincial mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
//            make.width.mas_lessThanOrEqualTo(rootView.mas_width).multipliedBy(0.7);
        }];
        
        self.date=[[UILabel alloc] init];
        self.date.font=[UIFont systemFontOfSize:18];
        self.date.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        [rootView addSubview:self.date];
        [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
            make.left.mas_equalTo(self.Provincial.mas_right).with.offset(15);
            make.centerY.equalTo(self.Provincial.mas_centerY);
            
        }];
        UIView *line=[[UIView alloc] init];
        line.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [rootView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.Provincial.mas_bottom).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.height.mas_equalTo(@0.5);
        }];
        UILabel *shengyu = [[UILabel alloc]init];
        UILabel *shenqing = [[UILabel alloc]init];
        UILabel *hexiao = [[UILabel alloc]init];
        
        
        
        shengyu.font=[UIFont systemFontOfSize:16];
        shengyu.text= @"剩余预算";
        shengyu.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        shengyu.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:shengyu];
        [shengyu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_top).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.33);
        }];
        
        shenqing.font=[UIFont systemFontOfSize:16];
        shenqing.text = @"已申请金额";
        shenqing.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        shenqing.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:shenqing];
        [shenqing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_top).with.offset(10);
            make.left.mas_equalTo(shengyu.mas_right).with.offset(0);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.33);
        }];
        
        hexiao.font=[UIFont systemFontOfSize:16];
        hexiao.text = @"已核销金额";
        hexiao.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        hexiao.textAlignment = NSTextAlignmentCenter;

        [rootView addSubview:hexiao];
        [hexiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_top).with.offset(10);
            make.left.mas_equalTo(shenqing.mas_right).with.offset(0);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.33);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
        }];
        
        
        UIView *line1=[[UIView alloc] init];
        line1.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [rootView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shengyu.mas_bottom).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.height.mas_equalTo(@0.5);
        }];
        
        
        self.Surplus=[[UILabel alloc] init];
        self.Surplus.font=[UIFont systemFontOfSize:13];
        self.Surplus.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
         self.Surplus.textAlignment = NSTextAlignmentCenter;

        [rootView addSubview:self.Surplus];
        [self.Surplus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_top).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
                //make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.33);
        }];
        
        self.Already=[[UILabel alloc] init];
        self.Already.font=[UIFont systemFontOfSize:13];
        self.Already.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        self.Already.textAlignment = NSTextAlignmentCenter;

        [rootView addSubview:self.Already];
        [self.Already mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_top).with.offset(10);
            make.left.mas_equalTo(self.Surplus.mas_right).with.offset(0);
                //make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.33);
        }];
        
        self.Verification=[[UILabel alloc] init];
        self.Verification.font=[UIFont systemFontOfSize:13];
        self.Verification.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        self.Verification.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:self.Verification];
        [self.Verification mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_top).with.offset(10);
            make.left.mas_equalTo(self.Already.mas_right).with.offset(0);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.33);
        }];
        
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"ExpenseCell1Id";
    ExpenseCell1 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ExpenseCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
