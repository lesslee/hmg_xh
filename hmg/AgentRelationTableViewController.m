    //
    //  AgentRelationTableViewController.m
    //  hmg
    //
    //  Created by hongxianyu on 2016/7/21.
    //  Copyright © 2016年 com.lz. All rights reserved.
    //

#import "AgentRelationTableViewController.h"
#import "AgentRelation.h"
#import "HMG_AGENT_RELATION.h"
#import "ASINetworkQueue.h"
#import "Common.h"
#import "SoapHelper.h"
#import <UIKit/UIKit.h>
#import "AgentRelationCellTableViewCell.h"
#import "AppDelegate.h"
#import "UIView+XLFormAdditions.h"
    //#import "LYChooseTool2.h"
ASIHTTPRequest *request;
@interface AgentRelationTableViewController()
{

    NSMutableDictionary *dic1;
}
    //经销商集合
@property (nonatomic ,strong) NSMutableArray  *agentRelArray;


@property(nonatomic, strong)AgentRelation *agentRelation;

@end
@implementation AgentRelationTableViewController
UITableView *tableView;
NSMutableArray *agentArray;
@synthesize rowDescriptor = _rowDescriptor;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    self.agentRelArray = [[NSMutableArray alloc]init];
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 65)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    
    tableView.dataSource=self;
    tableView.delegate=self;
    
    [self.serviceHelper startQueue];
    
    [self agentRelation1];
    
    
}

-(void) agentRelation1
{
    
    [self readNSUserDefaults];
    
    AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
    Common *common=[[Common alloc] initWithView:self.view];
    if (common.isConnectionAvailable) {
        HMG_AGENT_RELATION *param=[[HMG_AGENT_RELATION alloc] init];
        
        param.IN_AGENT_PRODUCT = self.cooProductId1;
        param.IN_EMP_NO = appDelegate.userInfo1.EMP_NO;
        NSLog(@"%@,%@",param.IN_AGENT_PRODUCT , param.IN_EMP_NO);
        
        NSString *paramXml=[SoapHelper objToDefaultSoapMessage:param];
        [self.serviceHelper resetQueue];
        request=[ServiceHelper commonSharedRequestMethod:@"HMG_AGENT_RELATION" soapMessage:paramXml];
        [request setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"HMG_AGENT_RELATION",@"name", nil]];
        [self.serviceHelper addRequestQueue:request];
        [self.serviceHelper startQueue];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.serviceHelper) {
        self.serviceHelper = [[ServiceHelper alloc]initWithDelegate:self];
    }
    [self.navigationItem setTitle:@"选择经销商"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
        //self.navigationController.navigationBar.barTintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg.png"]];
    
    [self.navigationController setNavigationBarHidden:NO];
    
}

-(void) goBack
{
    [self.serviceHelper resetQueue];
    self.serviceHelper=nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.agentRelArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AgentRelationCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentRelationCellTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"AgentRelationCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"AgentRelationCellTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AgentRelationCellTableViewCell"];
    }
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor whiteColor];
    }
    else
        {
        cell.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1.0];
        }
    
    cell.layer.masksToBounds=YES;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    AgentRelationCellTableViewCell *tempCell = (AgentRelationCellTableViewCell *)cell;
    AgentRelation *agentRelationModel =(AgentRelation *)[self.agentRelArray objectAtIndex:indexPath.row];
    tempCell.AgentRelationName.text = agentRelationModel.NAME;
    
    NSLog(@"%@11",agentRelationModel.NAME);
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AgentRelation *model=(AgentRelation *)[self.agentRelArray objectAtIndex:indexPath.row];
       
    self.rowDescriptor.value = model;
    NSLog(@"%@",self.rowDescriptor.value);
    NSLog(@"%@,%@",model.CD,model.NAME);
    
        //[_agentRelModel1.agentRelArray1 addObject:_agentRelation];
    
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]){
        
        [self.serviceHelper resetQueue];
        self.serviceHelper=nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"_cooProductId"];
    _cooProductId1 = myString;
    NSLog(@"%@0000000",_cooProductId1);
    
}


#pragma mark 服务器请求结果

-(void) finishQueueComplete
{
    
}

-(void) finishSingleRequestFailed:(NSError *)error userInfo:(NSDictionary *)dic
{
    [HUDManager showErrorWithMessage:@"网络错误" duration:1];
        //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
}

    //请求成功，解析结果
-(void) finishSingleRequestSuccess:(NSData *)xml userInfo:(NSDictionary *)dic
{
    
    if ([@"HMG_AGENT_RELATION" isEqualToString:[dic objectForKey:@"name"]]) {
        
        AgentRelation *tempNotify1=[[AgentRelation alloc] init];
        [self.agentRelArray addObjectsFromArray:[tempNotify1 searchNodeToArray:xml nodeName:@"NewDataSet"]];
        NSLog(@"%@44",self.agentRelArray);
        [tableView reloadData];
       
        [HUDManager hide];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}



@end

