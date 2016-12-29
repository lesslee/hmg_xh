//
//  AchievementViewController.h
//  hmg
//
//  Created by hongxianyu on 2016/12/27.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "MBProgressHUDManager.h"
#import "CLLRefreshHeadController.h"

@interface AchievementViewController : UIViewController<ServiceHelperDelgate,UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate>
{
    MBProgressHUDManager *HUDManager;
}
@property ServiceHelper *serviceHelper;
@end


