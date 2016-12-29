//
//  SIX_EXPENSE_REPORT.h
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIX_EXPENSE_REPORT : NSObject
@property (nonatomic,strong)NSString *IN_AREA_ID;//大区id
@property (nonatomic,strong)NSString *IN_DEPT_ID;//部门id

@property (nonatomic,strong)NSString *IN_START_DATE;//开始日期
@property (nonatomic,strong)NSString *IN_END_DATE;//结束日期
@property (nonatomic,strong)NSString *IN_CURRENT_PAGE;
@property (nonatomic,strong)NSString *IN_PAGE_SIZE;
@end
