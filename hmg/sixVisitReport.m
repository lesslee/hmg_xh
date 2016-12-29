//
//  sixVisitReport.m
//  hmg
//
//  Created by hongxianyu on 2016/12/20.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "sixVisitReport.h"
#import "GDataXMLNode.h"

@implementation sixVisitReport
@synthesize OUT_RESULT=_OUT_RESULT;
@synthesize DEPT_NM=_DEPT_NM;
@synthesize EMP_NM=_EMP_NM;
@synthesize REPORT_CNT=_REPORT_CNT;
@synthesize STORE_CNT=_STORE_CNT;
@synthesize TOTAL_RECORDS=_TOTAL_RECORDS;



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
        sixVisitReport *model2 = [[sixVisitReport alloc]init];
        if ([@"table1" isEqualToString:[item name]]) {
            NSArray *children = [item children];
            for (GDataXMLNode *item in children) {
                if ([@"OUT_RESULT" isEqualToString:[item name]]) {
                    [model2 setOUT_RESULT:[item stringValue]];
                }
                if ([@"DEPT_NM" isEqualToString: [item name]]) {
                    [model2 setDEPT_NM: [item stringValue]];
                }
                if ([@"EMP_NM" isEqualToString:[item name]]) {
                    [model2 setEMP_NM:[item stringValue]];
                }
                
                if ([@"REPORT_CNT" isEqualToString: [item name]]) {
                    [model2 setREPORT_CNT:[item stringValue]];
                }
                
                if ([@"STORE_CNT" isEqualToString:[item name]]) {
                    [model2 setSTORE_CNT:[item stringValue]];
                }
                if ([@"TOTAL_RECORDS" isEqualToString:[item name]]) {
                    [model2 setTOTAL_RECORDS:[item stringValue]];
                }
                            }
            NSLog(@"%@",item.stringValue);
            if (model2.TOTAL_RECORDS != nil)
                [array addObject:model2];
        }
    }
    
    return array;
}
@end
