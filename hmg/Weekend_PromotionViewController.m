    //
    //  Weekend_PromotionViewController.m
    //  hmg
    //
    //  Created by hongxianyu on 2016/11/28.
    //  Copyright © 2016年 com.lz. All rights reserved.
    //

#import "Weekend_PromotionViewController.h"
#import "UIView+SDAutoLayout.h"
#import "KSDatePicker.h"
    //#import "HJTCommbox.h"
#import "MainCell.h"
#import "LYChooseTool.h"
#import "ProuctTableViewController.h"
#import "prouctSection.h"
#import "SoapHelper.h"
#import "CommonResult.h"
#import "Common.h"
#import "INSERT_WEEK_PROMOTION_NEW.h"
#import "AppDelegate.h"
#import "BrandTableViewController1.h"
#import "IQKeyboardManager.h"
#import "Store.h"
static NSString *kCellIdentfier = @"UITableViewCell";
static NSString *kHeaderIdentifier = @"HeaderView";

@interface Weekend_PromotionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView *tableView1;
    
    NSArray *arr;
    NSArray *_rowArray;
    NSMutableArray *_sectionArray;
    
    UIButton *StoreButton;
    UILabel *StoreName1;//门店名字
    
    UIButton *dateButton;//
    NSString *Selectdate;
    UILabel *dateName;//时间
    UIButton  *BrandButton;
    UITextField *money1;
    NSString *store1;
    NSString *date1;
    NSString *brand2;
    
    UITextField *text1;
    NSArray *array;
    NSMutableArray *selectedArr;//二级列表是否展开状态
    prouctSection *section2;
    prouctSection *section1;
    
    NSArray *_keys;
    NSMutableDictionary *_source;
    
    NSArray *_keys1;
    NSMutableDictionary *_source1;
    
    
    
}
@property (nonatomic, strong) NSMutableArray *sectionDataSources;
@end

@implementation Weekend_PromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _keys = [[NSArray alloc]initWithObjects:@"StoreName", @"StoreID",nil];
    
    _source = [[NSMutableDictionary alloc] initWithObjects:@[@"",@""] forKeys:_keys];
    
    
    _keys1 = [[NSArray alloc]initWithObjects:@"BrandName",@"BrandID",nil];
    
    _source1 = [[NSMutableDictionary alloc] initWithObjects:@[@"",@""] forKeys:_keys1];
    tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 186, mainW,mainH - 250) style:UITableViewStylePlain];
    tableView1.delegate = self;
    tableView1.dataSource = self;
        //不要分割线
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        //tableView1.backgroundColor = [UIColor redColor];
    tableView1.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView1];
    
    selectedArr = [[NSMutableArray alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    self.serviceHelper=[[ServiceHelper alloc] initWithDelegate:self];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    self.navigationItem.title=@"填写周末促";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(savePromotion)];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];
        //[self creatUI];
    CGFloat margin = 5;
    
    UILabel *store = [[UILabel alloc]init];
    StoreName1 = [[UILabel alloc]init];//门店
    StoreButton = [[UIButton alloc]init];
    UILabel *date = [[UILabel alloc]init];
    dateButton = [[UIButton alloc]init];//时间
    dateName = [[UILabel alloc]init];
    UILabel *brand = [[UILabel alloc]init];
    BrandButton = [[UIButton alloc]init];//品牌
    UILabel *money = [[UILabel alloc]init];
    money1 = [[UITextField alloc]init];//金额
    
    
    store.text = @"门店";
    store.font = Font;
    [self.view addSubview:store];
    store.sd_layout
    .leftSpaceToView(self.view, margin)
    .topSpaceToView(self.view, margin)
    .widthIs(40)
    .heightIs(40);
    
    
