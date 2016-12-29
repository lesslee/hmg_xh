//
//  sixStoreCountReport.h
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sixStoreCountReport : NSObject
@property(nonatomic,strong)NSString *OUT_RESULT;
@property(nonatomic,strong)NSString *PROVINCIAL;
@property(nonatomic,strong)NSString *MON;
@property(nonatomic,strong)NSString *UZA;
@property(nonatomic,strong)NSString *DENTI;
@property(nonatomic,strong)NSString *PHYLL;
@property(nonatomic,strong)NSString *TGM;
@property(nonatomic,strong)NSString *OTHER;
@property(nonatomic,strong)NSString *TOTAL_COUNT;
@property(nonatomic,strong)NSString *YOY;
@property(nonatomic,strong)NSString *TOTAL_RECORDS;

-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name;
@end
