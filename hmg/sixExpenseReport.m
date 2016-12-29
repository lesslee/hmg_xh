//
//  sixExpenseReport.m
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "sixExpenseReport.h"
#import "GDataXMLNode.h"
@implementation sixExpenseReport
@synthesize OUT_RESULT=_OUT_RESULT;
@synthesize MON = _MON;
@synthesize PROVINCIAL= _PROVINCIAL;

@synthesize CURR_COST=_CURR_COST;
@synthesize APPLY_PRICE=_APPLY_PRICE;
@synthesize VER_TOTAL=_VER_TOTAL;
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
        sixExpenseReport *model3 = [[sixExpenseReport alloc]init];
        if ([@"table1" isEqualToString:[item name]]) {
            NSArray *children = [item children];
            for (GDataXMLNode *item in children) {
                if ([@"OUT_RESULT" isEqualToString:[item name]]) {
                    [model3 setOUT_RESULT:[item stringValue]];
                }
                if ([@"MON" isEqualToString: [item name]]) {
                    [model3 setMON: [item stringValue]];
                }
                if ([@"CURR_COST" isEqualToString:[item name]]) {
                    [model3 setCURR_COST:[item stringValue]];
                }
                
                if ([@"APPLY_PRICE" isEqualToString: [item name]]) {
                    [model3 setAPPLY_PRICE:[item stringValue]];
                }
                if ([@"VER_TOTAL" isEqualToString:[item name]]) {
                    [model3 setVER_TOTAL:[item stringValue]];
                }
                if ([@"PROVINCIAL" isEqualToString:[item name]]) {
                    [model3 setPROVINCIAL:[item stringValue]];
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
