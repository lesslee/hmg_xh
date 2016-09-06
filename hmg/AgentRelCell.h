//
//  AgentRelCell.h
//  hmg
//
//  Created by hongxianyu on 2016/7/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgentRelation.h"
@interface AgentRelCell : UITableViewCell
@property (nonatomic,strong)AgentRelation *model;

@property (weak, nonatomic) IBOutlet UILabel *agentRelName;

+ (instancetype) loadCellViewWithTableView1:(UITableView *) tableView;

@end
