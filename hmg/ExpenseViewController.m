//
//  ExpenseViewController.m
//  hmg
//
//  Created by hongxianyu on 2016/12/16.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "ExpenseViewController.h"
#import "ExpenseCell1.h"
#import "sixExpenseReport.h"
#import "SIX_EXPENSE_REPORT.h"

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
@interface ExpenseViewController ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate,CLLRefreshHeadControllerDelegate>
{
    int currentPage;
    int Max_Count;
    BOOL isRefresh;
    
    
    UILabel *expenseDate;
    UIButton *startDate1;
    UIButton *endDate1;


}

@property (nonatomic,strong)CLLRefreshHeadController *refreshControll;

    //大区
@property (nonatomic, strong) NSMutableArray *areas;
    //部门
@property (nonatomic, strong) NSMutableArray *depts;

    //费用集合
@property (nonatomic, strong) NSMutableArray *Expenses;
#pragma 走访查询参数
@property (nonatomic, strong) AreaModel *selectArea;
@property (nonatomic, strong) DeptModel *selectDept;
@property (nonatomic) NSInteger pageSize;

@end
UITableView *tableView;
UIScrollView *scrollView;
bool expenseCanBack=YES;
@implementation ExpenseViewController
NSInteger lastColumn7 = -1;
NSInteger lastRow7 = -1;
- (CLLRefreshHeadController *)refreshControll
{
    if (!_refreshControll) {
        _refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:tableView viewDelegate:self];
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
    
    self.Expenses=[[NSMutableArray alloc] init];
    
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 72,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 135)];
        //tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:240/255.0 blue:248/255.0 alpha:1.0];
     self.view.backgroundColor = [self colorWithHexString:@"#e9f1f6" alpha:1];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    tableView.dataSource=self;
    tableView.delegate=self;
    
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
    
    
    expenseDate = [[UILabel alloc]init];
    
    startDate1 = [[UIButton alloc]init];
    endDate1 = [[UIButton alloc]init];
    
    
    expenseDate.text = @"日期";
    [self.view addSubview:expenseDate];
    expenseDate.sd_layout
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
    .leftSpaceToView(expenseDate, 5)
    .topSpaceToView(menu, 1)
    .widthIs((self.view.size.width - expenseDate.width - 10 - 10)/2)
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        //[agentName setTitle:stockSource[stockkeys[0]] forState:UIControlStateNormal];
    
    
    if (!self.serviceHelper) {
        
        self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    }
    
    [self.navigationItem setTitle:@"费用报表"];
    
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBackMenu)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStyleBordered target:self action:@selector(searchButtonHandle)];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    
}
-(void)goBackMenu{
    [request1 clearDelegatesAndCancel];
    [self.serviceHelper resetQueue];
    self.serviceHelper=nil;
    [self.navigationController popViewControllerAnimated:YES];
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
    return self.Expenses.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
    //去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == tableView)
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
    ExpenseCell1  * cell = [ExpenseCell1 cellWithTableView:tableView];
    
//    if (!cell)
//        {
//        [tableView registerNib:[UINib nibWithNibName:@"ExpenseCell" bundle:nil] forCellReuseIdentifier:@"ExpenseCell"];
//        cell = [tableView dequeueReusableCellWithIdentifier:@"ExpenseCell"];
//        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.layer.masksToBounds=YES;
    
    return cell;
}

    //-------------------------------
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath != nil) {
        
        ExpenseCell1 *tempCell=(ExpenseCell1*)cell;
        
        sixExpenseReport *reportModel=(sixExpenseReport*)[self.Expenses objectAtIndex:indexPath.section];
        
        tempCell.Provincial.text = reportModel.PROVINCIAL;
        tempCell.date.text = reportModel.MON;
        tempCell.Surplus.text = reportModel.CURR_COST;
        tempCell.Already.text = reportModel.APPLY_PRICE;
        tempCell.Verification.text = reportModel.VER_TOTAL;
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
                //            /**查询人员**/
                //            if ([@"HMG_USER_QUERY" isEqualToString:[dic objectForKey:@"name"]])
                //                {
                //                UserModel *tempUser=[[UserModel alloc] init];
                //                [self.users addObjectsFromArray:[tempUser searchNodeToArray:xml nodeName:@"NewDataSet"]];
                //                }
            /**查询费用**/
            if ([@"SIX_EXPENSE_REPORT" isEqualToString:[dic objectForKey:@"name"]])
                {
                sixExpenseReport *tempReport=[[sixExpenseReport alloc] init];
                if (isRefresh) {
                    [self.Expenses removeAllObjects];
                    [self.Expenses addObjectsFromArray:[tempReport searchNodeToArray:xml nodeName:@"NewDataSet"]];
                    [self.refreshControll endPullDownRefreshing];
                }
                else
                    {
                    [self.Expenses addObjectsFromArray:[tempReport searchNodeToArray:xml nodeName:@"NewDataSet"]];
                    [self.refreshControll endPullUpLoading];
                    }
                
                if (self.Expenses.count>0) {
                    sixExpenseReport *model0=(sixExpenseReport *)[self.Expenses objectAtIndex:0];
                    Max_Count=[model0.TOTAL_RECORDS intValue];
                    NSLog(@"%@",model0.TOTAL_RECORDS);
                }
                
                [tableView reloadData];
                [HUDManager hide];
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
        //    else
        //        {
        //        return self.users.count;
        //        }
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
        //    } else{
        //
        //        UserModel *m3=(UserModel *)self.users[indexPath.row];
        //        return m3.ENAME;
        //    }
    
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
            
            if (indexPath.column==lastColumn7) {
                if (indexPath.row==lastRow7) {
                    
                }
                else
                    {
                    [self.depts removeAllObjects];
                    DeptModel *dept=[[DeptModel alloc] init];
                    dept.DEPT_ID=@"0";
                    dept.DEPT_NM=@"部门";
                    self.depts = [NSMutableArray arrayWithObjects:dept, nil];
                    
                    
                        //                    [self.users removeAllObjects];
                        //                    UserModel *user=[[UserModel alloc] init];
                        //                    user.PERNR=@"0";
                        //                    user.ENAME=@"人员";
                        //                    self.users = [NSMutableArray arrayWithObjects:user, nil];
                    
                    
                    self.selectDept=dept;
                    
                        //self.selectUser=user;
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
            
            
                //            [self.users removeAllObjects];
                //            UserModel *user=[[UserModel alloc] init];
                //            user.PERNR=@"0";
                //            user.ENAME=@"人员";
                //            self.users = [NSMutableArray arrayWithObjects:user, nil];
            }
    }
        //    if (indexPath.column==1) {
        //        DeptModel *tempDept=(DeptModel *)[self.depts objectAtIndex:indexPath.row];
        //
        //        if (![tempDept.DEPT_ID isEqualToString:@"0"]) {
        //                //HMG_USER_QUERY *userParam=[[HMG_USER_QUERY alloc] init];
        //            [userParam setIN_DEPT_ID:tempDept.DEPT_ID];
        //
        //            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:userParam];
        //
        //            [self.serviceHelper resetQueue];
        //
        //            request1=[ServiceHelper commonSharedRequestMethod:@"HMG_USER_QUERY" soapMessage:paramXml];
        //            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"HMG_USER_QUERY",@"name", nil]];
        //            [self.serviceHelper addRequestQueue:request1];
        //
        //            [self.serviceHelper startQueue];
        //
        //            self.selectDept=tempDept;
        //
        //            if (indexPath.column==lastColumn3) {
        //                if (indexPath.row==lastRow3) {
        //
        //                }
        //                else
        //                    {
        //                    [self.users removeAllObjects];
        //                    UserModel *user=[[UserModel alloc] init];
        //                    user.PERNR=@"0";
        //                    user.ENAME=@"人员";
        //                    self.users = [NSMutableArray arrayWithObjects:user, nil];
        //
        //                    self.selectUser=user;
        //                    }
        //            }
        //        }else
        //            {
        //            [self.users removeAllObjects];
        //            UserModel *user=[[UserModel alloc] init];
        //            user.PERNR=@"0";
        //            user.ENAME=@"人员";
        //            self.users = [NSMutableArray arrayWithObjects:user, nil];
        //            }
        //    }
        //    if (indexPath.column==2) {
        //
        //        UserModel *tempUser=(UserModel *)[self.users objectAtIndex:indexPath.row];
        //        self.selectUser=tempUser;
        //    }
        //
        //    lastColumn3=indexPath.column;
        //    lastRow3=indexPath.row;
    
    
        //    if (indexPath.row!=0) {
        //        [HUDManager showMessage:@"加载中..."];
        //        [self.refreshControll startPullDownRefreshing];
        //        [self.reports removeAllObjects];
        //        [tableView reloadData];
        //    }
}


    //禁用于开启后退按钮
-(void) setCanBack:(BOOL) value
{
    expenseCanBack=value;
}

#pragma 刷新控件

- (BOOL)hasRefreshFooterView {
    if (self.Expenses.count > 0 && self.Expenses.count < Max_Count) {
        
        return YES;
    }
    return NO;
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
        
        SIX_EXPENSE_REPORT *reportParam=[[SIX_EXPENSE_REPORT alloc] init];
        if (self.selectArea==nil) {
            reportParam.IN_AREA_ID=@"";
        }
        else
            {
                //            if ([self.selectArea.DEPT_ID isEqualToString:@"0"]) {
                //                reportParam.IN_AREA_ID=@"";
                //            }else
                //            {
            reportParam.IN_AREA_ID=self.selectArea.DEPT_ID;
                //}
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
            //        if (self.selectUser==nil) {
            //            reportParam.IN_EMP_NO=@"";
            //        }
            //        else
            //            {
            //            if ([self.selectUser.PERNR isEqualToString:@"0"]) {
            //                reportParam.IN_EMP_NO=@"";
            //            }else
            //                {
            //                reportParam.IN_EMP_NO=self.selectUser.PERNR;
            //                }
            //}
        
        reportParam.IN_START_DATE=startDate1.titleLabel.text;
        reportParam.IN_END_DATE=endDate1.titleLabel.text;
        reportParam.IN_CURRENT_PAGE=[[NSNumber numberWithInt:currentPage] stringValue];
        reportParam.IN_PAGE_SIZE=[[NSNumber numberWithInt:pageSize] stringValue];
        
        NSLog(@"%@,%@",reportParam.IN_AREA_ID,reportParam.IN_DEPT_ID);
        
        NSString *paramXml=[SoapHelper objToDefaultSoapMessage:reportParam];
        NSLog(@"%@",paramXml);
        [self.serviceHelper resetQueue];
        
        request1=[ServiceHelper commonSharedRequestMethod:@"SIX_EXPENSE_REPORT" soapMessage:paramXml];
        [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"SIX_EXPENSE_REPORT",@"name", nil]];
        
        [self.serviceHelper addRequestQueue:request1];
        
        [self.serviceHelper startQueue];
        
        [self.Expenses removeAllObjects];
        [tableView reloadData];
        
    }
}
- (void)endLoadMore {
    
    Common *common=[[Common alloc] initWithView:self.view];
    
    if (common.isConnectionAvailable) {
        currentPage ++;
        SIX_EXPENSE_REPORT *reportParam=[[SIX_EXPENSE_REPORT alloc] init];
        if (self.selectArea==nil) {
            reportParam.IN_AREA_ID=@"";
        }
        else
            {
                //            if ([self.selectArea.DEPT_ID isEqualToString:@"0"]) {
                //                reportParam.IN_AREA_ID=@"";
                //            }else
                //            {
            reportParam.IN_AREA_ID=self.selectArea.DEPT_ID;
                //}
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
            //        if (self.selectUser==nil) {
            //            reportParam.IN_EMP_NO=@"";
            //        }
            //        else
            //            {
            //            if ([self.selectUser.PERNR isEqualToString:@"0"]) {
            //                reportParam.IN_EMP_NO=@"";
            //            }else
            //                {
            //                reportParam.IN_EMP_NO=self.selectUser.PERNR;
            //                }
            //            }
        reportParam.IN_START_DATE=startDate1.titleLabel.text;
        reportParam.IN_END_DATE=endDate1.titleLabel.text;
        reportParam.IN_CURRENT_PAGE=[[NSNumber numberWithInt:currentPage] stringValue];
        reportParam.IN_PAGE_SIZE=[[NSNumber numberWithInt:pageSize] stringValue];
        
        
        NSLog(@"%@,%@",reportParam.IN_AREA_ID,reportParam.IN_DEPT_ID);
        
        NSString *paramXml=[SoapHelper objToDefaultSoapMessage:reportParam];
            //NSLog(@"%@",paramXml);
        [self.serviceHelper resetQueue];
        
        request1=[ServiceHelper commonSharedRequestMethod:@"SIX_EXPENSE_REPORT" soapMessage:paramXml];
        [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"SIX_EXPENSE_REPORT",@"name", nil]];
        
        [self.serviceHelper addRequestQueue:request1];
        
        [self.serviceHelper startQueue];
    }
    
}


