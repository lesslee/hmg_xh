//
//  InterviewCell.h
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterviewCell : UITableViewCell
    //走访人
@property (nonatomic,strong) UILabel *InterName;
    //走访省
@property (nonatomic,strong) UILabel *InterCity;

    //门店拜访数量
@property (nonatomic,strong) UILabel *InterStoresNU;
    //拜访次数
@property (nonatomic,strong) UILabel *InterNU;

    //注册cell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
