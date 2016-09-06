//
//  AgentRelation+Additions.m
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "AgentRelation+Additions.h"

@implementation AgentRelation (Additions)
-(NSString *)formDisplayText
{
    return self.NAME;
}

-(id)formValue
{
    return self.CD;
}
@end
