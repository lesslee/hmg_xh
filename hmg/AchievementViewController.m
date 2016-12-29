    //
    //  AchievementViewController.m
    //  hmg
    //
    //  Created by hongxianyu on 2016/12/16.
    //  Copyright © 2016年 com.lz. All rights reserved.
    //

#import "AchievementViewController.h"
#import "sixPerformanceKP.h"
#import "SIX_PERFORMANCE_KP.h"
#import "sixPerformanceLX.h"
#import "SIX_PERFORMANCE_LX.h"
#import "KPCell.h"
#import "DOPDropDownMenu.h"
#import "HMG_AREA_QUERY.h"
#import "HMG_DEPT_QUERY.h"

#import "AppDelegate.h"
#import "SoapHelper.h"
#import "ServiceHelper.h"
#import "DeptModel.h"

#import "AreaModel.h"

#import "Common.h"
#import "ASINetworkQueue.h"

#import "UIView+SDAutoLayout.h"
#import "KSDatePicker.h"
#import "KSDatePicker1.h"

ASIHTTPRequest *request1;
const int pageSize=50;

@interface AchievementViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,CLLRefreshHeadControllerDelegate>

{
    int currentPage;
    int Max_Count;
    BOOL isRefresh;
    UILabel *StoreDate;
    UIButton *startDate1;
    UIButton *endDate1;
}
@property(nonatomic,strong)UISegmentedControl *segment;

@property (nonatomic,strong)CLLRefreshHeadController *refreshControll;

    //大区
@property (nonatomic, strong) NSMutableArray *areas;
    //部门
@property (nonatomic, strong) NSMutableArray *depts;

    //开票数量集合
@property (nonatomic, strong) NSMutableArray *KPS;
    //流向数量集合
@property(nonatomic,strong)NSMutableArray *LXS;


@property(nonatomic,strong)NSMutableArray *dataSource;
#pragma 走访查询参数
@property (nonatomic, strong) AreaModel *selectArea;
@property (nonatomic, strong) DeptModel *selectDept;
@property (nonatomic) NSInteger pageSize;

@end
UITableView *tableView1;
UIScrollView *scrollView;

BOOL KPcanBack;
@implementation AchievementViewController
NSInteger lastColumn9 = -1;
NSInteger lastRow9 = -1;

