//
//  AgentRelCell.m
//  hmg
//
//  Created by hongxianyu on 2016/7/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "AgentRelCell.h"

@implementation AgentRelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype) loadCellViewWithTableView1:(UITableView *) tableView
{
    AgentRelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentRelCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AgentRelCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setModel:(AgentRelation *)model{

    _model = model;
    self.agentRelName.text = model.NAME;

}

@end
