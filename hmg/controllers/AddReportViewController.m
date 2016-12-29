//
//  AddReportViewController.m
//  hmg
//
//  Created by Lee on 15/3/26.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import "AddReportViewController.h"
#import "XLForm.h"
#import "AgentTableViewController.h"
#import "StoreTableViewController.h"
#import "BrandTableViewController.h"
#import "PurposeViewController.h"
#import "SAVE_DAILY_REPORT.h"
#import "AppDelegate.h"
#import "Store.h"
#import "Purpose.h"
#import "Agent.h"
#import "Brand.h"
#import "SoapHelper.h"
#import "CommonResult.h"
#import "Common.h"
#import "UploadViewController.h"

@interface AddReportViewController ()<UIAlertViewDelegate>
{
  NSString *date1;
 }
@end

//被拜访人
NSString *const kName = @"name";
//手机
NSString *const kName_tel = @"tel";
//固话
NSString *const kName_gh = @"gh";
//门店或经销商
NSString *const kSelectorStore = @"selectorStore";
//品牌
NSString *const kSelectorBrand = @"selectorBrand";
//目的
NSString *const kSelectorPurpose = @"selectorPurpose";
//拜访类型
NSString *const kSwitchBool = @"switchBool";
//摘要
NSString *const kNotes = @"notes";

//拜访时间
NSString *const kSegmentedControl = @"segmentedControl";

@implementation AddReportViewController



//ServiceHelper *serviceHelper;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    
    return self;
}

-(void)initializeForm
{
    
    self.formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"日报录入"];
    
    self.section=[XLFormSectionDescriptor formSection];
    
    [self.formDescriptor addFormSection:self.section];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kSegmentedControl rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"拜访时间"];
    [self.row.cellConfig setObject:[UIColor colorWithRed:49.0/255.0 green:148.0 / 255.0 blue:208.0 / 255.0 alpha:1.0] forKey:@"segmentedControl.tintColor"];
    self.row.selectorOptions = @[@"昨天", @"今天"];
    self.row.value = @"今天";
    [self.section addFormRow:self.row];
    
    self.row=[XLFormRowDescriptor formRowDescriptorWithTag:kSwitchBool rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"门店 ｜ 经销商"];
    self.row.value=0;
    [self.section addFormRow:self.row];
    
    //添加监听
    [self.row addObserver:self forKeyPath:@"value" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorStore rowType:XLFormRowDescriptorTypeSelectorPush title:@"门店"];
    self.row.action.viewControllerClass = [StoreTableViewController class];
    [self.section addFormRow:self.row];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kName rowType:XLFormRowDescriptorTypeText title:@"被拜访人"];
    self.row.required = YES;
    [self.section addFormRow:self.row];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kName_tel rowType:XLFormRowDescriptorTypePhone title:@"固话"];
    self.row.required = YES;
    [self.section addFormRow:self.row];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kName_gh rowType:XLFormRowDescriptorTypePhone title:@"手机"];
    self.row.required = YES;
    [self.section addFormRow:self.row];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorBrand rowType:XLFormRowDescriptorTypeSelectorPush title:@"品牌"];
    self.row.action.viewControllerClass = [BrandTableViewController class];
    [self.section addFormRow:self.row];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kSelectorPurpose rowType:XLFormRowDescriptorTypeSelectorPush title:@"拜访目的"];
    self.row.action.viewControllerClass = [PurposeViewController class];
    [self.section addFormRow:self.row];
    
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kNotes rowType:XLFormRowDescriptorTypeTextView title:@"摘要:"];
    [self.section addFormRow:self.row];
    
    self.form = self.formDescriptor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    self.navigationItem.title=@"日报录入";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // self.navigationController.navigationBar.barTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.png"]];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveReport)];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//返回
