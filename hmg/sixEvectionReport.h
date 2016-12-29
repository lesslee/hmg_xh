//
//  sixEvectionReport.h
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sixEvectionReport : NSObject
@property(nonatomic,strong)NSString *OUT_RESULT;
@property(nonatomic,strong)NSString *MON;
@property(nonatomic,strong)NSString *PROVINCE;
@property(nonatomic,strong)NSString *CITY;
@property(nonatomic,strong)NSString *EMP_NM;
@property(nonatomic,strong)NSString *E_COUNT;
@property(nonatomic,strong)NSString *COUNT_SALES;
@property(nonatomic,strong)NSString *TOTAL_RECORDS;


-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name;

@end
