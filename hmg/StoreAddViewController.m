//
//  StoreAddViewController.m
//  hmg
//
//  Created by hongxianyu on 2016/7/20.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "StoreAddViewController.h"
#import "XLForm.h"
#import "StoreTypeViewController.h"
#import "CooProductViewController.h"
#import "AgentRelationTableViewController.h"
#import "StoreType.h"
#import "CooProduct.h"
#import "AgentRelation.h"
#import "AgentProuctViewController.h"
#import "LYChooseTool.h"
#import "AgentSection.h"
#import "HMG_SAVE_STORE.h"
#import "CommonResult.h"
#import "Common.h"
#import "SoapHelper.h"
#import "AppDelegate.h"
@interface StoreAddViewController ()

@end

//名称
NSString *const kName1 = @"kName1";
//类型
NSString *const kType = @"kType";
//负责人
NSString *const kManager = @"kManager";
//负责人电话
NSString *const kManagerTel = @"kManagerTel";
//门店固话
NSString *const kTel = @"kTel";
//合作产品
NSString *const kCooProuct = @"kCooProuct";
//经销商
NSString *const kAgent = @"kAgent";

NSString *const kButton = @"kButton";

@implementation StoreAddViewController

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
    
    self.formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"新建门店"];
    
    self.section=[XLFormSectionDescriptor formSection];
    self.section.title=@"门店基本信息";
    [self.formDescriptor addFormSection:self.section];
    
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kName1 rowType:XLFormRowDescriptorTypeText title:@"名称:"];
    [self.section addFormRow:self.row];
    //self.row.value = name;
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kType rowType:XLFormRowDescriptorTypeSelectorPush title:@"类型:"];
    self.row.action.viewControllerClass = [StoreTypeViewController class];
    
    [self.section addFormRow:self.row];
    //self.row.value = type;
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kManager rowType:XLFormRowDescriptorTypeText title:@"负责人:"];
    
    [self.section addFormRow:self.row];
    //self.row.value = manager;
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kManagerTel rowType:XLFormRowDescriptorTypePhone title:@"负责人电话:"];
    [self.section addFormRow:self.row];
    //self.row.value = managerTel;
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kTel rowType:XLFormRowDescriptorTypePhone title:@"门店固话:"];
    [self.section addFormRow:self.row];
    //self.row.value = tel;
    
    self.section=[XLFormSectionDescriptor formSection];
    _section.title=@"合作产品及经销商添加";
    [self.formDescriptor addFormSection:self.section];
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kCooProuct rowType:XLFormRowDescriptorTypeSelectorPush title:@"合作产品:"];
    self.row.action.viewControllerClass = [CooProductViewController class];
    self.row.noValueDisplayText=@"请选择";
    [self.section addFormRow:self.row];
    
    //添加监听
    [self.row addObserver:self forKeyPath:@"value" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kAgent rowType:XLFormRowDescriptorTypeSelectorPush title:@"经销商:"];
    self.row.action.viewControllerClass = [AgentRelationTableViewController class];
    self.row.noValueDisplayText=@"请选择";
    [self.section addFormRow:self.row];
    
    self.row = [XLFormRowDescriptor formRowDescriptorWithTag:kButton rowType:XLFormRowDescriptorTypeButton title:@"添加"];
    self.row.action.formSelector = @selector(didTouchButton:);
    [self.section addFormRow:self.row];
    
    self.section = [XLFormSectionDescriptor formSectionWithTitle:@"已添加合作产品及经销商列表"
                                                  sectionOptions:  XLFormSectionOptionCanDelete];
    
    [self.formDescriptor addFormSection:self.section];
    
    
    self.form = self.formDescriptor;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    self.navigationItem.title=@"新建门店";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveStore)];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];
    
}

