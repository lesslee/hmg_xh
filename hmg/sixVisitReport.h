//
//  sixVisitReport.h
//  hmg
//
//  Created by hongxianyu on 2016/12/20.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sixVisitReport : NSObject
{

    NSString *_OUT_RESULT;
    NSString *_DEPT_NM;
    NSString *_EMP_NM;
    NSString *_REPORT_CNT;
    NSString *_STORE_CNT;
    NSString *_TOTAL_RECORDS;
}
@property(nonatomic,strong)NSString *OUT_RESULT;
@property(nonatomic,strong)NSString *DEPT_NM;
@property(nonatomic,strong)NSString *EMP_NM;
@property(nonatomic,strong)NSString *REPORT_CNT;
@property(nonatomic,strong)NSString *STORE_CNT;
@property(nonatomic,strong)NSString *TOTAL_RECORDS;

-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name;
@end