-(void) goBack
{
    [self.serviceHelper resetQueue];
    self.serviceHelper=nil;
    [HUDManager hide];
    //移除kvo
    [[self.form formRowWithTag:kSwitchBool] removeObserver:self forKeyPath:@"value" context:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//保存日报
-(void) saveReport
{
    
    NSString *strName=[self.form formRowWithTag:kName].value;
    NSString *strTEL=[self.form formRowWithTag:kName_tel].value;
    NSString *strGH=[self.form formRowWithTag:kName_gh].value;
    
    Brand *tmpBrand=[self.form formRowWithTag:kSelectorBrand].value;
    Purpose *tmpPurpose=[self.form formRowWithTag:kSelectorPurpose].value;
    NSString *strNotes=[self.form formRowWithTag:kNotes].value;
    
    //手机和固话二选一
    if ([strName isEqualToString:@""]||tmpBrand==nil||tmpPurpose==nil||[self.form formRowWithTag:kSelectorStore].value==nil||[strNotes isEqualToString:@""]) {
        
        //[HUDManager showIndeterminateWithMessage:@"信息不完善" duration:1];
        [HUDManager showMessage:@"信息不完整!" mode:MBProgressHUDModeText duration:1];
    }
    else
    {
        if([strTEL isEqualToString:@""]&&[strGH isEqualToString:@""])
        {
            
            [HUDManager showMessage:@"请填写被拜访人手机号或固话！" mode:MBProgressHUDModeText duration:1];
            
            return;
        }
        Common *common=[[Common alloc] initWithView:self.view];
        
        if (common.isConnectionAvailable) {
            
            [HUDManager showMessage:@"正在提交"];
            AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
            
            SAVE_DAILY_REPORT *param=[[SAVE_DAILY_REPORT alloc] init];
            param.IN_EMP_NO=appDelegate.userInfo1.EMP_NO;
            param.IN_PRODUCT_ID=tmpBrand.ID;
            param.IN_VISIT_PURPOSE=tmpPurpose.ID;
            param.IN_VISIT_PERSON=strName;
            param.IN_VISIT_PERSON_GH=strGH;
            param.IN_VISIT_PERSON_TEL=strTEL;
            param.IN_RMK=strNotes;
            NSLog(@"%@",[self.form formRowWithTag:kSwitchBool].value);
            if ([[self.form formRowWithTag:kSwitchBool].value intValue]==0 ) {
                Store *tmpStore= [self.form formRowWithTag:kSelectorStore].value;
                param.IN_STORE_ID=tmpStore.STORE_ID;
                param.IN_AGENT_ID=@"";
            }else
            {
                Agent *tmpAgent= [self.form formRowWithTag:kSelectorStore].value;
                param.IN_STORE_ID=@"";
                param.IN_AGENT_ID=tmpAgent.AGENT_ID;
            }
            if ([[self.form formRowWithTag:kSegmentedControl].value isEqualToString:@"今天"]) {
                param.IN_TODAY_OR_YESTODAY=@"1";
                date1 = param.IN_TODAY_OR_YESTODAY;

            }
            else
            {
                param.IN_TODAY_OR_YESTODAY=@"0";
            }
            
            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:param];
            
            [self.serviceHelper resetQueue];
            
            ASIHTTPRequest *request1=[ServiceHelper commonSharedRequestMethod:@"SAVE_DAILY_REPORT" soapMessage:paramXml];
            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"SAVE_DAILY_REPORT",@"name", nil]];
            [self.serviceHelper addRequestQueue:request1];
            
            [self.serviceHelper startQueue];
        }
        
    }
}

//重写键值监听方法，切换门店与经销商
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    BOOL value=[[change objectForKey:@"new"] boolValue];
    XLFormRowDescriptor *switchRow=[self.form formRowWithTag:kSelectorStore];
    if (!value) {
        
        switchRow.title=@"门店";
        switchRow.action.viewControllerClass=[StoreTableViewController class];
    }
    else
    {
        switchRow.title=@"经销商";
        switchRow.action.viewControllerClass=[AgentTableViewController class];
    }
    
    switchRow.value=nil;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma ---------------调用服务代码-------------------

-(void) finishQueueComplete
{
    
}

-(void) finishSingleRequestFailed:(NSError *)error userInfo:(NSDictionary *)dic
{
    //error.description
    [HUDManager showErrorWithMessage:@"网络错误" duration:1];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

//请求成功，解析结果
-(void) finishSingleRequestSuccess:(NSData *)xml userInfo:(NSDictionary *)dic
{
    /**保存日报接口**/
    if ([@"SAVE_DAILY_REPORT" isEqualToString:[dic objectForKey:@"name"]]) {
        CommonResult *result=[[CommonResult alloc] init];
        NSMutableArray *array =[[NSMutableArray alloc] init];
        [array addObjectsFromArray:[result searchNodeToArray:xml nodeName:@"NewDataSet"]];
        [HUDManager hide];
        if ([result.OUT_RESULT isEqualToString:@"0"]) {
            self.reportId=result.ID;
            NSLog(@"%@",self.reportId);
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"日报保存成功,是否上传照片?" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [alertView show];
        }
        else
        {
            NSString *errorStr=result.OUT_RESULT_NM;
            [HUDManager showErrorWithMessage:[NSString stringWithFormat:@"保存失败\n%@",errorStr] duration:2 complection:^{
                [self goBack];
            }];
        }
    }
}

//提示框代理
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [[self.form formRowWithTag:kSwitchBool] removeObserver:self forKeyPath:@"value" context:nil];
        
        UploadViewController *uvc = [[UploadViewController alloc]init];
        [uvc setValue:self.reportId forKey:@"reportId"];
        [uvc setValue:date1 forKey:@"time1"];
        [self.navigationController pushViewController:uvc animated:YES];

            //[self performSegueWithIdentifier:@"uploadId" sender:self];
    }
    else
    {
        [self goBack];
    }
}

//-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"uploadId"]) {
//        
//        id uploadController=segue.destinationViewController;
//        [uploadController setValue:self.reportId forKey:@"reportId"];
//        [uploadController setValue:date1 forKey:@"time1"];
//        
//    }
//}

@end
