//
//  ExpenseCell1.h
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseCell1 : UITableViewCell
@property (nonatomic,strong) UILabel *date;
@property (nonatomic,strong) UILabel *Provincial;
@property (nonatomic,strong) UILabel *Surplus;
@property (nonatomic,strong) UILabel *Already;
@property (nonatomic,strong) UILabel *Verification;
    //注册cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