-(void)searchButtonHandle{
    [self.refreshControll startPullDownRefreshing];
    [self beginPullDownRefreshing];
    
    [self.Expenses removeAllObjects];
    [tableView reloadData];
    
        //  [self.refreshControll startPullDownRefreshing];
        //    Common *common=[[Common alloc] initWithView:self.view];
        //
        //    if (common.isConnectionAvailable) {
        //
        //        SIX_VISIT_REPORT *reportParam=[[SIX_VISIT_REPORT alloc] init];
        //        if (self.selectArea==nil) {
        //            reportParam.IN_AREA_ID=@"";
        //        }
        //        else
        //            {
        //                //            if ([self.selectArea.DEPT_ID isEqualToString:@"0"]) {
        //                //                reportParam.IN_AREA_ID=@"";
        //                //            }else
        //                //            {
        //            reportParam.IN_AREA_ID=self.selectArea.DEPT_ID;
        //                //}
        //            }
        //        if (self.selectDept==nil) {
        //            reportParam.IN_DEPT_ID=@"";
        //        }
        //        else
        //            {
        //            if ([self.selectDept.DEPT_ID isEqualToString:@"0"]) {
        //                reportParam.IN_DEPT_ID=@"";
        //            }else
        //                {
        //                reportParam.IN_DEPT_ID=self.selectDept.DEPT_ID;
        //                }
        //            }
        //        if (self.selectUser==nil) {
        //            reportParam.IN_EMP_NO=@"";
        //        }
        //        else
        //            {
        //            if ([self.selectUser.PERNR isEqualToString:@"0"]) {
        //                reportParam.IN_EMP_NO=@"";
        //            }else
        //                {
        //                reportParam.IN_EMP_NO=self.selectUser.PERNR;
        //                }
        //            }
        //        reportParam.IN_STORE_NAME = storeName.text;
        //        reportParam.IN_START_DATE=startDate1.titleLabel.text;
        //        reportParam.IN_END_DATE=endDate1.titleLabel.text;
        //        reportParam.IN_CURRENT_PAGE=[[NSNumber numberWithInt:currentPage] stringValue];
        //        reportParam.IN_PAGE_SIZE=[[NSNumber numberWithInt:pageSize] stringValue];
        //
        //        NSLog(@"%@,%@,%@",reportParam.IN_AREA_ID,reportParam.IN_DEPT_ID,reportParam.IN_EMP_NO);
        //
        //        NSString *paramXml=[SoapHelper objToDefaultSoapMessage:reportParam];
        //        NSLog(@"%@",paramXml);
        //        [self.serviceHelper resetQueue];
        //
        //        request1=[ServiceHelper commonSharedRequestMethod:@"SIX_VISIT_REPORT" soapMessage:paramXml];
        //        [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"SIX_VISIT_REPORT",@"name", nil]];
        //
        //        [self.serviceHelper addRequestQueue:request1];
        //
        //        [self.serviceHelper startQueue];
        //
        //        [self.Visits removeAllObjects];
        //        [tableView1 reloadData];
        //
        //    }
}

@end
