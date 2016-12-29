//
//  sixInventoryReport.m
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "sixInventoryReport.h"
#import "GDataXMLNode.h"
@implementation sixInventoryReport
@synthesize OUT_RESULT=_OUT_RESULT;
@synthesize AGENT = _AGENT;
@synthesize PROVINCIAL= _PROVINCIAL;

@synthesize UZA=_UZA;
@synthesize UZA_AMT=_UZA_AMT;
@synthesize DENTI=_DENTI;
@synthesize DENTI_AMT = _DENTI_AMT;
@synthesize PHYLL=_PHYLL;
@synthesize PHYLL_AMT=_PHYLL_AMT;
@synthesize TGM = _TGM;
@synthesize TGM_AMT=_TGM_AMT;
@synthesize OTHER = _OTHER;
@synthesize OTHER_AMT=_OTHER_AMT;

@synthesize TOTAL_COUNT=_TOTAL_COUNT;
@synthesize TOTAL_COUNT_AMT = _TOTAL_COUNT_AMT;
@synthesize TURNOVER_DAY=_TURNOVER_DAY;
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
        sixInventoryReport *model3 = [[sixInventoryReport alloc]init];
        if ([@"table1" isEqualToString:[item name]]) {
            NSArray *children = [item children];
            for (GDataXMLNode *item in children) {
                if ([@"OUT_RESULT" isEqualToString:[item name]]) {
                    [model3 setOUT_RESULT:[item stringValue]];
                }
                if ([@"PROVINCIAL" isEqualToString: [item name]]) {
                    [model3 setPROVINCIAL: [item stringValue]];
                }
                if ([@"AGENT" isEqualToString:[item name]]) {
                    [model3 setAGENT:[item stringValue]];
                }
                
                if ([@"UZA" isEqualToString: [item name]]) {
                    [model3 setUZA:[item stringValue]];
                }
                if ([@"UZA_AMT" isEqualToString:[item name]]) {
                    [model3 setUZA_AMT:[item stringValue]];
                }
                if ([@"DENTI" isEqualToString:[item name]]) {
                    [model3 setDENTI:[item stringValue]];
                }
                if ([@"DENTI_AMT" isEqualToString:[item name]]) {
                    [model3 setDENTI_AMT:[item stringValue]];
                }
                if ([@"PHYLL" isEqualToString:[item name]]) {
                    [model3 setPHYLL:[item stringValue]];
                }
                if ([@"PHYLL_AMT" isEqualToString:[item name]]) {
                    [model3 setPHYLL_AMT:[item stringValue]];
                }
                if ([@"TGM" isEqualToString: [item name]]) {
                    [model3 setTGM: [item stringValue]];
                }
                if ([@"TGM_AMT" isEqualToString:[item name]]) {
                    [model3 setTGM_AMT:[item stringValue]];
                }
                
                if ([@"OTHER" isEqualToString: [item name]]) {
                    [model3 setOTHER:[item stringValue]];
                }
                if ([@"OTHER_AMT" isEqualToString:[item name]]) {
                    [model3 setOTHER_AMT:[item stringValue]];
                }
                if ([@"TOTAL_COUNT" isEqualToString:[item name]]) {
                    [model3 setTOTAL_COUNT:[item stringValue]];
                }
                if ([@"TOTAL_COUNT_AMT" isEqualToString:[item name]]) {
                    [model3 setTOTAL_COUNT_AMT:[item stringValue]];
                }
                if ([@"TURNOVER_DAY" isEqualToString:[item name]]) {
                    [model3 setTURNOVER_DAY:[item stringValue]];
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
