//
//  ViewController.m
//  hmg
//
//  Created by Lee on 15/3/23.
//  Copyright (c) 2015年 com.lz. All rights reserved.
//

#import "ViewController.h"
#import "HMG_LOGIN.h"
#import "SoapHelper.h"
#import "ServiceHelper.h"
#import "UserInfo.h"
#import "AppDelegate.h"
#import "Common.h"
#import "CP_LOGIN_LOG.h"
#import "CommonResult.h"
#import "IQKeyboardManager.h"
#import "UIView+SDAutoLayout.h"

@interface ViewController ()
{

    NSString *ID;
    
    UILabel *Id;
    UILabel *ps;
    UILabel *version1;

}
@end

@implementation ViewController

ServiceHelper *serviceHelper;

NSUserDefaults *userDefaultes;
NSString *empno;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self updateApp];
    
    [self cleanCaches];
    if (!userDefaultes) {
        userDefaultes = [NSUserDefaults standardUserDefaults];
    }
    
    
    UIView *statusBarView = [[UIView alloc]   initWithFrame:CGRectMake(0, -20,self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = [self colorWithHexString:@"#7C7C7C" alpha:0.5];
    [self.navigationController.navigationBar addSubview:statusBarView];
    
    
    serviceHelper = [[ServiceHelper alloc] initWithDelegate:self];
    self.view.backgroundColor = [self colorWithHexString:@"#4bc0dc" alpha:1];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 101)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    Id = [[UILabel alloc]init];
    Id.text = @"账号";
    Id.font = [UIFont systemFontOfSize:18];
    Id.textColor = [UIColor grayColor];
    [view addSubview:Id];
    Id.sd_layout
    .leftSpaceToView(view,10)
    .topSpaceToView(view,10)
    .heightIs(30)
    .widthIs(40);
    
    
    self.longinID = [[UITextField alloc]init];
    self.longinID.textColor = [UIColor grayColor];
    self.longinID.textAlignment = NSTextAlignmentLeft;
    self.longinID.placeholder = @"请输入账号";
    [view addSubview:self.longinID];
    self.longinID.sd_layout
    .leftSpaceToView(Id,10)
    .centerYEqualToView(Id)
    .heightIs(30)
    .widthIs(200);
    
    UIView *line=[[UIView alloc] init];
    line.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [view addSubview:line];
    line.sd_layout
    .topSpaceToView(Id,10)
    .leftSpaceToView(view,10)
    .rightSpaceToView(view,10)
    .heightIs(0.3);
    
    ps = [[UILabel alloc]init];
    ps.text = @"密码";
    ps.font = [UIFont systemFontOfSize:18];
    ps.textColor = [UIColor grayColor];
    [view addSubview:ps];
    ps.sd_layout
    .leftSpaceToView(view,10)
    .topSpaceToView(line,10)
    .heightIs(30)
    .widthIs(40);
    
    self.password = [[UITextField alloc]init];
    self.password.textColor = [UIColor grayColor];
    self.password.textAlignment = NSTextAlignmentLeft;
    self.password.placeholder = @"请输入密码";
    self.password.secureTextEntry = YES;
    [view addSubview:self.password];
    self.password.sd_layout
    .leftSpaceToView(ps,10)
    .centerYEqualToView(ps)
    .heightIs(30)
    .widthIs(200);
    
    
    self.longin = [[UIButton alloc]init];
    self.longin.backgroundColor = [self colorWithHexString:@"#68d86f" alpha:1];
        //self.longin.backgroundColor = [UIColor redColor];
    [self.longin setTitle:@"登录" forState:UIControlStateNormal];
    [self.longin addTarget:self action:@selector(loginHandle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.longin];
    self.longin.sd_layout
    .topSpaceToView(view,10)
    .leftSpaceToView(self.view,10)
    .rightSpaceToView(self.view,10)
    .heightIs(40);
    
    version1 = [[UILabel alloc]init];
    version1.text = @"当前版本:";
    version1.font = [UIFont systemFontOfSize:13];
    version1.textAlignment = NSTextAlignmentLeft;
    version1.textColor = [UIColor whiteColor];
    [self.view addSubview:version1];
    version1.sd_layout
    .topSpaceToView(self.longin,0)
    .rightSpaceToView(self.view,30)
    .heightIs(30)
    .widthIs(60);
    
    
    self.version = [[UILabel alloc]init];
    self.version.textColor = [UIColor whiteColor];
    self.version.font = [UIFont systemFontOfSize:13];
    self.version.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.version];
    self.version.sd_layout
    .leftSpaceToView(version1,0)
    .centerYEqualToView(version1)
    .heightIs(30)
    .widthIs(20);
    
//        //设置背景图片
//    UIImage *imageBg=[UIImage imageNamed:@"login_bg.png"];
//    self.view.layer.contents=(id)imageBg.CGImage;
//    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *myVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    self.version.text = [NSString stringWithFormat:@"%@",myVersion];
    
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];
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

-(void)updateApp{
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/tangyanbin0951/ios/master/hmg.plist"]];
    if (dict) {
        NSArray *list = [dict objectForKey:@"items"];
        NSDictionary *dict2 = [list objectAtIndex:0];
        NSDictionary *dict3 = [dict2 objectForKey:@"metadata"];
        NSString *newVersion = [dict3 objectForKey:@"bundle-version"];
        NSLog(@"新版本%@",newVersion);
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *myVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
        NSLog(@"本地版本%@",myVersion);
        
        if ([newVersion compare:myVersion]== NSOrderedDescending) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"有新版本" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"暂不更新", nil];
            [alert show];
        }
    }
}


    //提示框代理
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        NSLog(@"更新");
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://raw.githubusercontent.com/tangyanbin0951/ios/master/hmg.plist"]];
    } else if(buttonIndex == 1){
        NSLog(@"不更新");
    }else{
        
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"已经是最新版" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }
}






