//
//  Weekend_PromotionViewController.h
//  hmg
//
//  Created by hongxianyu on 2016/11/28.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreTableViewController1.h"
#import "ServiceHelper.h"
#define mainW [UIScreen mainScreen].bounds.size.width
#define mainH [UIScreen mainScreen].bounds.size.height
#define  Font [UIFont systemFontOfSize:18]; 
@interface Weekend_PromotionViewController : UIViewController<ServiceHelperDelgate>
{
    MBProgressHUDManager *HUDManager;
}

@property ServiceHelper *serviceHelper;

@property(nonatomic,strong)NSString *StoreName;
@property(nonatomic,strong)NSString *StoreID;
@property(nonatomic,strong)NSString *BrandName;
@property(nonatomic,strong)NSString *BrandID;
@end
