//
//  ExpenseCell.h
//  hmg
//
//  Created by hongxianyu on 2016/12/19.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpenseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Province;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *Surplus;
@property (weak, nonatomic) IBOutlet UILabel *Already;
@property (weak, nonatomic) IBOutlet UILabel *Verification;

@end
