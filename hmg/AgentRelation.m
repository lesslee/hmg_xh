//
//  AgentRelation.m
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "AgentRelation.h"
#import "GDataXMLNode.h"
@implementation AgentRelation
@synthesize OUT_RESULT=_OUT_RESULT;
@synthesize CD = _CD;
@synthesize NAME = _NAME;


-(NSString *) description
{
    return [NSString stringWithFormat:@"log<OUT_RESULT=%@,CD=%@,NAME=%@>",_OUT_RESULT,_CD,_NAME];
}

-(NSMutableArray  *)searchNodeToArray:(id)data nodeName:(NSString *)name
{
    NSMutableArray *array = [NSMutableArray array];
    NSError *error = nil;
    GDataXMLDocument *document;
    if ([data isKindOfClass:[NSString class]]) {
        data=[data stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"xmlns=\"%@\"",name] withString:@""];
        document= [[GDataXMLDocument alloc] initWithXMLString:data options:0 error:&error];
    } else {
        document=[[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
    }
    
    if (error) {
        
        return array;
    }
    
    NSString *searchStr=[NSString stringWithFormat:@"//%@",name];
    GDataXMLElement *rootNode =[document rootElement];
    NSArray *childs = [rootNode nodesForXPath:searchStr error:nil];
    for (GDataXMLNode *item in childs) {
        
        [array addObjectsFromArray:[self childsNodeToDictionary:item]];
    }
    
    return array;
    
}

-(NSMutableArray *)childsNodeToDictionary:(GDataXMLNode *)node
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSArray *childs =[node children];
    for(GDataXMLNode *item in childs){
        AgentRelation *model=[[AgentRelation alloc] init];
        if ([@"table1" isEqualToString:[item name]]) {
            NSArray *children =[item children];
            for (GDataXMLNode *item in children ) {
                if ([@"OUT_RESULT" isEqualToString:[item name]]) {
                    [model setOUT_RESULT:[item stringValue]];
                }
                if ([@"CD" isEqualToString:[item name]]) {
                    [model setCD:[item stringValue]];
                }
                if ([@"NAME" isEqualToString:[item name]]) {
                    [model setNAME:[item stringValue]];
                }
                
            }
            NSLog(@"%@333",item.stringValue);
            [array addObject:model];
        }
        
        
    }
    return array;
}

@end

