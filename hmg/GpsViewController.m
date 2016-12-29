//
//  GpsViewController.m
//  hmg
//
//  Created by Lee on 15/3/26.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import "GpsViewController.h"
#import "UIView+SDAutoLayout.h"
#import "SoapHelper.h"
#import "Common.h"
#import "CommonResult.h"
#import "AppDelegate.h"
#import "Store.h"
#import "Agent.h"
#import "StoreTableViewController1.h"
#import "AgentTableViewController1.h"
#import "HMG_CHECK_IN_LAST.h"

#import "MKMapView+MapViewUtil.h"
#import <MapKit/MapKit.h>
@interface GpsViewController ()
{
    UILabel *checkInName;//考勤类型
                             
    UILabel *checkName1;//考勤名字
    UIButton *checkName2;//显示考勤名字
    UIButton *checkIn;//考勤按钮
    
    NSArray *_keys2;
    NSMutableDictionary *_source2;
    
    NSArray *_keys3;
    NSMutableDictionary *_source3;
    
    UISegmentedControl *segment;

    
}
@property (nonatomic) BMKMapView * mapView;
@property (nonatomic,strong)BMKLocationService *locService;
@property (nonatomic, strong)CLLocationManager *cllocationManager;
@end

@implementation GpsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    _keys2 = [[NSArray alloc]initWithObjects:@"StoreName2", @"StoreID2",@"GPS_LON2",@"GPS_LAT2",nil];
    
    _source2 = [[NSMutableDictionary alloc] initWithObjects:@[@"",@"",@"",@""] forKeys:_keys2];
    
    
    _keys3 = [[NSArray alloc]initWithObjects:@"AgentName3",@"AgentID3",@"GPS_LON3",@"GPS_LAT3",nil];
    
    _source3 = [[NSMutableDictionary alloc] initWithObjects:@[@"",@"",@"",@""] forKeys:_keys3];

    
    
    [self.navigationItem setTitle:@"考勤"];
    
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, mainW, mainH - 200)];
    [self.view addSubview:_mapView];
    
    if (![CLLocationManager locationServicesEnabled]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"定位服务可能尚未打开，请设置打开！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    
    [_locService startUserLocationService];
    
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.showMapScaleBar = YES;//比例尺
    _mapView.zoomLevel=17;//地图显示的级别
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
    checkInName = [[UILabel alloc]init];
    checkName1 = [[UILabel alloc]init];
    checkName2 = [[UIButton alloc]init];
    checkIn = [[UIButton alloc]init];
    
    checkInName.text = @"考勤类型";
    checkInName.font = Font;
    [self.view addSubview:checkInName];
    checkInName.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(_mapView, 5)
    .widthIs(80)
    .heightIs(40);
    
    
    NSArray *array = [NSArray arrayWithObjects:@"门店",@"经销商", nil];
        //初始化UISegmentedControl
    segment = [[UISegmentedControl alloc]initWithItems:array];
        //开始时默认选中下标(第一个下标默认是0)
    segment.selectedSegmentIndex = 0;
        //控件渲染色(也就是外观字体颜色)
    segment.tintColor = [UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0];
    
        //添加事件
    [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        //添加到视图
    [self.view addSubview:segment];
    segment.sd_layout
    .leftSpaceToView(checkInName, 60)
    .topSpaceToView(_mapView, 5)
    .rightSpaceToView(self.view, 10)
    .heightIs(35);
    
    checkName1.text = @"门店";
    checkName1.font = Font;
    [self.view addSubview:checkName1];
    checkName1.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(checkInName, 0)
    .widthIs(60)
    .heightIs(40);
    
   
    checkName2.backgroundColor = [UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0];

        //checkName2.titleLabel.font = Font;
    checkName2.titleLabel.textColor = [UIColor whiteColor];
     [checkName2 addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    checkName2.layer.cornerRadius = 5;
    [self.view addSubview:checkName2];
    checkName2.sd_layout
    .leftSpaceToView(checkName1, 20)
    .topSpaceToView(segment, 5)
    .rightSpaceToView(self.view, 10)
    .heightIs(40);
    
    
    [checkIn setTitle:@"考勤" forState:UIControlStateNormal];
    checkIn.titleLabel.textColor = [UIColor whiteColor];
    checkIn.backgroundColor = [UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0];
    checkIn.layer.cornerRadius = 5;
    [checkIn addTarget:self action:@selector(check1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkIn];
    
    checkIn.sd_layout
    .leftSpaceToView(self.view, 10)
    .topSpaceToView(checkName2, 5)
    .rightSpaceToView(self.view, 10)
    .heightIs(40);
    
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];


}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;// 此处记得不用的时候需要置nil，否则影响内存的释放
    
    if ([checkName1.text isEqualToString:@"门店"]) {
        
        [checkName2 setTitle:_source2[_keys2[0]] forState:UIControlStateNormal];
    }
    if ([checkName1.text isEqualToString:@"经销商"]) {
        
        [checkName2 setTitle:_source3[_keys3[0]] forState:UIControlStateNormal];
    }
    
}

    //点击不同分段就会有不同的事件
-(void)change:(UISegmentedControl *)sender{
   
    if (sender.selectedSegmentIndex == 0) {
        checkName1.text = @"门店";
        [checkName2 setTitle:@"" forState:UIControlStateNormal];
    }else if (sender.selectedSegmentIndex == 1) {
        checkName1.text = @"经销商";
        [checkName2 setTitle:@"" forState:UIControlStateNormal];
    }
}
-(void)btnPress{
    if (segment.selectedSegmentIndex == 0) {
        StoreTableViewController1 *stc = [[StoreTableViewController1 alloc]init];
        stc.dic2 = _source2;
        [self.navigationController pushViewController:stc animated:YES];

    } else if (segment.selectedSegmentIndex == 1){
        AgentTableViewController1  *atc = [[AgentTableViewController1 alloc]init];
        atc.dic3 = _source3;
        [self.navigationController pushViewController:atc animated:YES];
    }
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    
    NSLog(@"start locate");
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"当前位置%f,%f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;

    [_mapView updateLocationData:userLocation];
    double lat = userLocation.location.coordinate.latitude;
    double lon = userLocation.location.coordinate.longitude;
    self.LAT = [NSString stringWithFormat:@"%f",lat];
    self.LON = [NSString stringWithFormat:@"%f",lon];
    NSLog(@"%@,%@",self.LAT,self.LON);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
         NSDictionary *test = [place addressDictionary];
            // Country(国家) State(城市) SubLocality(区) Name全称
         NSLog(@"%@", [test objectForKey:@"Name"]);
            self.Address = [test objectForKey:@"Name"];

        }
    }];
}



