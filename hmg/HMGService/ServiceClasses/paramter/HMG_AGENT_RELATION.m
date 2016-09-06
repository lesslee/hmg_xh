//
//  HMG_AGENT_RELATION.m
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "HMG_AGENT_RELATION.h"

@implementation HMG_AGENT_RELATION
@synthesize IN_EMP_NO =_IN_EMP_NO;
@synthesize IN_AGENT_PRODUCT=_IN_AGENT_PRODUCT;

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        _IN_AGENT_PRODUCT=[aDecoder decodeObjectForKey:@"IN_AGENT_PRODUCT"];
        _IN_EMP_NO=[aDecoder decodeObjectForKey:@"IN_EMP_NO"];
        
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_IN_EMP_NO forKey:@"IN_EMP_NO"];
    [aCoder encodeObject:_IN_AGENT_PRODUCT forKey:@"IN_AGENT_PRODUCT"];
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"IN_AGENT_PRODUCT=%@,IN_EMP_NO=%@>",_IN_AGENT_PRODUCT,_IN_EMP_NO];
}

@end


