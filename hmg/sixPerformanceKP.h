//
//  sixPerformanceKP.h
//  hmg
//
//  Created by hongxianyu on 2016/12/26.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sixPerformanceKP : NSObject
@property(nonatomic,strong)NSString *OUT_RESULT;
@property(nonatomic,strong)NSString *DEPT_NM;
@property(nonatomic,strong)NSString *AGENT_NM;
@property(nonatomic,strong)NSString *TARGET;
@property(nonatomic,strong)NSString *MON;
@property(nonatomic,strong)NSString *UZA;
@property(nonatomic,strong)NSString *DENTI;
@property(nonatomic,strong)NSString *PHYLL;
@property(nonatomic,strong)NSString *TGM;
@property(nonatomic,strong)NSString *OTHER;
@property(nonatomic,strong)NSString *TOTAL;
@property(nonatomic,strong)NSString *APPROVAL;
@property(nonatomic,strong)NSString *TONGBI;
@property(nonatomic,strong)NSString *TOTAL_RECORDS;
-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name;
@end