/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}



//-(void)viewWillAppear:(BOOL)animated{
//    [_mapView viewWillAppear];
//    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _locService.delegate = self;// 此处记得不用的时候需要置nil，否则影响内存的释放
//}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义精度圈
- (void)customLocationAccuracyCircle {
    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
    param.accuracyCircleStrokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
    param.accuracyCircleFillColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3];
    [_mapView updateLocationViewWithParam:param];
}




//返回
-(void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)check1{
    [_locService stopUserLocationService];
//    if ([checkName2.titleLabel.text isEqualToString:@""]||[checkName2.titleLabel.text isEqualToString:@"Button"]) {
//        [HUDManager showMessage:@"请选择门店或经销商" duration:1];
//    }
    NSString *title = [checkName2 titleForState:UIControlStateNormal];
    NSLog(@"%@",title);
    if ([title isEqualToString:@"" ]) {
        [HUDManager showMessage:@"请选择门店或经销商" duration:1];
    }
    else{
       
            //[HUDManager showMessage:@"考勤中..."];
        Common *common=[[Common alloc] initWithView:self.view];
        
        if (common.isConnectionAvailable) {
           
            AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
            
            HMG_CHECK_IN_LAST *param=[[HMG_CHECK_IN_LAST alloc] init];
            param.IN_EMP_NO=appDelegate.userInfo1.EMP_NO;
            param.IN_GPS_LAT=self.LAT;
            
            param.IN_GPS_LON=self.LON;
            NSLog(@"%@,%@", param.IN_GPS_LAT ,param.IN_GPS_LON);
            
            double in_gps_lat = [param.IN_GPS_LAT doubleValue];
            double in_gps_lon = [param.IN_GPS_LON doubleValue];
            
            param.IN_ERROR_CODE = @"";
            if (segment.selectedSegmentIndex == 0) {
                    //Store *tmpStore= [self.form formRowWithTag:kSelectorStore1].value;
                param.IN_STORE_ID=_source2[_keys2[1]];
                param.IN_BENCHMARK_LON = _source2[_keys2[2]];
                param.IN_BENCHMARK_LAT = _source2[_keys2[3]];
                param.IN_ADDRESS = self.Address;
                NSLog(@"y-------%@,%@---------",param.IN_STORE_ID,param.IN_ADDRESS);
                NSLog(@"%@0-0,%@",param.IN_BENCHMARK_LON,param.IN_BENCHMARK_LAT);
                param.IN_AGENT_ID=@"";
                double in_gps_lat1 = [param.IN_BENCHMARK_LAT doubleValue];
                double in_gps_lon1 = [param.IN_BENCHMARK_LON doubleValue];
                
                if (in_gps_lat1 == 0 || in_gps_lon1 == 0) {
                    param.IN_DISTANCE = @"";
                    param.IN_DISTANCE_DESCRIPTION = @"无坐标";
                    NSLog(@"%@",param.IN_DISTANCE_DESCRIPTION);
                } else {
                    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(in_gps_lat,in_gps_lon));
                    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(in_gps_lat1,in_gps_lon1));
                    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
                    NSLog(@"%f",distance);
                    NSString *distance1 = [NSString stringWithFormat:@"%f",distance];
                    param.IN_DISTANCE = distance1;
                    param.IN_DISTANCE_DESCRIPTION = @"";
                    NSLog(@"%@",param.IN_DISTANCE_DESCRIPTION);
                }
                
            }else if(segment.selectedSegmentIndex == 1){
                
                param.IN_STORE_ID=@"";
                param.IN_AGENT_ID=_source3[_keys3[1]];
                param.IN_BENCHMARK_LON = _source3[_keys3[2]];
                param.IN_BENCHMARK_LAT = _source3[_keys3[3]];
                param.IN_ADDRESS = self.Address;
                NSLog(@"y-------%@---------",param.IN_ADDRESS);
                double in_gps_lat2 = [param.IN_BENCHMARK_LAT doubleValue];
                double in_gps_lon2 = [param.IN_BENCHMARK_LON doubleValue];
                NSLog(@"%f,%f",in_gps_lon2,in_gps_lat2);
                
                if (in_gps_lat2 == 0 || in_gps_lon2 == 0) {
                    param.IN_DISTANCE = @"";
                    param.IN_DISTANCE_DESCRIPTION = @"无坐标";
                    NSLog(@"%@",param.IN_DISTANCE_DESCRIPTION);
                } else {
                    
                    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(in_gps_lat,in_gps_lon));
                    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(in_gps_lat2,in_gps_lon2));
                    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
                    
                    NSString *distance1 = [NSString stringWithFormat:@"%f",distance];
                    param.IN_DISTANCE = distance1;
                    NSLog(@"%@",distance1);
                    
                    param.IN_DISTANCE_DESCRIPTION =@"";
                    NSLog(@"%@",param.IN_DISTANCE_DESCRIPTION);
                }
                
            }
            
            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:param];
            
            [self.serviceHelper resetQueue];
            
            ASIHTTPRequest *request1=[ServiceHelper commonSharedRequestMethod:@"HMG_CHECK_IN_LAST" soapMessage:paramXml];
            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"HMG_CHECK_IN_LAST",@"name", nil]];
            [self.serviceHelper addRequestQueue:request1];
            
            [self.serviceHelper startQueue];
        }
    }
}
-(void) finishQueueComplete
{
    
}


