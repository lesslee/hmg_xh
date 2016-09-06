//
//  CooProduct+Additions.m
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "CooProduct+Additions.h"

@implementation CooProduct (Additions)
-(NSString *)formDisplayText
{
    return self.NAME;
}

-(id)formValue
{
    return self.ID;
}

@end
