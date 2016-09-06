//
//  XLRemoteCoreDataLoader.m
//  XLDataLoader
//
//  Created by Martin Barreto on 4/24/14.
//  Copyright (c) 2014 Xmartlabs. All rights reserved.
//

#import "XLRemoteCoreDataLoader.h"
#import <CoreData/CoreData.h>

@interface XLRemoteCoreDataLoader()

@property Class<XLRemoteDataLoaderCoreDataProviderProtocol> coreDataProviderClass;

@end

@implementation XLRemoteCoreDataLoader

-(id)initWithCoreDataProviderClass:(Class<XLRemoteDataLoaderCoreDataProviderProtocol>)class
{
    return [self initWithCoreDataProviderClass:class tag:nil];
}

-(id)initWithCoreDataProviderClass:(Class<XLRemoteDataLoaderCoreDataProviderProtocol>)class tag:(NSString *)tag
{
    self = [super initWithTag:tag];
    if (self){
        _coreDataProviderClass = class;
    }
    return self;
}

-(NSString *)URLString
{
    return [self.coreDataProviderClass remoteDataLoaderURLString:self];
}

-(NSDictionary *)parameters
{
    return [self.coreDataProviderClass remoteDataLoaderParameters:self];
}

-(void)successulDataLoad
{
    [super successulDataLoad];
    [self.coreDataProviderClass remoteDataLoaderCreateOrUpdateObjects:self];
}


-(NSString *)collectionKeyPath
{
    return [self.coreDataProviderClass remoteDataLoaderCollectionKeyPath:self];
}



@end
