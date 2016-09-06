//
//  StoreType.h
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreType : NSObject
@property(nonatomic,strong)NSString *NAME;
@property(nonatomic,strong)NSString *ID;

-(id)initWithID:(NSString *)ID andNAME:(NSString *)NAME;
@end
