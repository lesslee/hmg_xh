    //
    //  StoreTableViewController.h
    //  hmg
    //
    //  Created by Lee on 15/3/27.
    //  Copyright (c) 2015年 com.lz. All rights reserved.
    //


#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "CLLRefreshHeadController.h"
#import "MBProgressHUDManager.h"

@interface StoreTableViewController1 : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceHelperDelgate,CLLRefreshHeadControllerDelegate>

{
    MBProgressHUDManager *HUDManager;
}
@property ServiceHelper *serviceHelper;
    //@property(nonatomic,strong)UIButton *button2;

@property(nonatomic,strong)NSMutableDictionary *dic1;
@property(nonatomic,strong)NSMutableDictionary *dic2;
@property(nonatomic,strong)NSMutableDictionary *dicVisit;
@end
