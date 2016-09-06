//
//  CooProduct.h
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CooProduct : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *NAME;

-(id)initWithID:(NSString *)ID andNAME:(NSString *)NAME;
@end
