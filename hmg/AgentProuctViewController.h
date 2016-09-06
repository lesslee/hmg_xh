//
//  AgentProuctViewController.h
//  hmg
//
//  Created by hongxianyu on 2016/7/22.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "MBProgressHUDManager.h"
#import "StoreType.h"
@interface AgentProuctViewController : UIViewController<ServiceHelperDelgate>
{
    MBProgressHUDManager *HUDManager;
}

@property ServiceHelper *serviceHelper;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) StoreType *type;
@property (nonatomic, strong) NSString *manager;
@property (nonatomic, strong) NSString *managerTel;
@property (nonatomic, strong) NSString *tel;
@end