-(void) finishSingleRequestFailed:(NSError *)error userInfo:(NSDictionary *)dic
{
    [HUDManager showErrorWithMessage:@"网络错误" duration:1];
        //NSLog(@"---------------------------------");
        //NSLog(@"%@",error.localizedFailureReason);
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

    //请求成功，解析结果
-(void) finishSingleRequestSuccess:(NSData *)xml userInfo:(NSDictionary *)dic
{
    @try {
        if(self)
            {
            /**hmg考勤**/
            if ([@"HMG_CHECK_IN_LAST" isEqualToString:[dic objectForKey:@"name"]]) {
                
                CommonResult *result=[[CommonResult alloc] init];
                NSMutableArray *array =[[NSMutableArray alloc] init];
                [array addObjectsFromArray:[result searchNodeToArray:xml nodeName:@"NewDataSet"]];
                
                if ([result.OUT_RESULT isEqualToString:@"0"]) {
                    [HUDManager showSuccessWithMessage:@"考勤成功" duration:1 complection:^{
                        
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                    }];
                    
                }
                else
                    {
                    [HUDManager showSuccessWithMessage:result.OUT_RESULT_NM duration:1 complection:^{
                        NSLog(@"%@",result.OUT_RESULT_NM);
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
                    }];
                    }
                
                
            }
            }
    }
    @catch (NSException *exception) {
        NSLog(@"%@%@",[exception name],[exception reason]);
    }
    @finally {
        
    }
}

@end
