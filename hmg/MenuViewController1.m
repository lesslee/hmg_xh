//
//  MenuViewController1.m
//  hmg
//
//  Created by hongxianyu on 2016/11/30.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "MenuViewController1.h"
#import "AddReportViewController.h"
#import "QueryReportViewController.h"
#import "StoreAddViewController.h"
#import "GpsViewController.h"
#import "NotifyViewController.h"
#import "ConsumerViewController.h"
#import "Weekend_PromotionViewController.h"
#import "WeekendViewController.h"
#import "ReportMenuViewController.h"
#import "CustomerLocationViewController.h"
#import "SixViewController.h"
#import "BFPaperButton.h"
#import "CustomButton.h"
#import "AppDelegate.h"
#import "CommonResult.h"
#import "Common.h"
#import "CP_LOGIN_LOG.h"
#import "SoapHelper.h"
#import "Log.h"
    //ShareSDK头文件
#import <ShareSDK/ShareSDK.h>
#import "JPUSHService.h"


#import "Masonry.h"

#import "UserCollectionViewCell.h"
    //#import "SDCycleScrollView.h"
#import "HeaderCRView.h"
#import "ViewController.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#define RGBCOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define Title    @"TITLE"
#define Image    @"IMAGE"

@interface MenuViewController1 ()<UICollectionViewDataSource,UICollectionViewDelegate>

{
    NSString *ID;
    UICollectionView *_collectionView;
    NSMutableArray *dataSourceArray;
    
}
@property (nonatomic, strong) id<ISSShareActionSheet> actionSheet;


@end

@implementation MenuViewController1
id<ISSContainer> container;
- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;//关闭自动调整滚动视图
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self readNSUserDefaults];
    
    /*
     
     设置 设置别名（alias）与标签（tags）
     
     别名 alias每个用户只能指定一个别名
     
     标签 tag可为每个用户打多个标签
     
     */
    
    [JPUSHService setTags:[NSSet setWithObjects:ID, nil] alias:ID fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
    }];
    
    [self log];

    [self creatUI];
    
    [self getDataArray];
}


-(void)creatUI{

    [self.navigationItem setTitle:@"HMG"];
    self.navigationController.navigationBar.titleTextAttributes=[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    
   self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(exitLogin)];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.navigationController.navigationBar.backItem setTitle:@""];
    
    
        //创建一个布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //使用布局创建一个_collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 60) collectionViewLayout:flowLayout];
    
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = YES;
    _collectionView.scrollEnabled = YES;
        //_collectionView.alwaysBounceVertical = YES;
    //注册UICollectionReusableView即headerView（切记要添加headerView一定要先注册）
    [_collectionView registerClass:[HeaderCRView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCRView"];
    
    [self.view addSubview:_collectionView];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    UINib *nibCell = [UINib nibWithNibName:@"UserCollectionViewCell" bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:nibCell forCellWithReuseIdentifier:@"UserCollectionViewCell"];

}

    //添加headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderCRView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCRView" forIndexPath:indexPath];;
    
        //判断上面注册的UICollectionReusableView类型
    if (kind == UICollectionElementKindSectionHeader) {
        return headerView;
    }else {
        return nil;
    }
}
#pragma mark ---UICollectionViewDelegate
    //设置headerView的宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(self.view.bounds.size.width, 160);
}

-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes1 = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes1 stringForKey:@"ID"];
        // NSString *ID1 = [ NSString stringWithFormat:@"%@", myString];
    ID =myString;
    
    NSLog(@"%@0000000",ID);
    
}




-(void)getDataArray{
    dataSourceArray = [NSMutableArray arrayWithArray:@[@{Title:@"日报录入",Image:@"日报.png"},@{Title:@"日报查询",Image:@"日报查询.png"},@{Title:@"新建门店",Image:@"门店.png"},@{Title:@"HMG公告",Image:@"公告.png"},@{Title:@"Consumer公告",Image:@"公告.png"},@{Title:@"考勤",Image:@"考勤.png"},@{Title:@"周末促",Image:@"促销.png"},@{Title:@"促销查询",Image:@"促销查询.png"},@{Title:@"报表",Image:@"报表.png"},@{Title:@"邮箱",Image:@"邮件.png"},@{Title:@"信息采集",Image:@"信息采集.png"},@{Title:@"六大报表",Image:@"报表.png"}]];
}

#pragma mark --- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSourceArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserCollectionViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"UserCollectionViewCell" owner:self options:nil] objectAtIndex:0];
    }
    NSDictionary *dic = [dataSourceArray objectAtIndex:indexPath.row];
    cell.titleLb.text = [dic objectForKey:Title];
    cell.imageView.image = [UIImage imageNamed:[dic objectForKey:Image]];
    
    
    CGSize contentSize = _collectionView.contentSize;
    
    for (NSInteger i = 1; i < 3; i++) {
        UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake((cell.frame.size.width) * i, 160, 0.5, contentSize.height -160 - 2)];
        verticalLine.backgroundColor = [UIColor lightGrayColor];
        [_collectionView addSubview:verticalLine];

    }
    
    for (NSInteger i = 1; i < 5; i++) {
        UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, 160 + (cell.frame.size.height) * i , contentSize.width, 0.5)];
        horizontalLine.backgroundColor = [UIColor lightGrayColor];
        [_collectionView addSubview:horizontalLine];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((_collectionView.frame.size.width-2)/3,(_collectionView.frame.size.width - 2)/3);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- UICollectionViewDelegate
    //UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

