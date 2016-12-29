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
@interface ViewController ()
{

    NSString *ID;

}
@end

@implementation ViewController

ServiceHelper *serviceHelper;

NSUserDefaults *userDefaultes;
NSString *empno;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateApp];
    
    [self cleanCaches];
    if (!userDefaultes) {
        userDefaultes = [NSUserDefaults standardUserDefaults];
    }
    
    serviceHelper = [[ServiceHelper alloc] initWithDelegate:self];
    
    
        //设置背景图片
    UIImage *imageBg=[UIImage imageNamed:@"login_bg.png"];
    self.view.layer.contents=(id)imageBg.CGImage;
    self.view.layer.backgroundColor = [UIColor clearColor].CGColor;
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *myVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    self.version.text=[NSString stringWithFormat:@"V %@",myVersion];
    
    HUDManager = [[MBProgressHUDManager alloc] initWithView:self.navigationController.view];
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
    ID = self.loginId.text;
    NSLog(@"%@1234567",ID);
    [userDefaultes1 setObject:ID forKey:@"ID"];
    [userDefaultes1 synchronize];

}


-(void) viewWillAppear:(BOOL)animated
{
    
    //隐藏导航条
    [self.navigationController setNavigationBarHidden:YES];

    
    NSData *data=[userDefaultes objectForKey:@"loginInfo"];
    //从NSData对象中恢复EVECTION_LOGIN
    HMG_LOGIN *info=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    //记住账号时，界面显示账号密码
    if ([@"1" isEqualToString:[userDefaultes objectForKey:@"remember_state"]]) {
        
        self.rememberPassword.on=YES;
        
        //保存账号密码
        [self.loginId setText:info.IN_LOGIN_ID];
        [self.password setText:info.IN_LOGIN_PW];
    }
    else
    {
   
        [self.loginId setText:info.IN_LOGIN_ID];
        [self.password setText:@""];
        self.rememberPassword.on=NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginHandle:(id)sender {
    [self saveNSUserDefaults];
    if([@"" isEqualToString:self.loginId.text]||[@"" isEqualToString:self.password.text])
    {
        [HUDManager showMessage:@"账号和密码必须填写" duration:1];
    }
    else
    {
        Common *common=[[Common alloc] initWithView:self.view];
    
        if (common.isConnectionAvailable) {
            HMG_LOGIN *loginParam=[[HMG_LOGIN alloc] init];
            
            [loginParam setIN_LOGIN_ID:self.loginId.text];
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
            
            if(self.rememberPassword.on)
            {
                HMG_LOGIN *info=[[HMG_LOGIN alloc] init];
                [info setIN_LOGIN_ID:self.loginId.text];
                [info setIN_LOGIN_PW:self.password.text];
                
                //自定义对象归档
                NSData *data=[NSKeyedArchiver archivedDataWithRootObject:info];
                
                [userDefaultes setObject:@"1" forKey:@"remember_state"];
                [userDefaultes setObject:data forKey:@"loginInfo"];
            }
            else
            {
                [userDefaultes removeObjectForKey:@"remember_state"];
            }
            
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
