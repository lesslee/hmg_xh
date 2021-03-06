//
//  StoresCell1.m
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "StoresCell1.h"
#import "Masonry.h"
@implementation StoresCell1
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
            make.centerY.mas_equalTo(self.Provincial.mas_centerY);
            make.left.mas_equalTo(self.Provincial.mas_right).with.offset(10);
            
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
        UILabel *uza = [[UILabel alloc]init];
        UILabel *dentil = [[UILabel alloc]init];
        UILabel *phyll = [[UILabel alloc]init];
        UILabel *tgm = [[UILabel alloc]init];
        UILabel *qt = [[UILabel alloc]init];
        
        
        uza.font=[UIFont systemFontOfSize:16];
        uza.text= @"u-za";
        uza.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        uza.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:uza];
        [uza mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_top).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        dentil.font=[UIFont systemFontOfSize:16];
        dentil.text = @"dentil";
        dentil.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        dentil.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:dentil];
        [dentil mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_top).with.offset(10);
            make.left.mas_equalTo(uza.mas_right).with.offset(0);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        phyll.font=[UIFont systemFontOfSize:16];
        phyll.text = @"phyll";
        phyll.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        phyll.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:phyll];
        [phyll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_top).with.offset(10);
            make.left.mas_equalTo(dentil.mas_right).with.offset(0);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        tgm.font=[UIFont systemFontOfSize:16];
        tgm.text = @"tgm";
        tgm.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        tgm.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:tgm];
        [tgm mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_top).with.offset(10);
            make.left.mas_equalTo(phyll.mas_right).with.offset(0);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        qt.font=[UIFont systemFontOfSize:16];
        qt.text = @"其他";
        qt.textColor=[self colorWithHexString:@"#7C7C7C" alpha:1];
        qt.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:qt];
        [qt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line.mas_top).with.offset(10);
            make.left.mas_equalTo(tgm.mas_right).with.offset(0);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
                //make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        
        UIView *line1=[[UIView alloc] init];
        line1.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [rootView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(uza.mas_bottom).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.height.mas_equalTo(@0.5);
        }];
        
        
        self.uzaNU=[[UILabel alloc] init];
        self.uzaNU.font=[UIFont systemFontOfSize:16];
        self.uzaNU.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        self.uzaNU.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:self.uzaNU];
        [self.uzaNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_top).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
                //make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        self.dentilNU=[[UILabel alloc] init];
        self.dentilNU.font=[UIFont systemFontOfSize:16];
        self.dentilNU.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        self.dentilNU.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:self.dentilNU];
        [self.dentilNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_top).with.offset(10);
            make.left.mas_equalTo(_uzaNU.mas_right).with.offset(0);
                //make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        self.phyllNU=[[UILabel alloc] init];
        self.phyllNU.font=[UIFont systemFontOfSize:16];
        self.phyllNU.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        self.phyllNU.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:self.phyllNU];
        [self.phyllNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_top).with.offset(10);
            make.left.mas_equalTo(_dentilNU.mas_right).with.offset(0);
                //make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        self.tgmNU=[[UILabel alloc] init];
        self.tgmNU.font=[UIFont systemFontOfSize:16];
        self.tgmNU.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        self.tgmNU.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:self.tgmNU];
        [self.tgmNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_top).with.offset(10);
            make.left.mas_equalTo(_phyllNU.mas_right).with.offset(0);
                //make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        self.qtNU=[[UILabel alloc] init];
        self.qtNU.font=[UIFont systemFontOfSize:16];
        self.qtNU.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        self.qtNU.textAlignment = NSTextAlignmentCenter;
        [rootView addSubview:self.qtNU];
        [self.qtNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(line1.mas_top).with.offset(10);
            make.left.mas_equalTo(_tgmNU.mas_right).with.offset(0);
                //make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.2);
        }];
        
        
        UIView *line2=[[UIView alloc] init];
        line2.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [rootView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.uzaNU.mas_bottom).with.offset(10);
            make.left.mas_equalTo(rootView.mas_left).with.offset(5);
            make.right.mas_equalTo(rootView.mas_right).with.offset(-5);
            make.height.mas_equalTo(@0.5);
        }];
        
        UILabel *lable = [[UILabel alloc]init];
        lable.text = @"合计:";
        lable.textColor =[self colorWithHexString:@"#7C7C7C" alpha:1];
        lable.font = [UIFont systemFontOfSize:16];
        [rootView addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rootView.mas_left).with.offset(5);
            make.top.mas_equalTo(line2.mas_bottom).with.offset(10);
            make.bottom.equalTo(rootView.mas_bottom).with.offset(-15);
        }];
        self.hjNU=[[UILabel alloc] init];
        self.hjNU.font=[UIFont systemFontOfSize:16];
        self.hjNU.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        [rootView addSubview:self.hjNU];
        [self.hjNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lable.mas_right).with.offset(2);
            make.top.mas_equalTo(line2.mas_bottom).with.offset(10);
            make.bottom.equalTo(rootView.mas_bottom).with.offset(-15);
            make.centerY.equalTo(lable.mas_centerY);
                //make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.5);
        }];
        
        UILabel *lable2 = [[UILabel alloc]init];
        lable2.text = @"同比:";
        lable2.textColor =[self colorWithHexString:@"#7C7C7C" alpha:1];
        lable2.font = [UIFont systemFontOfSize:16];
        [rootView addSubview:lable2];
        
        [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.left.equalTo(rootView.mas_centerX);
            make.left.equalTo(self.hjNU.mas_right).with.offset(10);
            make.centerY.equalTo(lable.mas_centerY);
            make.top.mas_equalTo(line2.mas_bottom).with.offset(10);
            make.bottom.equalTo(rootView.mas_bottom).with.offset(-15);
        }];
        self.tbNU=[[UILabel alloc] init];
        self.tbNU.font=[UIFont systemFontOfSize:16];
        self.tbNU.textColor=[self colorWithHexString:@"#fd877c" alpha:1];
        [rootView addSubview:self.tbNU];
        [self.tbNU mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lable2.mas_right).with.offset(2);
            make.top.mas_equalTo(line2.mas_bottom).with.offset(10);
            make.bottom.equalTo(rootView.mas_bottom).with.offset(-15);
            make.centerY.equalTo(lable2.mas_centerY);
                //make.width.mas_equalTo(rootView.mas_width).multipliedBy(0.5);
        }];
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"StoresCell1ID";
    StoresCell1 *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[StoresCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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


