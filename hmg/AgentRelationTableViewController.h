//
//  AgentRelationTableViewController.h
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "XLFormRowDescriptor.h"
#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "MBProgressHUDManager.h"
#import "AgentSection.h"
@interface AgentRelationTableViewController : UIViewController<XLFormRowDescriptorViewController,UITableViewDataSource,UITableViewDelegate,ServiceHelperDelgate>
{
    MBProgressHUDManager *HUDManager;
}
@property (nonatomic ,strong) NSString *cooProductId1;
@property ServiceHelper *serviceHelper;
@property (nonatomic,weak) AgentSection *agentRelModel1;

@end