NSString *str = [[dataSourceArray objectAtIndex:indexPath.row] objectForKey:Title];

    if ([str isEqualToString:@"日报录入"]) {
        NSLog(@"---日报录入---");
        AddReportViewController *controller = [[AddReportViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"日报查询"]){
        QueryReportViewController *controller = [[QueryReportViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"新建门店"]){
       
       StoreAddViewController *controller = [[StoreAddViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"考勤"]){
    GpsViewController *controller = [[GpsViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"HMG公告"]){
        NotifyViewController *controller = [[NotifyViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"Consumer公告"]){
        
        ConsumerViewController *controller = [[ConsumerViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"周末促"]){
        Weekend_PromotionViewController *controller = [[Weekend_PromotionViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"促销查询"]){
        WeekendViewController *controller = [[WeekendViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"报表"]){
        ReportMenuViewController *controller = [[ReportMenuViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else if ([str isEqualToString:@"邮箱"]){
        
            //1、构造分享内容
            //1.1、要分享的图片（以下分别是网络图片和本地图片的生成方式的示例）
        id<ISSCAttachment> remoteAttachment = [ShareSDKCoreService attachmentWithUrl:@""];
            //1.2、以下参数分别对应：内容、默认内容、图片、标题、链接、描述、分享类型
        id<ISSContent> publishContent = [ShareSDK content:@""
                                           defaultContent:nil
                                                    image:remoteAttachment
                                                    title:@""
                                                      url:@"http://www.mob.com"
                                              description:nil
                                                mediaType:SSPublishContentMediaTypeImage];
            //1+、创建弹出菜单容器（iPad应用必要，iPhone应用非必要）
            //    id<ISSContainer> container = [ShareSDK container];
            //    [container setIPadContainerWithView:sender
            //                            arrowDirect:UIPopoverArrowDirectionUp];
        
            //2、展现分享菜单
        [ShareSDK showShareActionSheet:container
                             shareList:nil
                               content:publishContent
                         statusBarTips:NO
                           authOptions:nil
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    NSLog(@"=== response state :%zi ",state);
                                    
                                        //可以根据回调提示用户。
                                    if (state == SSResponseStateSuccess)
                                        {
                                            //                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送成功"
                                            //                                                                                    message:nil
                                            //                                                                                   delegate:self
                                            //                                                                          cancelButtonTitle:@"确定"
                                            //                                                                          otherButtonTitles:nil, nil];
                                            //                                    [alert show];
                                        [HUDManager showMessage:@"发送成功" duration:1];
                                        }
                                    else if (state == SSResponseStateFail)
                                        {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告!"
                                                                                        message:[NSString stringWithFormat:@"警告信息：%@",[error errorDescription]]
                                                                                       delegate:self
                                                                              cancelButtonTitle:@"确定"
                                                                              otherButtonTitles:nil, nil];
                                        [alert show];
                                        }
                                }];
        

    }else if ([str isEqualToString:@"信息采集"]){
        CustomerLocationViewController *controller = [[CustomerLocationViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if ([str isEqualToString:@"六大报表"]){
        SixViewController *controller = [[SixViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }

}
-(void)log{
    
    Common *common=[[Common alloc] initWithView:self.view];
    
    if (common.isConnectionAvailable) {
        AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
        CP_LOGIN_LOG *param=[[CP_LOGIN_LOG alloc] init];
        param.IN_SABEON = appDelegate.userInfo1.EMP_NO;
        NSLog(@"%@",param.IN_SABEON);
        
        param.IN_COMPANY = @"HMG";
        
        NSDictionary *infoDict = [[NSBundle mainBundle]infoDictionary];
        NSString *Version = [infoDict objectForKey:@"CFBundleShortVersionString"];
        
        param.IN_VERSION = Version;
        
        NSLog(@"%@",param.IN_VERSION);
        
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSLog(@"%@",identifierForVendor);
        param.IN_IMEI_CODE = identifierForVendor;
        NSString *paramXml=[SoapHelper objToDefaultSoapMessage:param];
        
        NSLog(@"%@",param);
        NSLog(@"%@",paramXml);
        [self.serviceHelper asynServiceMethod:@"CP_LOGIN_LOG" soapMessage:paramXml];
    }
}

-(void) finishSuccessRequest:(NSData *)xml
{
    Log *info1=[[Log alloc] init];
    NSMutableArray *array =[[NSMutableArray alloc] init];
    [array addObjectsFromArray:[info1 searchNodeToArray:xml nodeName:@"NewDataSet"]];
    NSLog(@"%@0000000",info1);
    
    if ([info1.OUT_RESULT isEqualToString:@"0"]) {
        [self description];
    }
}

-(void)exitLogin{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要注销?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert loadViewIfNeeded];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            // 点击确定按钮的时候, 会调用这个block
            //ViewController *vc = [[ViewController alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
//    UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"确定退出?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];

    
}
    //提示框代理
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
//        ViewController *vc = [[ViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
// [self exitApplication];
        exit(0);
    }
    else
        {
        
        }
}
- ( void )exitApplication {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration: 1.0f animations:^{
        window.alpha = 0 ;
        window.frame = CGRectMake( 0 , window.bounds.size.width, 0 , 0 );
    } completion:^(BOOL finished) {
        exit( 0 );
    }];
    
}

@end