- (CLLRefreshHeadController *)refreshControll
{
    if (!_refreshControll) {
        _refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:tableView1 viewDelegate:self];
    }
    return _refreshControll;
}
#pragma mark-
#pragma mark- CLLRefreshHeadContorllerDelegate
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnScrollViews;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];
    self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 73,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 142)];
    self.KPS = [[NSMutableArray alloc]init];
    self.LXS = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [self colorWithHexString:@"#e9f1f6" alpha:1];
    
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView1];
    
    tableView1.dataSource=self;
    tableView1.delegate=self;
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self scrollViewDidScroll:scrollView];
    
    AreaModel *area=[[AreaModel alloc] init];
    area.DEPT_ID=@"0";
    area.DEPT_NM=@"大区";
    
    DeptModel *dept=[[DeptModel alloc] init];
    dept.DEPT_ID=@"0";
    dept.DEPT_NM=@"部门";
    self.areas = [NSMutableArray arrayWithObjects:area, nil];
    
    self.depts = [NSMutableArray arrayWithObjects:dept, nil];
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:40];
    menu.tag=1111;
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    
    
    StoreDate = [[UILabel alloc]init];
    
    startDate1 = [[UIButton alloc]init];
    endDate1 = [[UIButton alloc]init];
    
    
    StoreDate.text = @"日期";
    [self.view addSubview:StoreDate];
    StoreDate.sd_layout
    .leftSpaceToView(self.view, 5)
    .topSpaceToView(menu, 1)
    .widthIs(80)
    .heightIs(30);
    
    
    
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    fmt.dateFormat=@"yyyyMM";
    
    [startDate1 setTitle:[fmt stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    
    [startDate1 addTarget:self action:@selector(startDateBtnVistit:) forControlEvents:UIControlEventTouchUpInside];
    startDate1.layer.cornerRadius = 5;
    startDate1.backgroundColor = [self colorWithHexString:@"#7C7C7C" alpha:0.5];
    [self.view addSubview:startDate1];
    
    
    startDate1.sd_layout
    .leftSpaceToView(StoreDate, 5)
    .topSpaceToView(menu, 1)
    .widthIs((self.view.size.width - StoreDate.width - 10 - 10)/2)
    .heightIs(30);
    
    [endDate1 setTitle:[fmt stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [endDate1 addTarget:self action:@selector(endDateBtnVistit:) forControlEvents:UIControlEventTouchUpInside];
    endDate1.layer.cornerRadius = 5;
    endDate1.backgroundColor = [self colorWithHexString:@"#7C7C7C" alpha:0.5];
    [self.view addSubview:endDate1];
    
    endDate1.sd_layout
    .leftSpaceToView(startDate1, 10)
    .topSpaceToView(menu, 1)
    .rightSpaceToView(self.view,5)
    .heightIs(30);
    [self areaQuery];
    
    [self.refreshControll startPullDownRefreshing];
}


-(UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
        //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        // String should be 6 or 8 characters
    if ([cString length] < 6)
        {
        return [UIColor clearColor];
        }
        // strip 0X if it appears
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
        {
        cString = [cString substringFromIndex:2];
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
        {
        cString = [cString substringFromIndex:1];
        }
    if ([cString length] != 6)
        {
        return [UIColor clearColor];
        }
    
        // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
        //r
    NSString *rString = [cString substringWithRange:range];
        //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
        //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
        // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

-(void)goBackMenu{
    [request1 clearDelegatesAndCancel];
    [self.serviceHelper resetQueue];
    self.serviceHelper=nil;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.refreshControll startPullDownRefreshing];
    if (!self.serviceHelper) {
        
        self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    }
    
    
    NSArray *array = [NSArray arrayWithObjects:@"开票",@"流向", nil];
        //初始化UISegmentedControl
    _segment = [[UISegmentedControl alloc]initWithItems:array];
        //开始时默认选中下标(第一个下标默认是0)
    
    _segment.selectedSegmentIndex = 0;
        //添加事件
    [_segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = _segment;
    
    
    
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBackMenu)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"开票查询" style:UIBarButtonItemStyleBordered target:self action:@selector(searchButtonHandle)];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
}
    //点击不同分段就会有不同的事件
-(void)change:(UISegmentedControl *)sender{
    
    if (sender.selectedSegmentIndex == 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开票查询" style:UIBarButtonItemStyleBordered target:self action:@selector(searchButtonHandle)];
        [self.KPS removeAllObjects];
        [tableView1 reloadData];
     [self.refreshControll startPullDownRefreshing];
    }else if (sender.selectedSegmentIndex == 1) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"流向查询" style:UIBarButtonItemStyleBordered target:self action:@selector(searchButtonHandle1)];
        [self.LXS removeAllObjects];
        [tableView1 reloadData];
        [self.refreshControll startPullDownRefreshing];
        
    }
}

-(void)startDateBtnVistit:(UIButton *)sender{
        //x,y 值无效，默认是居中的
    KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 300)];
    
    picker.appearance.radius = 5;
    
        //设置回调
    picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
        
        if (buttonType == KSDatePickerButtonCommit) {
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMM"];
            
            [sender setTitle:[formatter stringFromDate:currentDate] forState:UIControlStateNormal];
        }
    };
        // 显示
    [picker show];
    
}
-(void)endDateBtnVistit:(UIButton *)sender{
        //x,y 值无效，默认是居中的
    KSDatePicker1* picker = [[KSDatePicker1 alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 300)];
    
    picker.appearance.radius = 5;
    
        //设置回调
    picker.appearance.resultCallBack1 = ^void(KSDatePicker1* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
        
        if (buttonType == KSDatePickerButtonCommit) {
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMM"];
            
            [sender setTitle:[formatter stringFromDate:currentDate] forState:UIControlStateNormal];
        }
    };
        // 显示
    [picker show];
    
}
    //加载大区
