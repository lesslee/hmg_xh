//
//  sixEvectionReport.m
//  hmg
//
//  Created by hongxianyu on 2016/12/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "sixEvectionReport.h"
#import "GDataXMLNode.h"
@implementation sixEvectionReport

@synthesize OUT_RESULT=_OUT_RESULT;
@synthesize MON = _MON;
@synthesize PROVINCE=_PROVINCE;
@synthesize CITY=_CITY;
@synthesize EMP_NM=_EMP_NM;
@synthesize E_COUNT=_E_COUNT;
@synthesize TOTAL_RECORDS=_TOTAL_RECORDS;
@synthesize COUNT_SALES = _COUNT_SALES;

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
        sixEvectionReport *model3 = [[sixEvectionReport alloc]init];
        if ([@"table1" isEqualToString:[item name]]) {
            NSArray *children = [item children];
            for (GDataXMLNode *item in children) {
                if ([@"OUT_RESULT" isEqualToString:[item name]]) {
                    [model3 setOUT_RESULT:[item stringValue]];
                }
                if ([@"MON" isEqualToString: [item name]]) {
                    [model3 setMON: [item stringValue]];
                }
                if ([@"EMP_NM" isEqualToString:[item name]]) {
                    [model3 setEMP_NM:[item stringValue]];
                }
                
                if ([@"PROVINCE" isEqualToString: [item name]]) {
                    [model3 setPROVINCE:[item stringValue]];
                }
                if ([@"CITY" isEqualToString:[item name]]) {
                    [model3 setCITY:[item stringValue]];
                }
                if ([@"E_COUNT" isEqualToString:[item name]]) {
                    [model3 setE_COUNT:[item stringValue]];
                }
                if ([@"TOTAL_RECORDS" isEqualToString:[item name]]) {
                    [model3 setTOTAL_RECORDS:[item stringValue]];
                }
                if ([@"COUNT_SALES" isEqualToString:[item name]]) {
                    [model3 setCOUNT_SALES:[item stringValue]];
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
