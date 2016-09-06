//
//  HMG_SAVE_STORE.m
//  hmg
//
//  Created by hongxianyu on 2016/7/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "HMG_SAVE_STORE.h"

@implementation HMG_SAVE_STORE
@synthesize IN_EMP_NO =_IN_EMP_NO;
@synthesize IN_DEPT_CD=_IN_DEPT_CD;
@synthesize IN_STORE_NM =_IN_STORE_NM;
@synthesize IN_STORE_TYPE=_IN_STORE_TYPE;
@synthesize IN_STORE_LEADER =_IN_STORE_LEADER;
@synthesize IN_STORE_MANAGER_TEL=_IN_STORE_MANAGER_TEL;
@synthesize IN_STORE_TEL =_IN_STORE_TEL;
@synthesize IN_PRODUCTS=_IN_PRODUCTS;
@synthesize IN_AGENTS=_IN_AGENTS;
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        _IN_DEPT_CD=[aDecoder decodeObjectForKey:@"IN_DEPT_CD"];
        _IN_EMP_NO=[aDecoder decodeObjectForKey:@"IN_EMP_NO"];
        
        _IN_STORE_NM=[aDecoder decodeObjectForKey:@"IN_STORE_NM"];
        _IN_STORE_TYPE=[aDecoder decodeObjectForKey:@"IN_STORE_TYPE"];
        
        _IN_STORE_LEADER=[aDecoder decodeObjectForKey:@"IN_STORE_LEADER"];
        _IN_STORE_MANAGER_TEL=[aDecoder decodeObjectForKey:@"IN_STORE_MANAGER_TEL"];
        
        _IN_STORE_TEL=[aDecoder decodeObjectForKey:@"IN_STORE_TEL"];
        _IN_PRODUCTS=[aDecoder decodeObjectForKey:@"IN_PRODUCTS"];
        
        _IN_AGENTS=[aDecoder decodeObjectForKey:@"IN_AGENTS"];
        
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_IN_EMP_NO forKey:@"IN_EMP_NO"];
    [aCoder encodeObject:_IN_DEPT_CD forKey:@"IN_DEPT_CD"];
    
    [aCoder encodeObject:_IN_STORE_NM forKey:@"IN_STORE_NM"];
    [aCoder encodeObject:_IN_STORE_TYPE forKey:@"IN_STORE_TYPE"];
    [aCoder encodeObject:_IN_STORE_LEADER forKey:@"IN_STORE_LEADER"];
    [aCoder encodeObject:_IN_STORE_MANAGER_TEL forKey:@"IN_STORE_MANAGER_TEL"];
    [aCoder encodeObject:_IN_STORE_TEL forKey:@"IN_STORE_TEL"];
    [aCoder encodeObject:_IN_PRODUCTS forKey:@"IN_PRODUCTS"];
    [aCoder encodeObject:_IN_AGENTS forKey:@"IN_AGENTS"];

}
@end