//    StoreButton.backgroundColor = [UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0];
    StoreButton.backgroundColor = [self colorWithHexString:@"#7C7C7C" alpha:0.5];
     StoreButton.layer.cornerRadius = 5;
    [StoreButton addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
   
    [StoreButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.view addSubview:StoreButton];
    StoreButton.sd_layout
    .leftSpaceToView(store, margin)
    .topSpaceToView(self.view, margin)
    .rightSpaceToView(self.view, margin)
    .heightIs(40);
    
    
    
    
    date.text = @"日期";
    date.font =Font;
    [self.view addSubview:date];
    date.sd_layout
    .leftSpaceToView(self.view, margin)
    .topSpaceToView(store, margin)
    .widthIs(40)
    .heightIs(40);
    
    dateButton.backgroundColor = [self colorWithHexString:@"#7C7C7C" alpha:0.5];
    dateButton.layer.cornerRadius = 5;
    [dateButton addTarget:self action:@selector(dateBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [dateButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    
    [self.view addSubview:dateButton];
    
    
    
    dateButton.sd_layout
    .leftSpaceToView(date, margin)
    .topSpaceToView(StoreButton, margin)
    .rightSpaceToView(self.view, margin)
    .heightIs(40);
    
    brand.text = @"品牌";
    brand.font = Font;
    [self.view addSubview:brand];
    brand.sd_layout
    .leftSpaceToView(self.view, margin)
    .topSpaceToView(date, margin)
    .widthIs(40)
    .heightIs(40);
    
    
    BrandButton.backgroundColor = [self colorWithHexString:@"#7C7C7C" alpha:0.5];
    BrandButton.layer.cornerRadius = 5;
    
    [BrandButton addTarget:self action:@selector(brandBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [BrandButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.view addSubview:BrandButton];
    BrandButton.sd_layout
    .leftSpaceToView(brand, margin)
    .topSpaceToView(dateButton, margin)
    .rightSpaceToView(self.view, margin)
    .heightIs(40);
    
    money.text = @"POS金额";
    money.font = Font;
    
    money.textColor = [UIColor blackColor];
    [self.view addSubview:money];
    money.sd_layout
    .leftSpaceToView(self.view, margin)
    .topSpaceToView(brand, margin)
    .widthIs(80)
    .heightIs(40);
    
    money1.backgroundColor = [self colorWithHexString:@"#7C7C7C" alpha:0.5];
    money1.textColor = [UIColor whiteColor];
    money1.layer.cornerRadius = 5;
    money1.textAlignment = NSTextAlignmentCenter;
    money1.font = Font;
    money1.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:money1];
    money1.sd_layout
    .leftSpaceToView(money,margin)
    .topSpaceToView(brand ,margin)
    .rightSpaceToView(self.view,margin)
    .heightIs(40);
    
    
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
    [StoreButton setTitle:_source[_keys[0]] forState:UIControlStateNormal];
    [BrandButton setTitle:_source1[_keys1[0]] forState:UIControlStateNormal];

    NSMutableArray *tempArray = [[LYChooseTool sharedLYChooseTool] dataArray];
    BOOL haveSameObj = NO;
    for (NSInteger i = 0; i < tempArray.count; i++) {
        prouctSection *s = tempArray[i];
        if ([BrandButton.titleLabel.text isEqualToString:s.NAME]) {
            haveSameObj = YES;
        }
    }
    if (!haveSameObj) {
        if (![_source1[_keys1[0]] isEqualToString:@""] && ![BrandButton.titleLabel.text isEqualToString:@""]) {
        prouctSection *section = [[prouctSection alloc]initWithID:_source1[_keys1[1]] andNAME:_source1[_keys1[0]]];
            NSLog(@"y-------------%@",section.NAME);
        [[LYChooseTool sharedLYChooseTool] ly_addObject:section];
        }
       [tableView1 reloadData];
    }
}
-(void)dateBtnPressed:(UIButton *)sender{
        //x,y 值无效，默认是居中的
    KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 300)];
    
    picker.appearance.radius = 5;
    
        //设置回调
    picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
        
        if (buttonType == KSDatePickerButtonCommit) {
            
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            [sender setTitle:[formatter stringFromDate:currentDate] forState:UIControlStateNormal];
        }
    };
        // 显示
    [picker show];
    
}

#pragma mark----tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [[[LYChooseTool sharedLYChooseTool] dataArray] count];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    array = [[LYChooseTool sharedLYChooseTool] dataArray];
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainW, 30)];
        view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 150, 40)];
    titleLabel.text = [[array objectAtIndex:section] NAME];
        if (![titleLabel.text isEqualToString:@""]) {
             [view addSubview:titleLabel];
        }
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
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(mainW - 70, 5, 60, 30);
    button1.tag = 200+section;
    [button1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:13];
    button1.backgroundColor = [UIColor lightGrayColor];
    [button1 setTitle:@"添加产品" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(doButton1:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button1];
    return view;
    
}
    //每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    NSLog(@"%@`````",string);
    
    if ([selectedArr containsObject:string]) {
        section1 = [[[LYChooseTool sharedLYChooseTool] dataArray] objectAtIndex:section];
        NSLog(@"%@-----",section1);
        NSLog(@"%lu-------",(unsigned long)section1.prouctArray.count);
        return section1.prouctArray.count;
    }
    return 0;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    prouctSection *productS = [[[LYChooseTool sharedLYChooseTool] dataArray] objectAtIndex:indexPath.section];
    Prouct *prouct = (Prouct *)[productS.prouctArray objectAtIndex:indexPath.row];
    MainCell *cell = [MainCell loadCellViewWithTableView:tableView];
    cell.model = prouct;
    
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
    return 60;
}

-(void)btnPressed:(UIButton *)sender{
    
    StoreTableViewController1 *stc = [[StoreTableViewController1 alloc]init];
    stc.dic1 = _source;
    [self.navigationController pushViewController:stc animated:YES];
}

-(void)brandBtnPressed:(UIButton *)sender{
    
    BrandTableViewController1 *btvc = [[BrandTableViewController1 alloc]init];
    btvc.dic2 = _source1;
    [self.navigationController pushViewController:btvc animated:YES];
    
}
    //返回
-(void)back{
    [[LYChooseTool sharedLYChooseTool] destroy];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
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
    
    [tableView1 reloadData];
}


