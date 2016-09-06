//
//  UploadViewController.h
//  hmg
//
//  Created by Lee on 15/5/19.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUDManager.h"
#import "ServiceHelper.h"

@interface UploadViewController : UIViewController<ServiceHelperDelgate>
{
    MBProgressHUDManager *HUDManager;
}
//@property (strong, nonatomic) IBOutlet UIView *view;
@property(nonatomic,strong)NSString *reportId;//照片关联的日报id
@property ServiceHelper *serviceHelper;

@end
