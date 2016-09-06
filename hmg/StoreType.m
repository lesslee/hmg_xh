//
//  StoreType.m
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "StoreType.h"

@implementation StoreType
@synthesize NAME = _NAME;
@synthesize ID = _ID;


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.NAME forKey:@"NAME"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.NAME = [aDecoder decodeObjectForKey:@"NAME"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
       
    }
    return self;
}



-(id)initWithID:(NSString *)ID andNAME:(NSString *)NAME{

    if (self = [super init]) {
        self.ID = ID;
        self.NAME = NAME;
    }
    return self;
}

@end
