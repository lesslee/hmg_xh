//
//  StoreVisitNumberCell1.h
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreVisitNumberCell1 : UITableViewCell
    //门店名字
@property (nonatomic,strong) UILabel *StoreName;
    //走访省
@property (nonatomic,strong) UILabel *ProvinceName;
    //
@property (nonatomic,strong) UILabel *ManageName;
    //门店级别
@property (nonatomic,strong) UILabel *Storelevel;
@property (nonatomic,strong) UILabel *StoreVisitNU;


    //注册cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
