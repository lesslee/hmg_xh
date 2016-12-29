//
//  BusinessCell1.h
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCell1 : UITableViewCell
@property (nonatomic,strong) UILabel *BusinessName;

@property (nonatomic,strong) UILabel *province;
    //
@property (nonatomic,strong) UILabel *city;
@property (nonatomic,strong) UILabel *date;
@property (nonatomic,strong) UILabel *BusinessNU;
@property (nonatomic,strong) UILabel *liuxiangScore;



    //注册cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
