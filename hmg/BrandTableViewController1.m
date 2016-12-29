//
//  BrandTableViewController1.m
//  hmg
//
//  Created by hongxianyu on 2016/12/2.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "BrandTableViewController1.h"
#import "BrandTableViewCell.h"
#import "Weekend_PromotionViewController.h"
#import "Brand.h"
#define NAME    @"Name"
#define ID      @"ID"
@interface BrandTableViewController1 ()<UITableViewDelegate,UITableViewDataSource>
{

    UITableView   *tableView1;
    NSMutableArray *BrandArray;


}
@end

@implementation BrandTableViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    BrandArray =  [NSMutableArray arrayWithArray:@[@{NAME:@"U-ZA系列",ID:@"100023"},@{NAME:@"Denti系列",ID:@"100024"},@{NAME:@"Phyll",ID:@"100031"},@{NAME:@"TGM",ID:@"100028"},@{NAME:@"Godis",ID:@"100045"},@{NAME:@"EDISON",ID:@"100046"},@{NAME:@"BBD",ID:@"100013"}]];

    tableView1=[[UITableView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView1];
    
    tableView1.dataSource=self;
    tableView1.delegate=self;

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationItem setTitle:@"品牌"];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:75/255.0 green:192/255.0 blue:220/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BrandArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [BrandArray objectAtIndex:indexPath.row];
    NSLog(@"%@",dic);
    BrandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandTableViewCell" ];
    if (!cell)
        {
        [tableView registerNib:[UINib nibWithNibName:@"BrandTableViewCell" bundle:nil] forCellReuseIdentifier:@"BrandTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"BrandTableViewCell"];
        }
   
    cell.BrandName.text = [dic objectForKey:NAME];
        //cell.BrandID.text = [dic objectForKey:ID];
 
    return cell;
}


//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    BrandTableViewCell *tempCell = (BrandTableViewCell *)cell;
//    NSDictionary *dic = [BrandArray objectAtIndex:0];
//    
//    
//    NSLog(@"%@,%@",dic,BrandArray);
//    
//    tempCell.BrandName = [dic objectForKey:NAME];
//    tempCell.BrandID = [dic objectForKey:ID];
//    NSLog(@"%@",tempCell.BrandName);
//}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [BrandArray objectAtIndex:indexPath.row];
    self.BrandName = [dic objectForKey:NAME];
    self.BrandID = [dic objectForKey:ID];

    [_dic2 setValue:self.BrandName forKey:@"BrandName"];
    [_dic2 setValue:self.BrandID forKey:@"BrandID"];
    [self.navigationController popViewControllerAnimated:YES];
    
        //    Weekend_PromotionViewController *wpvc = [[Weekend_PromotionViewController alloc]init];
        //    [wpvc setValue:self.BrandName forKey:@"BrandName"];
        //    [wpvc setValue:self.BrandID forKey:@"BrandID"];
        //    [self.button3 setTitle:self.BrandName forState:UIControlStateNormal];
        //
        //    self.BrandIDDelegate = wpvc; //设置代理
        //
        //    [self.BrandIDDelegate passBrandID:self.BrandID];

}
@end