-(void)saveNSUserDefaults{
 NSUserDefaults *userDefaultes1 = [NSUserDefaults standardUserDefaults];
    ID = self.longinID.text;
    NSLog(@"%@1234567",ID);
    [userDefaultes1 setObject:ID forKey:@"ID"];
    [userDefaultes1 synchronize];
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    
    UILabel *title = [[UILabel alloc] initWithFrame:self.view.bounds];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"HMG员工登录";
    self.navigationItem.titleView = title;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    

    NSData *data=[userDefaultes objectForKey:@"loginInfo"];
    //从NSData对象中恢复EVECTION_LOGIN
    HMG_LOGIN *info=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    //记住账号时，界面显示账号密码
    if ([@"1" isEqualToString:[userDefaultes objectForKey:@"remember_state"]]) {
        
            //self.rememberPassword.on=YES;
        
        //保存账号密码
        [self.longinID setText:info.IN_LOGIN_ID];
        [self.password setText:info.IN_LOGIN_PW];
    }
//    else
//    {
//   
//        [self.loginId setText:info.IN_LOGIN_ID];
//        [self.password setText:@""];
//        self.rememberPassword.on=NO;
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)loginHandle:(id)sender {
-(void)loginHandle{
    [self saveNSUserDefaults];
    if([@"" isEqualToString:self.longinID.text]||[@"" isEqualToString:self.password.text])
    {
        [HUDManager showMessage:@"账号和密码必须填写" duration:1];
    }
    else
    {
        Common *common=[[Common alloc] initWithView:self.view];
    
        if (common.isConnectionAvailable) {
            HMG_LOGIN *loginParam=[[HMG_LOGIN alloc] init];
            
            [loginParam setIN_LOGIN_ID:self.longinID.text];
            [loginParam setIN_LOGIN_PW:self.password.text];
            NSString *paramXML=[SoapHelper objToDefaultSoapMessage:loginParam];
            NSLog(@"%@",loginParam);
            NSLog(@"%@",paramXML);
            [serviceHelper asynServiceMethod:@"HMG_LOGIN" soapMessage:paramXML];
            
        }
    }
}




//请求失败，返回错误信息
-(void)finishFailedRequest:(NSData *)error
{
    NSLog(@"%@",[[NSString alloc]initWithData:error encoding:NSUTF8StringEncoding]);
    
}

//请求成功
-(void) finishSuccessRequest:(NSData *)xml
{
    UserInfo *info=[[UserInfo alloc] init];
    NSMutableArray *array =[[NSMutableArray alloc] init];
    [array addObjectsFromArray:[info searchNodeToArray:xml nodeName:@"NewDataSet"]];
    NSLog(@"%@",info);
    
    if ([info.OUT_RESULT isEqualToString:@"0"]) {
        
        //保存用户信息
        AppDelegate *delegate=[UIApplication sharedApplication].delegate;
        delegate.userInfo1=[[UserInfo alloc] init];
        
        [delegate.userInfo1 setEMP_NO:[info EMP_NO]];
        [delegate.userInfo1 setEMP_NM:[info EMP_NM]];
        [delegate.userInfo1 setEMP_TYPE:[info EMP_TYPE]];
        [delegate.userInfo1 setDEPT_CD:[info DEPT_CD]];
        [delegate.userInfo1 setDEPT_NM:[info DEPT_NM]];
        
        //登录成功，跳转到主界面
        [HUDManager showMessage:@"登陆成功" duration:1 complection:^{
            
//            if(self.rememberPassword.on)
//            {
                HMG_LOGIN *info=[[HMG_LOGIN alloc] init];
                [info setIN_LOGIN_ID:self.longinID.text];
                [info setIN_LOGIN_PW:self.password.text];
                
                //自定义对象归档
                NSData *data=[NSKeyedArchiver archivedDataWithRootObject:info];
                
                [userDefaultes setObject:@"1" forKey:@"remember_state"];
                [userDefaultes setObject:data forKey:@"loginInfo"];
//            }
//            else
//            {
//                [userDefaultes removeObjectForKey:@"remember_state"];
//            }
            
            [self performSegueWithIdentifier:@"mainMenuId" sender:self];
        }];
    }
    else
    {
        //NSString *str=info.OUT_RESULT_NM;
        [HUDManager showMessage:@"账号或密码错误" duration:1];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



    // 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path
{
        // 利用NSFileManager实现对文件的管理
    
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
            // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }  
            // 将大小转化为M  
        return size / 1024.0 / 1024.0;   
    }   
    return 0;
}
    // 根据路径删除文件
- (void)cleanCaches:(NSString *)path
{
        // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
            // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
                // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
                // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }  
    }
    
}

-(void)cleanCaches{

    CGFloat size = [self folderSizeAtPath:NSTemporaryDirectory()];
    
    if (size > 15) {
        NSString *message = size > 15 ? [NSString stringWithFormat:@"缓存%.2fM", size] : [NSString stringWithFormat:@"缓存%.2fK", size * 1024.0];
        NSLog(@"%@",message);
        [self cleanCaches:NSTemporaryDirectory()];
    }


}

@end
