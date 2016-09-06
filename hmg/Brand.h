//
//  BrandAndPurpose.h
//  hmg
//
//  Created by Lee on 15/3/30.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject

@property (nonatomic, retain) NSString * ID;
@property (nonatomic, retain) NSString * NAME;

- (id)initWithID:(NSString *) ID andNAME:(NSString *) NAME;

@end