-(void)doButton1:(UIButton *)sender{
    
    ProuctTableViewController *pvc = [[ProuctTableViewController alloc]init];
        //[pvc setValue:_BrandID forKey:@"prouctId"];
    pvc.productModel1 = [[[LYChooseTool sharedLYChooseTool]dataArray]objectAtIndex:sender.tag - 200];
    
    [[[[[LYChooseTool sharedLYChooseTool]dataArray]objectAtIndex:sender.tag - 200]prouctArray]removeAllObjects];
    
    [tableView1 reloadData];
    
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void)savePromotion
{
    NSString *storename = [StoreButton titleForState:UIControlStateNormal];
    NSString *date = [dateButton titleForState:UIControlStateNormal];
    NSString *brand = [BrandButton titleForState:UIControlStateNormal];
    NSString *posMoney = money1.text;
    if ([storename isEqualToString:@""] || [date isEqualToString:@""] || [brand isEqualToString:@""] || [posMoney isEqualToString:@""]) {
        [HUDManager showMessage:@"信息不完整" duration:1];
    } else {
    NSInteger sum = 0;
    NSString *qty=@"";
    NSString *proctID=@"";
    for (int i=0; i<array.count; i++){
        section2 = [[[LYChooseTool sharedLYChooseTool]dataArray] objectAtIndex:i];
        
        if (section2.prouctArray.count == 0) {
            [HUDManager showMessage:@"请添加产品" duration:1];
        } else {
            sum = [[[[[LYChooseTool sharedLYChooseTool]dataArray] objectAtIndex:i]prouctArray]count];
            for (int j = 0; j < sum; j++) {
                NSString *prouctid1 =  [[[section2 prouctArray]objectAtIndex:j]PROD_ID];
                NSString *qty1 = [[[section2 prouctArray]objectAtIndex:j]count1];
                
                if (qty1 == nil) {
                    [HUDManager showMessage:@"数量不能为空" duration:1];
                } else {
                    proctID = [proctID stringByAppendingString:[NSString stringWithFormat:@"%@#",prouctid1]];
                    qty = [qty stringByAppendingString:[NSString stringWithFormat:@"%@#",qty1]];
                    [self communicateServiceWithIN_PROD_ID:proctID andIN_QTY:qty];
                    
                }
                
            }
            
        }
    }
        NSLog(@"%@",proctID);
        NSLog(@"%@",qty);
        
}
}
-(void) communicateServiceWithIN_PROD_ID:(NSString *) IN_PROD_ID andIN_QTY:(NSString *) IN_QTY
{
    NSString *time= dateButton.titleLabel.text;
    
    Common *common=[[Common alloc] initWithView:self.view];
    
    if (common.isConnectionAvailable) {
            //[HUDManager showMessage:@"正在提交"];
        AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
        INSERT_WEEK_PROMOTION_NEW *param=[[INSERT_WEEK_PROMOTION_NEW alloc] init];
        param.IN_PROD_ID = IN_PROD_ID;
        param.IN_QTY = IN_QTY;
        param.IN_STORE_ID = _source[_keys[1]];
        param.IN_PROM_DTM = [[[time substringToIndex:4] stringByAppendingString:[time substringWithRange:NSMakeRange(5, 2)]]stringByAppendingString:[time substringWithRange:NSMakeRange(8, 2)]];
        param.IN_INP_USER = appDelegate.userInfo1.EMP_NO;
        param.IN_POS_MONEY = money1.text;
        NSLog(@"%@,%@,%@,%@,%@,%@",param.IN_STORE_ID,param.IN_PROM_DTM,param.IN_INP_USER,param.IN_POS_MONEY,param.IN_PROD_ID,param.IN_QTY);
        NSString *paramXml=[SoapHelper objToDefaultSoapMessage:param];
        
        [self.serviceHelper resetQueue];
        ASIHTTPRequest *request1=[ServiceHelper commonSharedRequestMethod:@"INSERT_WEEK_PROMOTION_NEW" soapMessage:paramXml];
        [request1 setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"INSERT_WEEK_PROMOTION_NEW",@"name", nil]];
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
    [HUDManager showErrorWithMessage:@"网络错误" duration:1];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(void) finishSingleRequestSuccess:(NSData *)xml userInfo:(NSDictionary *)dic
{
    /**保存周末促接口**/
    if ([@"INSERT_WEEK_PROMOTION_NEW" isEqualToString:[dic objectForKey:@"name"]]) {
        CommonResult *result4=[[CommonResult alloc] init];
        NSMutableArray *array22 =[[NSMutableArray alloc] init];
        [array22 addObjectsFromArray:[result4 searchNodeToArray:xml nodeName:@"NewDataSet"]];
        if ([result4.OUT_RESULT isEqualToString:@"0"]) {
            [HUDManager showSuccessWithMessage:@"上传成功" duration:2 complection:^{
                [[LYChooseTool sharedLYChooseTool] destroy];
                
                [tableView1 reloadData];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }];
            
        }
        else
            {
            [HUDManager showSuccessWithMessage:result4.OUT_RESULT_NM duration:2 complection:^{
                [[LYChooseTool sharedLYChooseTool] destroy];
                
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            }];
            }
    }
}

    //点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
    // 点击屏幕的时候
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
        // 强制结束所有的编辑
    [self.view endEditing:YES];
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