-(void)saveStore{
    
    NSString *name = [self.form formRowWithTag:kName1].value;
    StoreType *type = [self.form formRowWithTag:kType].value;
    NSString *manager = [self.form formRowWithTag:kManager].value;
    NSString *managerTel = [self.form formRowWithTag:kManagerTel].value;
    NSString *Tel = [self.form formRowWithTag:kTel].value;
    
    if ([name isEqualToString: @""]|| [manager isEqualToString:@""]|| [managerTel isEqualToString:@""]|| [Tel isEqualToString:@""]||type == nil|| _section.formRows.count==0)
        {
          [HUDManager showMessage:@"信息不完整!" mode:MBProgressHUDModeText duration:1];
        }else if([self.form formRowWithTag:kManagerTel].value != nil){
            if (managerTel.length < 11 || managerTel.length > 11)
                {
                [HUDManager showMessage:@"手机号码长度只能是11位" duration:1];
                
                }else{
                    /**
                     * 移动号段正则表达式
                     */
                    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
                    /**
                     * 联通号段正则表达式
                     */
                    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
                    /**
                     * 电信号段正则表达式
                     */
                    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
                    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
                    BOOL isMatch1 = [pred1 evaluateWithObject:managerTel];
                    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
                    BOOL isMatch2 = [pred2 evaluateWithObject:managerTel];
                    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
                    BOOL isMatch3 = [pred3 evaluateWithObject:managerTel];
                    
                    if (isMatch1 || isMatch2 || isMatch3) {
                       
                    }else{
                        [HUDManager showMessage:@"请输入正确的手机号码" duration:1];
                    }

            }
    
        }else {
        NSArray *pro_agents=[self parsingString:_section.formRows];
        
        Common *common=[[Common alloc] initWithView:self.view];
        if (common.isConnectionAvailable) {
            //[HUDManager showMessage:@"正在提交"];
            //[self readNSUserDefaults];
            AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
            HMG_SAVE_STORE *param=[[HMG_SAVE_STORE alloc] init];
            param.IN_EMP_NO = appDelegate.userInfo1.EMP_NO;
            param.IN_DEPT_CD = appDelegate.userInfo1.DEPT_CD;
            param.IN_STORE_NM = name;
            param.IN_STORE_TYPE =type.ID;
            param.IN_STORE_LEADER = manager;
            param.IN_STORE_MANAGER_TEL = managerTel;
            param.IN_STORE_TEL = Tel;
            param.IN_PRODUCTS = [pro_agents objectAtIndex:0];
            param.IN_AGENTS = [pro_agents objectAtIndex:1];
//            NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@,%@",param.IN_EMP_NO,param.IN_DEPT_CD,param.IN_STORE_NM,param.IN_STORE_TYPE,param.IN_STORE_LEADER,param.IN_STORE_MANAGER_TEL,param.IN_STORE_TEL,param.IN_PRODUCTS,param.IN_AGENTS);
            NSString *paramXml=[SoapHelper objToDefaultSoapMessage:param];
            [self.serviceHelper resetQueue];
            ASIHTTPRequest *request1=[ServiceHelper commonSharedRequestMethod:@"HMG_SAVE_STORE" soapMessage:paramXml];
            [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"HMG_SAVE_STORE",@"name", nil]];
            [self.serviceHelper addRequestQueue:request1];
            
            [self.serviceHelper startQueue];
        }

        
    }
    
}
//点击添加按钮
-(void)didTouchButton:(XLFormRowDescriptor *)sender
{
    CooProduct *cooProduct = [self.form formRowWithTag:kCooProuct].value;
    
    AgentRelation *agentRel = [self.form formRowWithTag:kAgent].value;
    
    if(cooProduct!=nil && agentRel !=nil)
    {
        NSString *tag=[NSString stringWithFormat:@"%@:%@",cooProduct.ID,agentRel.CD];
        
        if (![self isExists:tag]) {
            
            self.row = [XLFormRowDescriptor formRowDescriptorWithTag:tag rowType:XLFormRowDescriptorTypeInfo title:cooProduct.NAME];
            self.row.value = agentRel.NAME;
            [self.section addFormRow:self.row];
        }
    }
}

//记录是否存在
-(BOOL) isExists:(NSString *)tag
{
    if([self.form formRowWithTag:tag]==nil)
    {
        return NO;
    }
    else
    {return YES;}
}
//解析字符串
-(NSArray *) parsingString:(NSMutableArray *)rows
{
    NSMutableString *products= [[NSMutableString alloc] initWithString:@""];
    NSMutableString *agents=[[NSMutableString alloc] initWithString:@""];
    
    
    for(XLFormRowDescriptor *row in rows)
    {
        NSString *str=row.tag;
        NSRange range;
        range = [str rangeOfString:@":"];
        int index=range.location;
        
        NSLog([str substringToIndex:index]);
        NSLog([str substringFromIndex:(index+1)]);
        [products appendFormat:[NSString stringWithFormat:@"%@#",[str substringToIndex:index]]];
        [agents appendFormat:[NSString stringWithFormat:@"%@#",[str substringFromIndex:(index+1)]]];
    }
    
    NSLog(@"产品：%@",products);
    NSLog(@"经销商：%@",agents);
    
    NSArray *array=[NSArray arrayWithObjects:products,agents, nil];
    
    return array;
}


-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    XLFormRowDescriptor *selectedAgent=[self.form formRowWithTag:kAgent];
    selectedAgent.value=nil;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    
    NSLog(@"-----------------");
}
//返回
-(void) goBack
{
    [[self.form formRowWithTag:kCooProuct] removeObserver:self forKeyPath:@"value" context:nil];
    [self.navigationController popViewControllerAnimated:YES];
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

-(void) finishSingleRequestSuccess:(NSData *)xml userInfo:(NSDictionary *)dic
{
    /**保存门店接口**/
    if ([@"HMG_SAVE_STORE" isEqualToString:[dic objectForKey:@"name"]]) {
        CommonResult *result4=[[CommonResult alloc] init];
        NSMutableArray *array22 =[[NSMutableArray alloc] init];
        [array22 addObjectsFromArray:[result4 searchNodeToArray:xml nodeName:@"NewDataSet"]];
        if ([result4.OUT_RESULT isEqualToString:@"0"]) {
            [HUDManager showSuccessWithMessage:@"保存成功" duration:1 complection:^{
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }];
            
        }
        else
        {
            [HUDManager showSuccessWithMessage:result4.OUT_RESULT_NM duration:1 complection:^{
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }];
        }
    }
}


@end
