//
//  KPCell.h
//  hmg
//
//  Created by hongxianyu on 2016/12/26.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPCell : UITableViewCell
@property(nonatomic,strong)UILabel *Provincial;
@property(nonatomic,strong)UILabel *mubiao;
@property(nonatomic,strong)UILabel *date;
@property(nonatomic,strong)UILabel *uzaNU;
@property(nonatomic,strong)UILabel *dentilNU;
@property(nonatomic,strong)UILabel *phyllNU;

@property(nonatomic,strong)UILabel *tgmNU;
@property(nonatomic,strong)UILabel *qtNU;

@property(nonatomic,strong)UILabel *hjNU;
@property(nonatomic,strong)UILabel *dachengNU;

@property(nonatomic,strong)UILabel *tbNU;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end