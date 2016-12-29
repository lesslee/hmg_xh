//
//  sixStoreCountReport.m
//  hmg
//
//  Created by hongxianyu on 2016/12/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "sixStoreCountReport.h"
#import "GDataXMLNode.h"
@implementation sixStoreCountReport
@synthesize OUT_RESULT=_OUT_RESULT;
@synthesize MON = _MON;
@synthesize PROVINCIAL= _PROVINCIAL;

@synthesize UZA=_UZA;
@synthesize DENTI=_DENTI;
@synthesize PHYLL=_PHYLL;
@synthesize OTHER = _OTHER;
@synthesize TOTAL_COUNT = _TOTAL_COUNT;
@synthesize YOY = _YOY;
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
        sixStoreCountReport *model3 = [[sixStoreCountReport alloc]init];
        if ([@"table1" isEqualToString:[item name]]) {
            NSArray *children = [item children];
            for (GDataXMLNode *item in children) {
                if ([@"OUT_RESULT" isEqualToString:[item name]]) {
                    [model3 setOUT_RESULT:[item stringValue]];
                }
                if ([@"PROVINCIAL" isEqualToString:[item name]]) {
                    [model3 setPROVINCIAL:[item stringValue]];
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
                if ([@"TOTAL_COUNT" isEqualToString:[item name]]) {
                    [model3 setTOTAL_COUNT:[item stringValue]];
                }
                if ([@"YOY" isEqualToString:[item name]]) {
                    [model3 setYOY:[item stringValue]];
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

