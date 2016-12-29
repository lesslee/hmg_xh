//
//  PromotionCell.h
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionCell : UITableViewCell
    //门店
@property (nonatomic,strong) UILabel *storeLabel;
    //pos金额
@property (nonatomic,strong) UILabel *posLabel;
    //产品
@property (nonatomic,strong) UILabel *productLabel;
    //规格
@property (nonatomic,strong) UILabel *specLabel;
    //数量
@property (nonatomic,strong) UILabel *countLabel;
    //提报人员
@property (nonatomic,strong) UILabel *userLabel;
    //促销日期
@property (nonatomic,strong) UILabel *promotionDateLabel;

    //注册cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
