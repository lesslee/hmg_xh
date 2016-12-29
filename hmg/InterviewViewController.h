//
//  InterviewViewController.h
//  hmg
//
//  Created by hongxianyu on 2016/12/16.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "MBProgressHUDManager.h"
#import "CLLRefreshHeadController.h"


@interface InterviewViewController : UIViewController<ServiceHelperDelgate,UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUDManager *HUDManager;
}
@property ServiceHelper *serviceHelper;
@property(nonatomic,strong)NSString *StoreName;
@property(nonatomic,strong)NSString *StoreID;
@end
