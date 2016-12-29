//
//  sixInventoryReport.h
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sixInventoryReport : NSObject
@property(nonatomic,strong)NSString *OUT_RESULT;
@property(nonatomic,strong)NSString *PROVINCIAL;
@property(nonatomic,strong)NSString *AGENT;
@property(nonatomic,strong)NSString *UZA;
@property(nonatomic,strong)NSString *UZA_AMT;
@property(nonatomic,strong)NSString *DENTI;
@property(nonatomic,strong)NSString *DENTI_AMT;
@property(nonatomic,strong)NSString *PHYLL;
@property(nonatomic,strong)NSString *PHYLL_AMT;

@property(nonatomic,strong)NSString *TGM;
@property(nonatomic,strong)NSString *TGM_AMT;
@property(nonatomic,strong)NSString *OTHER;
@property(nonatomic,strong)NSString *OTHER_AMT;
@property(nonatomic,strong)NSString *TOTAL_COUNT;
@property(nonatomic,strong)NSString *TOTAL_COUNT_AMT;
@property(nonatomic,strong)NSString *TURNOVER_DAY;
@property(nonatomic,strong)NSString *TOTAL_RECORDS;



-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name;
@end
