//
//  AgentTableViewController1.h
//  hmg
//
//  Created by hongxianyu on 2016/12/15.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "XLFormRowDescriptor.h"
#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "CLLRefreshHeadController.h"
#import "MBProgressHUDManager.h"
@interface AgentTableViewController1 :  UIViewController<XLFormRowDescriptorViewController,UITableViewDataSource,UITableViewDelegate,ServiceHelperDelgate,CLLRefreshHeadControllerDelegate>
{
    MBProgressHUDManager *HUDManager;
}
@property ServiceHelper *serviceHelper;
@property(nonatomic,strong)NSMutableDictionary *dic3;

@property(nonatomic,strong)NSMutableDictionary *stockDic;

@end