    //
    //  DateSelector_D.m
    //  hmg
    //
    //  Created by Hongxianyu on 16/4/19.
    //  Copyright © 2016年 com.lz. All rights reserved.
    //

#import "DateSelector_D.h"
#import "Brand1TableViewController.h"
#import "StoreTableViewController.h"
#import "WeekendViewController.h"
    //#import "Store.h"
    //#import "Brand1.h"
NSString *const kStartDateA2 = @"startDateA2";
    //
NSString *const kEndDateA2 = @"endDateA2";

NSString *const kSearchA2 = @"searchA2";

NSString *const Kstore12 = @"Kstore12";
NSString *const Kbrand12 = @"Kbrand12";

@implementation DateSelector_D

@synthesize trendDelegate=_trendDelegate;

XLFormDescriptor * formDescriptor;
XLFormSectionDescriptor * section;
XLFormRowDescriptor * row;

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self){
        [self initializeForm];
    }
    
    return self;
}

-(id) init
{
    self = [super init];
    if (self) {
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
    
    formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"周末促查询"];
    
    section=[XLFormSectionDescriptor formSection];
    section.title=@"请选择日期";
    [formDescriptor addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kStartDateA2 rowType:XLFormRowDescriptorTypeDateInline title:@"开始日期"];
    NSTimeInterval secondsPerDay1 = 24*60*60*7;
    NSDate *now = [NSDate date];
    NSDate *lastWeek = [now dateByAddingTimeInterval:-secondsPerDay1];
    
    row.value = lastWeek;
    
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kEndDateA2 rowType:XLFormRowDescriptorTypeDateInline title:@"结束日期"];
    
    row.value =[NSDate date];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:Kstore12 rowType:XLFormRowDescriptorTypeSelectorPush title:@"门店:"];
    row.action.viewControllerClass = [StoreTableViewController class];
    
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:Kbrand12 rowType:XLFormRowDescriptorTypeSelectorPush title:@"品牌:"];
    
    row.action.viewControllerClass = [Brand1TableViewController class];
    [section addFormRow:row];
    self.form = formDescriptor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setTitle:@"日期选择"];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStyleBordered target:self  action:@selector(saveButtonHandle)];
    
}

-(void) goBack
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void) saveButtonHandle
{
    WeekendViewController *vc = [[WeekendViewController alloc]init];
    
    NSDate *startDate1=[self.form formRowWithTag:kStartDateA2].value;
    
    NSDate *endDate1=[self.form formRowWithTag:kEndDateA2].value;
    
    Store  *store = [self.form formRowWithTag:Kstore12].value;
    NSLog(@"%@",store.STORE_ID);
    Brand1 *brand = [self.form formRowWithTag:Kbrand12].value;
    NSLog(@"%@",brand.ID);
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    fmt.dateFormat=@"yyyyMMdd";
    
    if ([[fmt stringFromDate:startDate1] intValue] <=[[fmt stringFromDate:endDate1] intValue]) {
        self.trendDelegate=vc; //设置代理
        
        [self.trendDelegate getSTORE:store andBRAND:brand andSTARTDATE:[fmt stringFromDate:startDate1] andENDDATE:[fmt stringFromDate:endDate1]];
        
            //        [self.delegate getSTORE:store andBRAND:brand andSTARTDATE:[fmt stringFromDate:startDate] andENDDATE:[fmt stringFromDate:endDate]];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
        {
        [HUDManager showMessage:@"日期选择错误" duration:1];
        }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
