//
//  CooProduct.m
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "CooProduct.h"

@implementation CooProduct
@synthesize NAME = _NAME;
@synthesize ID = _ID;

-(id)initWithID:(NSString *)ID andNAME:(NSString *)NAME{

    if (self = [super init]) {
        self.ID = ID;
        self.NAME = NAME;
    }
    return  self;
}
@end
