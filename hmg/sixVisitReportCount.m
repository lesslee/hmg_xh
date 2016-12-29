//
//  sixVisitReportCount.m
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "sixVisitReportCount.h"
#import "GDataXMLNode.h"
@implementation sixVisitReportCount
@synthesize OUT_RESULT=_OUT_RESULT;
@synthesize STORE_NM = _STORE_NM;
@synthesize DEPT_NM=_DEPT_NM;
@synthesize EMP_NM=_EMP_NM;
@synthesize REPORT_CNT=_REPORT_CNT;
@synthesize STORE_LEVEL=_STORE_LEVEL;
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
        sixVisitReportCount *model3 = [[sixVisitReportCount alloc]init];
        if ([@"table1" isEqualToString:[item name]]) {
            NSArray *children = [item children];
            for (GDataXMLNode *item in children) {
                if ([@"OUT_RESULT" isEqualToString:[item name]]) {
                    [model3 setOUT_RESULT:[item stringValue]];
                }
                if ([@"DEPT_NM" isEqualToString: [item name]]) {
                    [model3 setDEPT_NM: [item stringValue]];
                }
                if ([@"EMP_NM" isEqualToString:[item name]]) {
                    [model3 setEMP_NM:[item stringValue]];
                }
                
                if ([@"REPORT_CNT" isEqualToString: [item name]]) {
                    [model3 setREPORT_CNT:[item stringValue]];
                }
                if ([@"STORE_LEVEL" isEqualToString:[item name]]) {
                    [model3 setSTORE_LEVEL:[item stringValue]];
                }
                if ([@"STORE_NM" isEqualToString:[item name]]) {
                    [model3 setSTORE_NM:[item stringValue]];
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
