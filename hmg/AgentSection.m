//
//  AgentSection.m
//  hmg
//
//  Created by hongxianyu on 2016/7/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "AgentSection.h"

@implementation AgentSection
- (id)initWithID:(NSString *) ID andNAME:(NSString *) NAME{
    if (self = [super initWithID:ID andNAME:NAME]) {
        _agentRelArray1 = [[NSMutableArray alloc]init];
    }
    return self;
}
@end
