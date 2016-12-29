//
//  SixViewController.m
//  hmg
//
//  Created by hongxianyu on 2016/12/20.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "SixViewController.h"
#import "XLForm.h"
#import "InterviewViewController.h"
#import "StoreVisitNumberViewController.h"
#import "BusinessViewController.h"
#import "StockViewController.h"
#import "ExpenseViewController.h"
#import "StoresViewController.h"
#import "AchievementViewController.h"
@interface SixViewController ()

@end
NSString * const khmg8= @"khmg8";
NSString * const khmg9 = @"khmg9";
NSString * const khmg10 = @"khmg10";
NSString * const khmg11 = @"khmg11";
NSString * const khmg12 = @"khmg12";
NSString * const khmg13 = @"khmg13";
NSString * const khmg14 = @"khmg14";

@implementation SixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationItem setTitle:@"六大报表"];
        //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
        // self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
        //self.navigationController.navigationBar.barTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.png"]];
    
    [self.navigationController setNavigationBarHidden:NO];
}
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
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    section = [XLFormSectionDescriptor formSectionWithTitle:@"六大报表"];
    [form addFormSection:section];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khmg8 rowType:XLFormRowDescriptorTypeButton title:@"走访报表"];
    row.action.viewControllerClass = [InterviewViewController class];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khmg9 rowType:XLFormRowDescriptorTypeButton title:@"门店走访次数"];
    row.action.viewControllerClass = [StoreVisitNumberViewController class];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khmg10 rowType:XLFormRowDescriptorTypeButton title:@"出差报表"];
    row.action.viewControllerClass = [BusinessViewController class];
    [section addFormRow:row];
    
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khmg11 rowType:XLFormRowDescriptorTypeButton title:@"库存报表"];
    row.action.viewControllerClass = [StockViewController class];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khmg12 rowType:XLFormRowDescriptorTypeButton title:@"费用报表"];
    row.action.viewControllerClass = [ExpenseViewController class];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khmg13 rowType:XLFormRowDescriptorTypeButton title:@"门店数量报表"];
    row.action.viewControllerClass = [StoresViewController class];
    [section addFormRow:row];
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khmg14 rowType:XLFormRowDescriptorTypeButton title:@"业绩报表"];
    row.action.viewControllerClass = [AchievementViewController class];
    [section addFormRow:row];
    self.form = form;
}
-(void) goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
