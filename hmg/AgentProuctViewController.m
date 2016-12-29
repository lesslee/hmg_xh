    //
    //  AgentProuctViewController.m
    //  hmg
    //
    //  Created by hongxianyu on 2016/7/22.
    //  Copyright © 2016年 com.lz. All rights reserved.
    //

#import "AgentProuctViewController.h"
#import "StoreAddViewController.h"
#import "LYChooseTool.h"
#import "SoapHelper.h"
#import "CommonResult.h"
#import "Common.h"
#import "AppDelegate.h"
#import "HMG_SAVE_STORE.h"
#import "CooProduct.h"
#import "AgentSection.h"
#import "AgentRelation.h"
#import "AgentRelCell.h"

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
@interface AgentProuctViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    
    UITableView *_tableView;
    NSMutableArray *selectedArr;//二级列表是否展开状态
    
    
}

@property (nonatomic ,strong) NSMutableArray *sources;

@end

@implementation AgentProuctViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    self.navigationItem.title=@"产品列表";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStyleBordered target:self action:@selector(goStore)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(saveStore)];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    selectedArr = [[NSMutableArray alloc] init];
    
        //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
        //不要分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];
    
    NSArray *storeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"__storeArray__"];
    NSLog(@"storeArray = %@", storeArray);
    [storeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CooProduct *product = [[CooProduct alloc] init];
        product.ID = [obj objectForKey:@"productID"];
        product.NAME = [obj objectForKey:@"productName"];
        
        NSMutableArray *agents = [[NSMutableArray alloc] init];
        [[obj objectForKey:@"agents"] enumerateObjectsUsingBlock:^(id  _Nonnull a, NSUInteger idx, BOOL * _Nonnull stop) {
            AgentRelation *agent = [[AgentRelation alloc] init];
            agent.CD = [a objectForKey:@"ID"];
            agent.NAME = [a objectForKey:@"Name"];
            
            [agents addObject:agent];
        }];
        
        [self.sources addObject:@[product, agents]];
    }];
}

- (NSMutableArray *)sources {
    if (_sources == nil) {
        _sources = [[NSMutableArray alloc] init];
    }
    
    return _sources;
}

-(void)goStore{
    
        //  StoreAddViewController  *addVc = [[StoreAddViewController alloc]init];
        //[self saveNSUserDefaults];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark----tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sources.count;
}

    //设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = [self.sources objectAtIndex:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 150, 40)];
    CooProduct *product = [array objectAtIndex:0];
    titleLabel.text = product.NAME;
    
    [view addSubview:titleLabel];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 15, 20)];
    imageView.tag = 20000+section;
        //判断是不是选中状态
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    if ([selectedArr containsObject:string]) {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
    }
    else
        {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_right@2x.png"];
        }
    [view addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 220, 40);
    button.tag = 100+section;
    [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}




    //每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    NSLog(@"%@`````",string);
    
    if ([selectedArr containsObject:string]) {
        
        UIImageView *imageV = (UIImageView *)[_tableView viewWithTag:20000+section];
        imageV.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
        
        NSArray *array = [self.sources objectAtIndex:section];
        NSArray *agents = [array lastObject];
        return agents.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self.sources objectAtIndex:indexPath.section];
    NSArray *agents = [array lastObject];
    AgentRelCell *cell = [AgentRelCell loadCellViewWithTableView1:tableView];
    cell.model = [agents objectAtIndex:indexPath.row];
    
    cell.layer.masksToBounds=YES;
    
    return cell;
    
}


    //设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

    //Section Footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


-(void)doButton:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)(sender.tag-100)];
    
        //数组selectedArr里面存的数据和表头相对应，方便以后做比较
    if ([selectedArr containsObject:string])
        {
        [selectedArr removeObject:string];
        }
    else
        {
        [selectedArr addObject:string];
        }
    
    [_tableView reloadData];
}

-(void)saveStore{
    __block NSString *pid = @"";
    __block NSString *aid = @"";
    [self.sources enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 当前section显示的产品模型
        CooProduct *product = [obj objectAtIndex:0];
        
        pid = [NSString stringWithFormat:@"%@%@#", pid, product.ID];
        
            // 获取该产品下的所有经销商
        NSArray *agents = [obj objectAtIndex:1];
        [agents enumerateObjectsUsingBlock:^(AgentRelation *agentRel, NSUInteger idx, BOOL * _Nonnull stop) {
                // 获取经销商ID
            aid = [NSString stringWithFormat:@"%@%@#", aid, agentRel.CD];
            
            [self communicateServiceWithIN_PRODUCTS_ID:pid andIN_AGENTS:aid];
        }];
    }];

}


-(void) communicateServiceWithIN_PRODUCTS_ID:(NSString *) IN_PRODUCTS_ID andIN_AGENTS:(NSString *) IN_AGENTS
{
    Common *common=[[Common alloc] initWithView:self.view];
    if (common.isConnectionAvailable) {
            //[HUDManager showMessage:@"正在提交"];
            //[self readNSUserDefaults];
        AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
        HMG_SAVE_STORE *param=[[HMG_SAVE_STORE alloc] init];
        param.IN_EMP_NO = appDelegate.userInfo1.EMP_NO;
        param.IN_DEPT_CD = appDelegate.userInfo1.DEPT_CD;
        param.IN_STORE_NM = self.name;
        param.IN_STORE_TYPE =self.type.ID;
        param.IN_STORE_LEADER = self.manager;
        param.IN_STORE_MANAGER_TEL = self.managerTel;
        param.IN_STORE_TEL = self.tel;
        param.IN_PRODUCTS = IN_PRODUCTS_ID;
        param.IN_AGENTS = IN_AGENTS;
        NSLog(@"%@,%@,%@,%@,%@,%@,%@,%@,%@",param.IN_EMP_NO,param.IN_DEPT_CD,param.IN_STORE_NM,param.IN_STORE_TYPE,param.IN_STORE_LEADER,param.IN_STORE_MANAGER_TEL,param.IN_STORE_TEL,param.IN_PRODUCTS,param.IN_AGENTS);
        NSString *paramXml=[SoapHelper objToDefaultSoapMessage:param];
        [self.serviceHelper resetQueue];
        ASIHTTPRequest *request1=[ServiceHelper commonSharedRequestMethod:@"HMG_SAVE_STORE" soapMessage:paramXml];
        [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"HMG_SAVE_STORE",@"name", nil]];
        [self.serviceHelper addRequestQueue:request1];
        
        [self.serviceHelper startQueue];
    }
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
            [HUDManager showSuccessWithMessage:@"上传成功" duration:1 complection:^{
                    // 清空产品列表和经销商
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"__storeArray__"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [_tableView reloadData];
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }];
            
        }
        else
            {
            [HUDManager showSuccessWithMessage:result4.OUT_RESULT_NM duration:1 complection:^{
                    // 清空产品列表和经销商
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"__storeArray__"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                [_tableView reloadData];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }];
            }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}






@end
