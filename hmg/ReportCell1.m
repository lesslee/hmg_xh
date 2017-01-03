//
//  ReportCell1.m
//  hmg
//
//  Created by hongxianyu on 2016/12/28.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "ReportCell1.h"
    //#import "Masonry.h"
#import "ReportModel.h"
#import "UIView+SDAutoLayout.h"
@implementation ReportCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.company = [UIButton new];
    [self.contentView addSubview:self.company];
    [self.company setTitleColor:[self colorWithHexString:@"#5cd1cc" alpha:1] forState:UIControlStateNormal];
    self.company.titleLabel.font = [UIFont systemFontOfSize:18];
    self.company.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.company.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    
    
    self.rmk = [UILabel new];
    [self.contentView addSubview:self.rmk];
    self.rmk.textColor = [self colorWithHexString:@"#7C7C7C" alpha:1];
    self.rmk.numberOfLines = 0;
    
    self.ename = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.contentView addSubview:self.ename];
    [self.ename setTitleColor:[self colorWithHexString:@"#5cd1cc" alpha:1] forState:UIControlStateNormal];
    self.ename.titleLabel.font = [UIFont systemFontOfSize:18];
     self.ename.layer.borderColor = [[self colorWithHexString:@"#5cd1cc" alpha:1]CGColor];
     self.ename.layer.borderWidth = 1.0f;
     self.ename.layer.cornerRadius = 5.0f;
     self.ename.layer.masksToBounds = YES;
    
    self.product = [UILabel new];
    [self.contentView addSubview:self.product];
    self.product.font = [UIFont systemFontOfSize:18];
    self.product.textColor = [self colorWithHexString:@"#7C7C7C" alpha:1];

    
    
    UIView *round1=[[UIView alloc] init];
    [self.contentView addSubview:round1];
    round1.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:1];
    round1.layer.cornerRadius=2;
    round1.layer.masksToBounds=YES;
    
    
    self.purpose = [UILabel new];
    [self.contentView addSubview:self.purpose];
    self.purpose.font = [UIFont systemFontOfSize:18];
    self.purpose.textColor = [self colorWithHexString:@"#7C7C7C" alpha:1];
    self.purpose.textAlignment = NSTextAlignmentCenter;

    UIView *round2=[[UIView alloc] init];
    [self.contentView addSubview:round2];
    round2.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:1];
    round2.layer.cornerRadius=2;
    round2.layer.masksToBounds=YES;

    
    self.date = [UILabel new];
    [self.contentView addSubview:self.date];
    self.date.font = [UIFont systemFontOfSize:18];
    self.date.textColor = [self colorWithHexString:@"#7C7C7C" alpha:1];

    
    
        CGFloat margin = 5;
        UIView *contentView = self.contentView;
    
    _company.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin)
    .widthIs(self.contentView.frame.size.width)
    .heightIs(30);
    
    _rmk.sd_layout
    .leftSpaceToView(contentView,margin)
    .rightSpaceToView(contentView,margin)
    .topSpaceToView(_company,margin)
    .autoHeightRatio(0);
    
    _ename.sd_layout
    .topSpaceToView(_rmk,margin)
    .leftSpaceToView(contentView,margin)
    .widthIs(80)
    .heightIs(30);
    
    _product.sd_layout
    .leftSpaceToView(_ename,2)
    .centerYEqualToView(_ename)
    .widthIs(45)
    .heightIs(30);
    
    round1.sd_layout
    .leftSpaceToView(_product,2)
    .centerYEqualToView(_ename)
    .widthIs(4)
    .heightIs(4);
    
    _purpose.sd_layout
    .leftSpaceToView(round1,2)
    .centerYEqualToView(_ename)
    .widthIs(40)
    .heightIs(30);
    
    round2.sd_layout
    .leftSpaceToView(_purpose,2)
    .centerYEqualToView(_ename)
    .widthIs(4)
    .heightIs(4);

    _date.sd_layout
    .leftSpaceToView(round2,2)
    .centerYEqualToView(_ename)
    .widthIs(100)
    .heightIs(30);
    
    [self setupAutoHeightWithBottomViewsArray:@[_ename, _product,round1,_purpose,round2,_date] bottomMargin:margin];
    
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


- (void)setModel:(ReportModel *)model
{
    _model = model;
    
    if ([model.STORE_NM isEqualToString:@"无"]) {
        
        [self.company setTitle: model.AGENT_NM forState:UIControlStateNormal];
    }else
        {
        [self.company setTitle:model.STORE_NM forState:UIControlStateNormal];
        }
    self.date.text = model.INP_DTM;
    self.rmk.text=model.RMK;
    self.product.text=model.PRODUCT_NM;
    self.purpose.text=model.VISIT_PURPOSE;
    [self.ename setTitle:model.EMP_NM forState:UIControlStateNormal];
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
