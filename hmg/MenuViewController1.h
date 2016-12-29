//
//  MenuViewController1.h
//  hmg
//
//  Created by hongxianyu on 2016/11/30.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "MBProgressHUDManager.h"
#import "ServiceHelper.h"
@interface MenuViewController1 : UIViewController<ServiceHelperDelgate>
{
    MBProgressHUDManager *HUDManager;
    
}
@property ServiceHelper *serviceHelper;



@end
