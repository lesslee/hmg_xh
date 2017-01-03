//
//  ViewController.h
//  hmg
//
//  Created by Lee on 15/3/23.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUDManager.h"
#import "ServiceHelper.h"
@interface ViewController : UIViewController<ServiceHelperDelgate>
{
    MBProgressHUDManager *HUDManager;
    NSTimer *timer;
    long long expectedLength;
    long long currentLength;
}

@property(nonatomic,strong)UITextField *longinID;
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UIButton *longin;
@property(nonatomic,strong)UILabel *version;
@end

