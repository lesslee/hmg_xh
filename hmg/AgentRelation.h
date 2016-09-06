//
//  AgentRelation.h
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgentRelation : NSObject

@property(nonatomic,strong)NSString *OUT_RESULT;
@property(nonatomic,strong)NSString *CD;
@property(nonatomic,strong)NSString *NAME;

-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name;
@end
