//
//  shopWithKmlViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/10/5.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "shopWithKmlViewController.h"
#import "GetJsonURLString.h"
#import "shopDetailViewController.h"

@interface shopWithKmlViewController ()

@end

@implementation shopWithKmlViewController
@synthesize tableView = _tableView;
@synthesize shopLists = _shopLists;
@synthesize textCategory =_textCategory;
@synthesize textDistrict=_textDistrict;
@synthesize districts=_districts;
@synthesize categories=_categories;
@synthesize shopOriginalLists=_shopOriginalLists;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webGetter=[[WebJsonDataGetter alloc]initWithURLString:GetKMLData];
    [webGetter setDelegate:self];

    [_textDistrict setTitle:@"台北市" forState:UIControlStateNormal];
    _categories=[[NSMutableArray alloc]initWithObjects:@"還",@"沒",@"好", nil];
    _districts=[[NSMutableArray alloc]initWithObjects:
                @"台北市",@"新北市",@"台中市",@"台南市",@"高雄市",@"基隆市",
                @"新竹市",@"嘉義市",@"桃園縣",@"新竹縣",@"苗栗縣",@"彰化縣",
                @"南投縣",@"雲林縣",@"嘉義縣",@"屏東縣",@"宜蘭縣",@"花蓮縣",
                @"台東縣",@"澎湖縣",@"金門縣",@"連江縣",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectDistrict:(id)sender {
    [self showPicker:_districts selectedObject:[_textDistrict currentTitle] filterType:@"district"];
}

- (IBAction)selectCategory:(id)sender {
    [self showPicker:_categories selectedObject:[_textCategory currentTitle] filterType:@"category"];
}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - table view datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_shopLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[[_shopLists objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.detailTextLabel.text=[[_shopLists objectAtIndex:indexPath.row]objectForKey:@"address"];
    cell.imageView.image=[UIImage  imageNamed:@"plate"];
    cell.backgroundColor = [UIColor clearColor];

    NSInteger quantity=[[[_shopLists objectAtIndex:indexPath.row]objectForKey:@"quantity"] integerValue];
    if (quantity > 0) {
        cell.backgroundColor=[UIColor lightTextColor];
    }
    
    return cell;
}

#pragma mark - table delegate
- (void)tableViewWillAppear:(UITableView *)tableView
{
    NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
    if (indexPath) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    [tableView flashScrollIndicators];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.backgroundColor = [UIColor clearColor];

    shopDetailViewController *detailView=[[shopDetailViewController alloc]initWithNibName:@"shopDetailViewController" bundle:nil shopDetail:[_shopLists objectAtIndex:indexPath.row] govermentData:nil];
    [self.navigationController pushViewController:detailView animated:TRUE];
    
}

#pragma mark - webGetter delegate
-(void)doThingAfterWebJsonIsOKFromDelegate{
    _shopOriginalLists=(NSMutableArray*)webGetter.webData;
    _shopLists=[[NSMutableArray alloc]init];
    
    for (NSDictionary *list in webGetter.webData) {
        id districtValue = [list objectForKey:@"district"];
        if (districtValue != [NSNull null]){
            NSString *district = (NSString *)districtValue;
            if ([district isEqualToString:@"台北市"] || [district isEqualToString:@"臺北市"]) {
                [_shopLists addObject:list];
            }
        }
    }
    [_tableView reloadData];
}

#pragma mark - private method
-(void)showPicker:(NSArray*)withStrings selectedObject:(NSString*)selectedObject filterType:(NSString*)filterType{
    [MMPickerView showPickerViewInView:self.view
                           withStrings:withStrings
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedObject,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                [_textCategory setTitle:selectedString forState:UIControlStateNormal];
                                [self reloadShopLists:selectedObject filterType:filterType];
                            }];

}

-(void)reloadShopLists:(NSString*)selectString filterType:(NSString*)filterType{
    [_shopLists removeAllObjects];
    for (NSDictionary *list in _shopOriginalLists) {
        id districtValue = [list objectForKey:filterType];
        if (districtValue != [NSNull null]){
            NSString *category = (NSString *)districtValue;
            if ([category isEqualToString:selectString]) {
                [_shopLists addObject:list];
            }
        }
    }
    [_tableView reloadData];
}

@end