-(void) areaQuery
{
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    
    HMG_AREA_QUERY *areaParam=[[HMG_AREA_QUERY alloc] init];
    [areaParam setIN_DEPT_ID:appDelegate.userInfo1.DEPT_CD];
    [areaParam setIN_IS_FCU:appDelegate.userInfo1.EMP_TYPE];
    NSString *paramXml=[SoapHelper objToDefaultSoapMessage:areaParam];
    
    [self.serviceHelper resetQueue];
    
    request1=[ServiceHelper commonSharedRequestMethod:@"HMG_AREA_QUERY" soapMessage:paramXml];
    [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"HMG_AREA_QUERY",@"name", nil]];
    [self.serviceHelper addRequestQueue:request1];
    
    [self.serviceHelper startQueue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_segment.selectedSegmentIndex == 0) {
        return self.KPS.count;
    }else {
        
        return self.LXS.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 160;
    
}
    //去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == tableView1)
        {
        CGFloat sectionHeaderHeight = 1; //sectionHeaderHeight
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            
        }
        }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KPCell  * cell = [KPCell cellWithTableView:tableView1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.masksToBounds=YES;
    return cell;
}


    //-------------------------------
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_segment.selectedSegmentIndex == 0) {
        if (indexPath != nil) {
            KPCell *tempCell=(KPCell*)cell;
            
            sixPerformanceKP *reportModel=(sixPerformanceKP*)[self.KPS objectAtIndex:indexPath.section];
            
            tempCell.Provincial.text = reportModel.DEPT_NM;
                // NSString *mb =
            tempCell.mubiao.text = reportModel.TARGET;
            tempCell.date.text = reportModel.MON;
            tempCell.uzaNU.text = reportModel.UZA;
            tempCell.dentilNU.text = reportModel.DENTI;
            tempCell.phyllNU.text = reportModel.PHYLL;
            tempCell.tgmNU.text = reportModel.TGM;
            tempCell.qtNU.text = reportModel.OTHER;
            tempCell.hjNU.text = reportModel.TOTAL;
            tempCell.dachengNU.text = reportModel.APPROVAL;
            tempCell.tbNU.text = reportModel.TONGBI;
            NSLog(@"%@,%@",tempCell.Provincial.text,tempCell.mubiao.text);
        }
    }else{
        if (indexPath != nil) {
            KPCell *tempCell=(KPCell*)cell;
            
            sixPerformanceLX *reportModel=(sixPerformanceLX*)[self.LXS objectAtIndex:indexPath.section];
            
            tempCell.Provincial.text = reportModel.DEPT_NM;
            
            tempCell.mubiao.text = reportModel.TARGET;
            tempCell.date.text = reportModel.MON;
            tempCell.uzaNU.text = reportModel.UZA;
            tempCell.dentilNU.text = reportModel.DENTI;
            tempCell.phyllNU.text = reportModel.PHYLL;
            tempCell.tgmNU.text = reportModel.TGM;
            tempCell.qtNU.text = reportModel.OTHER;
            tempCell.hjNU.text = reportModel.TOTAL;
            tempCell.dachengNU.text = reportModel.APPROVAL;
            tempCell.tbNU.text = reportModel.TONGBI;
            NSLog(@"%@,%@",tempCell.Provincial.text,tempCell.mubiao.text);
        }
    }
}
#pragma 请求服务器结果

-(void) finishQueueComplete
{
    
}



-(void) finishSingleRequestFailed:(NSError *)error userInfo:(NSDictionary *)dic
{
        //[HUDManager showErrorWithMessage:@"网络错误" duration:1];
}
    //请求成功，解析结果
