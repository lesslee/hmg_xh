//
//  sixPerformanceLX.m
//  hmg
//
//  Created by hongxianyu on 2016/12/26.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "sixPerformanceLX.h"
#import "GDataXMLNode.h"
@implementation sixPerformanceLX
@synthesize OUT_RESULT=_OUT_RESULT;
@synthesize DEPT_NM= _DEPT_NM;
@synthesize AGENT_NM = _AGENT_NM;
@synthesize TARGET = _TARGET;
@synthesize MON = _MON;
@synthesize UZA=_UZA;
@synthesize DENTI=_DENTI;
@synthesize PHYLL=_PHYLL;
@synthesize OTHER = _OTHER;
@synthesize TOTAL = _TOTAL;
@synthesize APPROVAL = _APPROVAL;
@synthesize TONGBI = _TONGBI;
@synthesize TOTAL_RECORDS = _TOTAL_RECORDS;

-(NSMutableArray *)searchNodeToArray:(id)data nodeName:(NSString *)name
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
    
    for (GDataXMLNode *item in childs) {
        sixPerformanceLX *model3 = [[sixPerformanceLX alloc]init];
        if ([@"table1" isEqualToString:[item name]]) {
            NSArray *children = [item children];
            for (GDataXMLNode *item in children) {
                if ([@"OUT_RESULT" isEqualToString:[item name]]) {
                    [model3 setOUT_RESULT:[item stringValue]];
                }
                if ([@"DEPT_NM" isEqualToString:[item name]]) {
                    [model3 setDEPT_NM:[item stringValue]];
                }
                if ([@"AGENT_NM" isEqualToString:[item name]]) {
                    [model3 setAGENT_NM:[item stringValue]];
                }
                if ([@"TARGET" isEqualToString:[item name]]) {
                    [model3 setTARGET:[item stringValue]];
                }
                if ([@"MON" isEqualToString: [item name]]) {
                    [model3 setMON: [item stringValue]];
                }
                if ([@"UZA" isEqualToString:[item name]]) {
                    [model3 setUZA:[item stringValue]];
                }
                
                if ([@"DENTI" isEqualToString: [item name]]) {
                    [model3 setDENTI:[item stringValue]];
                }
                if ([@"PHYLL" isEqualToString:[item name]]) {
                    [model3 setPHYLL:[item stringValue]];
                }
                if ([@"TGM" isEqualToString:[item name]]) {
                    [model3 setTGM:[item stringValue]];
                }
                if ([@"OTHER" isEqualToString:[item name]]) {
                    [model3 setOTHER:[item stringValue]];
                }
                if ([@"TOTAL" isEqualToString:[item name]]) {
                    [model3 setTOTAL:[item stringValue]];
                }
                if ([@"APPROVAL" isEqualToString:[item name]]) {
                    [model3 setAPPROVAL:[item stringValue]];
                }
                if ([@"TONGBI" isEqualToString:[item name]]) {
                    [model3 setTONGBI:[item stringValue]];
                }
                if ([@"TOTAL_RECORDS" isEqualToString:[item name]]) {
                    [model3 setTOTAL_RECORDS:[item stringValue]];
                }
            }
            NSLog(@"%@",item.stringValue);
            if (model3.TOTAL_RECORDS != nil)
            [array addObject:model3];
        }
    }
    
    return array;
}

@end
