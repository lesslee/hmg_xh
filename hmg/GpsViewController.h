//
//  GpsViewController.h
//  hmg
//
//  Created by Lee on 15/3/26.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUDManager.h"

#import "ServiceHelper.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>


#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Utils/BMKGeometry.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#define mainW [UIScreen mainScreen].bounds.size.width
#define mainH [UIScreen mainScreen].bounds.size.height
#define  Font [UIFont systemFontOfSize:18]; 
@interface GpsViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,ServiceHelperDelgate>
{

  MBProgressHUDManager *HUDManager;
}
@property ServiceHelper *serviceHelper;
@property (nonatomic, retain) NSString * LON;//精度
@property (nonatomic, retain) NSString * LAT;//纬度
@property(nonatomic,strong)NSString *Address;//定位的地址
@end
