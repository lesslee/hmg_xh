//
//  ReportCell1.h
//  hmg
//
//  Created by hongxianyu on 2016/12/28.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReportModel;
@interface ReportCell1 : UITableViewCell
@property(nonatomic,strong)UIButton  *company;
@property(nonatomic,strong)UIButton *ename;
@property(nonatomic,strong)UILabel *date;
@property(nonatomic,strong)UILabel *rmk;
@property(nonatomic,strong)UILabel *product;
@property(nonatomic,strong)UILabel *purpose;

@property(nonatomic,strong)UIView  *rootView;
 @property (nonatomic, strong) ReportModel *model;
@end
