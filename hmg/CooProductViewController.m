//
//  CooProductViewController.m
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "CooProductViewController.h"
#import "CooProduct.h"
#import "CooProduct+Additions.h"
#import <Foundation/Foundation.h>


@interface CooProductCell : UITableViewCell

@property (nonatomic) UILabel * ID;
@property (nonatomic) UILabel * NAME;

@end

@implementation CooProductCell

@synthesize ID = _ID;
@synthesize NAME  = _NAME;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            // Initialization code
        
        [self.contentView addSubview:self.ID];
        [self.contentView addSubview:self.NAME];
        
        [self.contentView addConstraints:[self layoutConstraints]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
        // Configure the view for the selected state
}


#pragma mark - Views

-(UILabel *)ID
{
    if (_ID) return _ID;
    _ID = [UILabel new];
    [_ID setTranslatesAutoresizingMaskIntoConstraints:NO];
    _ID.font = [UIFont fontWithName:@"HelveticaNeue" size:15.f];
    
    return _ID;
}

-(UILabel *)NAME
{
    if (_NAME) return _NAME;
    _NAME = [UILabel new];
    [_NAME setTranslatesAutoresizingMaskIntoConstraints:NO];
    _NAME.font = [UIFont fontWithName:@"HelveticaNeue" size:15.f];
    
    return _NAME;
}

#pragma mark - Layout Constraints

-(NSArray *)layoutConstraints{
    
    NSMutableArray * result = [NSMutableArray array];
    
    NSDictionary * views = @{ @"id": self.ID,
                              @"name": self.NAME};
    
    
    NSDictionary *metrics = @{@"imgSize":@50.0,
                              @"margin" :@12.0};
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(margin)-[id(imgSize)]-[name]"
                                                                        options:NSLayoutFormatAlignAllTop
                                                                        metrics:metrics
                                                                          views:views]];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(margin)-[id(imgSize)]"
                                                                        options:0
                                                                        metrics:metrics
                                                                          views:views]];
    return result;
}


@end

@interface CooProductViewController()
@property(nonatomic, strong)NSString *cooProductId;
@end


@implementation CooProductViewController

@synthesize rowDescriptor = __rowDescriptor;
@synthesize popoverController = __popoverController;

static NSString *const kCellIdentifier = @"CellIdentifier";

NSArray *array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            // Custom initialization
        [self initialize];
    }
    return self;
}

-(void)initialize
{
        // Enable the pagination
    self.loadingPagingEnabled = NO;
    
        // Support Search Controller
    self.supportSearchController = NO;
    
        //[self setLocalDataLoader:[[AgentLocalDataLoader alloc] init]];
        //[self setRemoteDataLoader:[[UserRemoteDataLoader alloc] init]];
    
        // Search
        //[self setSearchLocalDataLoader:[[AgentLocalDataLoader alloc] init]];
        //[self setSearchRemoteDataLoader:[[UserRemoteDataLoader alloc] init]];
    [self customizeAppearance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    array =[NSArray arrayWithObjects:
            [[CooProduct alloc] initWithID:@"100013" andNAME:@"Babydream"],
            [[CooProduct alloc] initWithID:@"100014" andNAME:@"童鞋"],
            [[CooProduct alloc] initWithID:@"100015" andNAME:@"碧芝莱"],
            [[CooProduct alloc] initWithID:@"100020" andNAME:@"吸奶器"],
            [[CooProduct alloc] initWithID:@"100023" andNAME:@"U-ZA"],
            [[CooProduct alloc] initWithID:@"100024" andNAME:@"Denti"],
            [[CooProduct alloc] initWithID:@"100031" andNAME:@"Phyll"],
            [[CooProduct alloc] initWithID:@"100045" andNAME:@"Godis"],
            [[CooProduct alloc] initWithID:@"100046" andNAME:@"EDISON"],
            [[CooProduct alloc] initWithID:@"100028" andNAME:@"TGM"],
            nil];
    
        // SearchBar
        //self.tableView.tableHeaderView = self.searchDisplayController.searchBar;
    
        // register cells
        //[self.searchDisplayController.searchResultsTableView registerClass:[StoreCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CooProductCell class] forCellReuseIdentifier:kCellIdentifier];
    
    [self customizeAppearance];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId=@"cellId";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    
    CooProduct *model=(CooProduct *)[array objectAtIndex:indexPath.row];
    cell.textLabel.text=model.NAME;
    
    cell.accessoryType = [[self.rowDescriptor.value formValue] isEqual:model.ID] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    if (indexPath.row%2==0) {
        cell.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1.0];
    }
    else
        {
        cell.backgroundColor=[UIColor whiteColor];
        }
    
    cell.layer.masksToBounds=YES;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CooProduct *model=(CooProduct *)[array objectAtIndex:indexPath.row];
    
    self.rowDescriptor.value=model;
    NSLog(@"%@,%@",model.NAME,model.ID);
    _cooProductId = model.ID;
    if (self.popoverController){
        [self.popoverController dismissPopoverAnimated:YES];
        [self.popoverController.delegate popoverControllerDidDismissPopover:self.popoverController];
    }
    else if ([self.parentViewController isKindOfClass:[UINavigationController class]]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self saveNSUserDefaults];
}

    //保存数据到nsuserdefaults
-(void) saveNSUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_cooProductId forKey:@"_cooProductId"];
    NSLog(@"%@===",_cooProductId);
    [userDefaults synchronize];
}



-(BOOL)loadingPagingEnabled
{
    return NO;
}

    //禁用刷新控件
-(UIRefreshControl *)refreshControl
{
    return nil;
}

#pragma mark - Helpers

-(void)customizeAppearance
{
    [[self navigationItem] setTitle:@"产品"];
    [self.navigationController.navigationBar.backItem setTitle:@""];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}




@end

