//
//  BrandAndPurpose.m
//  hmg
//
//  Created by Lee on 15/3/30.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import "Brand.h"

@implementation Brand
@synthesize ID=_ID;
@synthesize NAME=_NAME;

-(id) initWithID:(NSString *)ID andNAME:(NSString *)NAME
{
    if (self = [super init]) {
        self.ID=ID;
        self.NAME=NAME;
    }
    
    return self;
}



@end
