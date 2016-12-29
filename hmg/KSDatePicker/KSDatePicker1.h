//
//  KSDatePicker1.h
//  hmg
//
//  Created by hongxianyu on 2016/12/20.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSDatePickerAppearance.h"
@interface KSDatePicker1 : UIView
@property (nonatomic, strong, readonly)KSDatePickerAppearance* appearance;

- (void)reloadAppearance;

- (void)show;
- (void)hidden;
@end
