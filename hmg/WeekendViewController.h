    //
    //  WeekendViewController.h
    //  hmg
    //
    //  Created by Hongxianyu on 16/4/14.
    //  Copyright © 2016年 com.lz. All rights reserved.
    //

#import "ServiceHelper.h"
#import "MBProgressHUDManager.h"
#import "CLLRefreshHeadController.h"
#import <UIKit/UIKit.h>
    //#import "WeekendViewCell.h"
#import "DateSelector_D.h"
@class WeekendViewController;
@interface WeekendViewController : UIViewController<ServiceHelperDelgate,NSCoding,UITableViewDataSource,UITableViewDelegate,  CLLRefreshHeadControllerDelegate,weekendDelegate>
{
    MBProgressHUDManager *HUDManager;
}
@property ServiceHelper *serviceHelper;

@end