-(void) finishSingleRequestSuccess:(NSData *)xml userInfo:(NSDictionary *)dic
{
    @try {
        if(self)
            {
            /**查询大区**/
            if ([@"HMG_AREA_QUERY" isEqualToString:[dic objectForKey:@"name"]]) {
                
                AppDelegate *del = [UIApplication sharedApplication].delegate;
                
                AreaModel *tempArea=[[AreaModel alloc] init];
                [self.areas removeAllObjects];
                
                [self.areas addObjectsFromArray:[tempArea searchNodeToArray:xml nodeName:@"NewDataSet"]];
                
                if ([del.userInfo1.EMP_TYPE isEqualToString:@"0"]) {
                    self.selectArea=(AreaModel*)[self.areas objectAtIndex:0];
                    NSLog(@"%@1",[self.areas[0]DEPT_NM]);
                }else{
                    self.selectArea.DEPT_ID = @"";
                }
                
            }
            /**查询部门**/
            if ([@"HMG_DEPT_QUERY" isEqualToString:[dic objectForKey:@"name"]])
                {
                DeptModel *tempDept=[[DeptModel alloc] init];
                [self.depts addObjectsFromArray:[tempDept searchNodeToArray:xml nodeName:@"NewDataSet"]];
                }
            
            if (_segment.selectedSegmentIndex == 0) {
                /**查询开票数量**/
                if ([@"SIX_PERFORMANCE_KP" isEqualToString:[dic objectForKey:@"name"]])
                    {
                    sixPerformanceKP *tempReport=[[sixPerformanceKP alloc] init];
                    if (isRefresh) {
                        [self.KPS removeAllObjects];
                        [self.KPS addObjectsFromArray:[tempReport searchNodeToArray:xml nodeName:@"NewDataSet"]];
                        [self.refreshControll endPullDownRefreshing];
                    }
                    else
                        {
                        [self.KPS addObjectsFromArray:[tempReport searchNodeToArray:xml nodeName:@"NewDataSet"]];
                        [self.refreshControll endPullUpLoading];
                        }
                    
                    if (self.KPS.count>0) {
                        sixPerformanceKP *model0=(sixPerformanceKP *)[self.KPS objectAtIndex:0];
                        Max_Count=[model0.TOTAL_RECORDS intValue];
                        NSLog(@"%@",model0.TOTAL_RECORDS);
                    }
                    
                    [tableView1 reloadData];
                    [HUDManager hide];
                    }
            } else {
                /**查询流向数量**/
                if ([@"SIX_PERFORMANCE_LX" isEqualToString:[dic objectForKey:@"name"]])
                    {
                    sixPerformanceLX *tempReport=[[sixPerformanceLX alloc] init];
                    if (isRefresh) {
                        [self.LXS removeAllObjects];
                        [self.LXS addObjectsFromArray:[tempReport searchNodeToArray:xml nodeName:@"NewDataSet"]];
                        [self.refreshControll endPullDownRefreshing];
                    }
                    else
                        {
                        [self.LXS addObjectsFromArray:[tempReport searchNodeToArray:xml nodeName:@"NewDataSet"]];
                        [self.refreshControll endPullUpLoading];
                        }
                    
                    if (self.LXS.count>0) {
                        sixPerformanceLX *model0=(sixPerformanceLX *)[self.LXS objectAtIndex:0];
                        Max_Count=[model0.TOTAL_RECORDS intValue];
                        NSLog(@"%@",model0.TOTAL_RECORDS);
                    }
                    
                    [tableView1 reloadData];
                    [HUDManager hide];
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
    //菜单包含几列
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 2;
}

    //菜单行数
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    
    if (column == 0) {
        return self.areas.count;
    }else {
        return self.depts.count;
    }
    
}


    //菜单行标题
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        
        AreaModel *m1=(AreaModel *)self.areas[indexPath.row];
        return m1.DEPT_NM;
        
    } else {
        
        DeptModel *m2=(DeptModel *)self.depts[indexPath.row];
        return m2.DEPT_NM;
    }
    
}



    //DropView  菜单点击
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
    if (indexPath.column==0) {
        AreaModel *tempArea=(AreaModel *)[self.areas objectAtIndex:indexPath.row];
        
        if (![tempArea.DEPT_ID isEqualToString:@"0"]) {
            
            HMG_DEPT_QUERY *deptParam=[[HMG_DEPT_QUERY alloc] init];
            [deptParam setIN_DEPT_ID:tempArea.DEPT_ID];
            
            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:deptParam];
            
            [self.serviceHelper resetQueue];
            
            request1=[ServiceHelper commonSharedRequestMethod:@"HMG_DEPT_QUERY" soapMessage:paramXml];
            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"HMG_DEPT_QUERY",@"name", nil]];
            [self.serviceHelper addRequestQueue:request1];
            
            [self.serviceHelper startQueue];
            
            self.selectArea=tempArea;
            
            if (indexPath.column==lastColumn9) {
                if (indexPath.row==lastRow9) {
                    
                }
                else
                    {
                    [self.depts removeAllObjects];
                    DeptModel *dept=[[DeptModel alloc] init];
                    dept.DEPT_ID=@"0";
                    dept.DEPT_NM=@"部门";
                    self.depts = [NSMutableArray arrayWithObjects:dept, nil];
                    
                    self.selectDept=dept;
                    }
            }
        }
        else
            {
            [self.depts removeAllObjects];
            DeptModel *dept=[[DeptModel alloc] init];
            dept.DEPT_ID=@"0";
            dept.DEPT_NM=@"部门";
            self.depts = [NSMutableArray arrayWithObjects:dept, nil];
            }
    }
}

    //禁用于开启后退按钮
