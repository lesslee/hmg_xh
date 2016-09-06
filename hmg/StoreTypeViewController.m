//
//  StoreTypeViewController.m
//  hmg
//
//  Created by hongxianyu on 2016/7/21.
//  Copyright © 2016年 com.lz. All rights reserved.
//

#import "StoreTypeViewController.h"
#import "StoreType.h"
#import "StoreType+Additions.h"
#import <Foundation/Foundation.h>

@interface StoreTypeCell : UITableViewCell

@property (nonatomic) UILabel * ID;
@property (nonatomic) UILabel * NAME;

@end

@implementation StoreTypeCell

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

@implementation StoreTypeViewController

@synthesize rowDescriptor = __rowDescriptor;
@synthesize popoverController = __popoverController;

static NSString *const kCellIdentifier = @"CellIdentifier";

NSArray *array;
NSString *name;
NSString *ID;
    

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
            [[StoreType alloc] initWithID:@"1" andNAME:@"连锁"],
            [[StoreType alloc] initWithID:@"2" andNAME:@"商场"],
            [[StoreType alloc] initWithID:@"3" andNAME:@"百货"],
            [[StoreType alloc] initWithID:@"4" andNAME:@"单店"],
            [[StoreType alloc] initWithID:@"5" andNAME:@"其他渠道"],
            [[StoreType alloc] initWithID:@"6" andNAME:@"宝宝店"],
            [[StoreType alloc] initWithID:@"7" andNAME:@"KA店"],
            nil];
    
        // SearchBar
        //self.tableView.tableHeaderView = self.searchDisplayController.searchBar;
    
        // register cells
        //[self.searchDisplayController.searchResultsTableView registerClass:[StoreCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[StoreTypeCell class] forCellReuseIdentifier:kCellIdentifier];
    
    [self customizeAppearance];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId=@"cellId";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    
    
    StoreType *model=(StoreType *)[array objectAtIndex:indexPath.row];
    cell.textLabel.text=model.NAME;
        //NSLog(@"%@,%@", model.NAME ,model.ID);
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
    StoreType *model=(StoreType *)[array objectAtIndex:indexPath.row];
    
    self.rowDescriptor.value=model;
    NSLog(@"%@,%@", model.NAME ,model.ID);
    
    name = model.NAME;
    ID = model.ID;
    
    [self saveNSUserDefaults];
    [self saveNSUserDefaults1];
    
    if (self.popoverController){
        [self.popoverController dismissPopoverAnimated:YES];
        [self.popoverController.delegate popoverControllerDidDismissPopover:self.popoverController];
    }
    else if ([self.parentViewController isKindOfClass:[UINavigationController class]]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

    //归档
-(void) saveNSUserDefaults1{
    StoreType *store = [[StoreType alloc]init];
    store.NAME = name;
    store.ID = ID;
    
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:store];
    NSUserDefaults *store1 = [NSUserDefaults standardUserDefaults];
    [store1 setObject:data1 forKey:@"oneStore1"];
}

    //保存数据到nsuserdefaults
-(void) saveNSUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:ID forKey:@"ID"];
    NSLog(@"%@------------",ID);
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
    [[self navigationItem] setTitle:@"门店类型"];
    [self.navigationController.navigationBar.backItem setTitle:@""];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}




@end

