//
//  StockCell1.h
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockCell1 : UITableViewCell
@property (nonatomic,strong) UILabel *AgentName;
@property (nonatomic,strong) UILabel *Provincial;
@property (nonatomic,strong) UILabel *uzaNU;
@property (nonatomic,strong) UILabel *dentiNU;
@property (nonatomic,strong) UILabel *phyllNU;
@property (nonatomic,strong) UILabel *tgmNU;
@property (nonatomic,strong) UILabel *qitaNU;
@property (nonatomic,strong) UILabel *uzaM;
@property (nonatomic,strong) UILabel *dentiM;
@property (nonatomic,strong) UILabel *phyllM;
@property (nonatomic,strong) UILabel *tgmM;
@property (nonatomic,strong) UILabel *qitaM;
@property (nonatomic,strong) UILabel *hejiNU;
@property (nonatomic,strong) UILabel *hejiM;
@property (nonatomic,strong) UILabel *dayormonthNU;

    //注册cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
