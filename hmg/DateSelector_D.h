    //
    //  DateSelector_D.h
    //  hmg
    //
    //  Created by Hongxianyu on 16/4/19.
    //  Copyright © 2016年 com.lz. All rights reserved.
    //

#import <Foundation/Foundation.h>
#import "XLForm.h"
#import "XLFormViewController.h"
#import "MBProgressHUDManager.h"
#import "weekendDelegate.h"
#import "Store.h"
#import "Brand1.h"
//@protocol weekendDelegate1 <NSObject>
//
//-(void) getSTORE:(Store *) STORE andBRAND:(Brand1 *) BRAND andSTARTDATE:(NSString *) STARTDATE andENDDATE:(NSString *) ENDDATE;
//@end
@interface DateSelector_D : XLFormViewController
{
    MBProgressHUDManager *HUDManager;
}
@property NSObject <weekendDelegate>* trendDelegate;

@end
