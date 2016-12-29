//
//  StoresCell1.h
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoresCell1 : UITableViewCell
@property (nonatomic,strong) UILabel *date;
@property (nonatomic,strong) UILabel *Provincial;
@property (nonatomic,strong) UILabel *uzaNU;
@property (nonatomic,strong) UILabel *dentilNU;
@property (nonatomic,strong) UILabel *phyllNU;
@property (nonatomic,strong) UILabel *tgmNU;
@property (nonatomic,strong) UILabel *qtNU;
@property (nonatomic,strong) UILabel *hjNU;
@property (nonatomic,strong) UILabel *tbNU;
    //注册cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