-(void) setCanBack:(BOOL) value
{
    KPcanBack = NO;
}

#pragma 刷新控件

- (BOOL)hasRefreshFooterView {
    
    if (_segment.selectedSegmentIndex == 0) {
        if (self.KPS.count > 0 && self.KPS.count < Max_Count) {
            
            return YES;
        }
        return NO;
    } else {
        if (self.LXS.count > 0 && self.LXS.count < Max_Count) {
            
            return YES;
        }
        return NO;
    }
    
}

- (BOOL)keepiOS7NewApiCharacter {
    
    if (!self.navigationController)
        return NO;
    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
    return keeped;
}

- (void)beginPullDownRefreshing {
    
        //[HUDManager showMessage:@"加载中..."];
    isRefresh=YES;
    currentPage=1;
    [self setCanBack:NO];
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:3];
}
- (void)beginPullUpLoading
{
        //[HUDManager showMessage:@"加载中..."];
    [self setCanBack:NO];
    isRefresh=NO;
    [self performSelector:@selector(endLoadMore) withObject:nil afterDelay:3];
}

- (void)endRefresh {
    [self setCanBack:NO];
    
    Common *common=[[Common alloc] initWithView:self.view];
    
    if (common.isConnectionAvailable) {
        
        if (_segment.selectedSegmentIndex == 0) {
            SIX_PERFORMANCE_KP *reportParam=[[SIX_PERFORMANCE_KP alloc] init];
            if (self.selectArea==nil) {
                reportParam.IN_AREA_ID=@"";
            }
            else
                {
                reportParam.IN_AREA_ID=self.selectArea.DEPT_ID;
                
                }
            if (self.selectDept==nil) {
                reportParam.IN_DEPT_ID=@"";
            }
            else
                {
                if ([self.selectDept.DEPT_ID isEqualToString:@"0"]) {
                    reportParam.IN_DEPT_ID=@"";
                }else
                    {
                    reportParam.IN_DEPT_ID=self.selectDept.DEPT_ID;
                    }
                }
            reportParam.IN_START_DATE=startDate1.titleLabel.text;
            reportParam.IN_END_DATE=endDate1.titleLabel.text;
            reportParam.IN_CURRENT_PAGE=[[NSNumber numberWithInt:currentPage] stringValue];
            reportParam.IN_PAGE_SIZE=[[NSNumber numberWithInt:pageSize] stringValue];
            
            NSLog(@"%@,%@",reportParam.IN_AREA_ID,reportParam.IN_DEPT_ID);
            
            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:reportParam];
            NSLog(@"%@",paramXml);
            [self.serviceHelper resetQueue];
            
            request1=[ServiceHelper commonSharedRequestMethod:@"SIX_PERFORMANCE_KP" soapMessage:paramXml];
            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"SIX_PERFORMANCE_KP",@"name", nil]];
            
            [self.serviceHelper addRequestQueue:request1];
            
            [self.serviceHelper startQueue];
            
            [self.KPS removeAllObjects];
            [tableView1 reloadData];
        } else {
            SIX_PERFORMANCE_LX *reportParam=[[SIX_PERFORMANCE_LX alloc] init];
            if (self.selectArea==nil) {
                reportParam.IN_AREA_ID=@"";
            }
            else
                {
                reportParam.IN_AREA_ID=self.selectArea.DEPT_ID;
                
                }
            if (self.selectDept==nil) {
                reportParam.IN_DEPT_ID=@"";
            }
            else
                {
                if ([self.selectDept.DEPT_ID isEqualToString:@"0"]) {
                    reportParam.IN_DEPT_ID=@"";
                }else
                    {
                    reportParam.IN_DEPT_ID=self.selectDept.DEPT_ID;
                    }
                }
            reportParam.IN_START_DATE=startDate1.titleLabel.text;
            reportParam.IN_END_DATE=endDate1.titleLabel.text;
            reportParam.IN_CURRENT_PAGE=[[NSNumber numberWithInt:currentPage] stringValue];
            reportParam.IN_PAGE_SIZE=[[NSNumber numberWithInt:pageSize] stringValue];
            
            NSLog(@"%@,%@",reportParam.IN_AREA_ID,reportParam.IN_DEPT_ID);
            
            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:reportParam];
            NSLog(@"%@",paramXml);
            [self.serviceHelper resetQueue];
            
            request1=[ServiceHelper commonSharedRequestMethod:@"SIX_PERFORMANCE_LX" soapMessage:paramXml];
            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"SIX_PERFORMANCE_LX",@"name", nil]];
            
            [self.serviceHelper addRequestQueue:request1];
            
            [self.serviceHelper startQueue];
            
            [self.LXS removeAllObjects];
            [tableView1 reloadData];
        }
        
        
        
    }
}
- (void)endLoadMore {
    
    Common *common=[[Common alloc] initWithView:self.view];
    
    if (common.isConnectionAvailable) {
        if (_segment.selectedSegmentIndex == 0) {
            currentPage ++;
            SIX_PERFORMANCE_KP *reportParam=[[SIX_PERFORMANCE_KP alloc] init];
            if (self.selectArea==nil) {
                reportParam.IN_AREA_ID=@"";
            }
            else
                {
                reportParam.IN_AREA_ID=self.selectArea.DEPT_ID;
                
                }
            if (self.selectDept==nil) {
                reportParam.IN_DEPT_ID=@"";
            }
            else
                {
                if ([self.selectDept.DEPT_ID isEqualToString:@"0"]) {
                    reportParam.IN_DEPT_ID=@"";
                }else
                    {
                    reportParam.IN_DEPT_ID=self.selectDept.DEPT_ID;
                    }
                }
            reportParam.IN_START_DATE=startDate1.titleLabel.text;
            reportParam.IN_END_DATE=endDate1.titleLabel.text;
            reportParam.IN_CURRENT_PAGE=[[NSNumber numberWithInt:currentPage] stringValue];
            reportParam.IN_PAGE_SIZE=[[NSNumber numberWithInt:pageSize] stringValue];
            
            
            NSLog(@"%@,%@",reportParam.IN_AREA_ID,reportParam.IN_DEPT_ID);
            
            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:reportParam];
                //NSLog(@"%@",paramXml);
            [self.serviceHelper resetQueue];
            
            request1=[ServiceHelper commonSharedRequestMethod:@"SIX_PERFORMANCE_KP" soapMessage:paramXml];
            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"SIX_PERFORMANCE_KP",@"name", nil]];
            
            [self.serviceHelper addRequestQueue:request1];
            
            [self.serviceHelper startQueue];
        } else {
            currentPage ++;
            SIX_PERFORMANCE_LX *reportParam=[[SIX_PERFORMANCE_LX alloc] init];
            if (self.selectArea==nil) {
                reportParam.IN_AREA_ID=@"";
            }
            else
                {
                reportParam.IN_AREA_ID=self.selectArea.DEPT_ID;
                
                }
            if (self.selectDept==nil) {
                reportParam.IN_DEPT_ID=@"";
            }
            else
                {
                if ([self.selectDept.DEPT_ID isEqualToString:@"0"]) {
                    reportParam.IN_DEPT_ID=@"";
                }else
                    {
                    reportParam.IN_DEPT_ID=self.selectDept.DEPT_ID;
                    }
                }
            reportParam.IN_START_DATE=startDate1.titleLabel.text;
            reportParam.IN_END_DATE=endDate1.titleLabel.text;
            reportParam.IN_CURRENT_PAGE=[[NSNumber numberWithInt:currentPage] stringValue];
            reportParam.IN_PAGE_SIZE=[[NSNumber numberWithInt:pageSize] stringValue];
            
            
            NSLog(@"%@,%@",reportParam.IN_AREA_ID,reportParam.IN_DEPT_ID);
            
            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:reportParam];
                //NSLog(@"%@",paramXml);
            [self.serviceHelper resetQueue];
            
            request1=[ServiceHelper commonSharedRequestMethod:@"SIX_PERFORMANCE_LX" soapMessage:paramXml];
            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"SIX_PERFORMANCE_LX",@"name", nil]];
            
            [self.serviceHelper addRequestQueue:request1];
            
            [self.serviceHelper startQueue];
        }
        
        
    }
    
}


-(void)searchButtonHandle{
    [self.refreshControll startPullDownRefreshing];
    [self beginPullDownRefreshing];
    
    [self.KPS removeAllObjects];
    [tableView1 reloadData];
    
}

-(void)searchButtonHandle1{
    [self.refreshControll startPullDownRefreshing];
    [self beginPullDownRefreshing];
    
    [self.LXS removeAllObjects];
    [tableView1 reloadData];
}
@end
