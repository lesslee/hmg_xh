//
//  sixVisitReportCount.h
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sixVisitReportCount : NSObject
@property(nonatomic,strong)NSString *OUT_RESULT;
@property(nonatomic,strong)NSString *DEPT_NM;
@property(nonatomic,strong)NSString *STORE_NM;
@property(nonatomic,strong)NSString *EMP_NM;
@property(nonatomic,strong)NSString *STORE_LEVEL;
@property(nonatomic,strong)NSString *REPORT_CNT;
@property(nonatomic,strong)NSString *TOTAL_RECORDS;

-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name;

@end
