//
//  sixExpenseReport.h
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sixExpenseReport : NSObject
@property(nonatomic,strong)NSString *OUT_RESULT;
@property(nonatomic,strong)NSString *PROVINCIAL;
@property(nonatomic,strong)NSString *MON;
@property(nonatomic,strong)NSString *CURR_COST;
@property(nonatomic,strong)NSString *APPLY_PRICE;
@property(nonatomic,strong)NSString *VER_TOTAL;
@property(nonatomic,strong)NSString *TOTAL_RECORDS;

-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name;
@end
