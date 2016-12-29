//
//  InterviewCell.m
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "InterviewCell.h"
#import "Masonry.h"
@implementation InterviewCell

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
            make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(0);
        }];
        
        self.InterName=[[UILabel alloc] init];
        self.InterName.font=[UIFont systemFontOfSize:18];
        self.InterName.textColor = [self colorWithHexString:@"#5cd1cc" alpha:1];
        [rootView addSubview:self.InterName];
        [self.InterName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
        }];
        
        self.InterCity=[[UILabel alloc] init];
        self.InterCity.font=[UIFont systemFontOfSize:16];
        self.InterCity.textColor = [self colorWithHexString:@"#7C7C7C" alpha:1];
        [rootView addSubview:self.InterCity];
        [self.InterCity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rootView.mas_top).with.offset(10);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
        }];
        
        
        UIView *line=[[UIView alloc] init];
        line.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [rootView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.InterName.mas_bottom).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.height.mas_equalTo(@0.3);
        }];
        
        UILabel *lable = [[UILabel alloc]init];
        lable.text = @"门店拜访数量:";
        lable.textColor =[self colorWithHexString:@"#7C7C7C" alpha:1];
        lable.font = [UIFont systemFontOfSize:16];
        [rootView addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rootView.mas_left).with.offset(5);
            make.top.equalTo(line.mas_top).with.offset(10);
            make.bottom.equalTo(rootView.mas_bottom).with.offset(-10);
        }];
        
        
        self.InterStoresNU=[[UILabel alloc] init];
        self.InterStoresNU.font=[UIFont systemFontOfSize:16];
        self.InterStoresNU.textColor = [self colorWithHexString:@"#fd877c" alpha:1];
        [rootView addSubview:self.InterStoresNU];
        [self.InterStoresNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lable.mas_right).with.offset(2);
            make.top.mas_equalTo(line.mas_bottom).with.offset(10);
            make.bottom.mas_equalTo(rootView.mas_bottom).with.offset(-10);
                //make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.5);
        }];
        
        
        UILabel *lable1 = [[UILabel alloc]init];
        lable1.text = @"拜访次数:";
        lable1.font = [UIFont systemFontOfSize:16];
        lable1.textColor =[self colorWithHexString:@"#7C7C7C" alpha:1];
        [rootView addSubview:lable1];
        
        [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(rootView.mas_centerX);
            make.top.equalTo(line.mas_top).with.offset(10);
            make.bottom.equalTo(rootView.mas_bottom).with.offset(-10);
        }];
        
        
        
        self.InterNU=[[UILabel alloc] init];
        self.InterNU.font=[UIFont systemFontOfSize:16];
        self.InterNU.textColor = [self colorWithHexString:@"#fd877c" alpha:1];
        [rootView addSubview:self.InterNU];
        [self.InterNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_bottom).with.offset(10);
            make.bottom.mas_equalTo(rootView.mas_bottom).with.offset(-10);
            make.left.mas_equalTo(lable1.mas_right).with.offset(2);
                //make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.5);
                //make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
        }];
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"InterviewCellId";
    InterviewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[InterviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
