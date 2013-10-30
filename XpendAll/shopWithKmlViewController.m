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
#import "MMPickerView.h"


@interface shopWithKmlViewController ()

@end

@implementation shopWithKmlViewController
@synthesize tableView = _tableView;
@synthesize textCategory =_textCategory;
@synthesize textDistrict=_textDistrict;
@synthesize districts=_districts;
@synthesize categories=_categories;
@synthesize inventorySwitch=_inventorySwitch;
//demo
@synthesize demoShopLists=_demoShopLists;
@synthesize demoShopOriginalLists=_demoShopOriginalLists;


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
//    webGetter=[[WebJsonDataGetter alloc]initWithURLString:GetKMLData];
//    [webGetter setDelegate:self];
    
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"kmlData.json"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    _demoShopOriginalLists = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    _demoShopLists=_demoShopOriginalLists;

    [_textDistrict setTitle:@"台北市" forState:UIControlStateNormal];
    [_textCategory setTitle:@"全部分類" forState:UIControlStateNormal];
    _categories=[[NSMutableArray alloc]initWithObjects:@"還",@"沒",@"好", nil];
    _districts=[[NSMutableArray alloc]initWithObjects:
                @"台北市",@"新北市",@"台中市",@"台南市",@"高雄市",@"基隆市",
                @"新竹市",@"嘉義市",@"桃園縣",@"新竹縣",@"苗栗縣",@"彰化縣",
                @"南投縣",@"雲林縣",@"嘉義縣",@"屏東縣",@"宜蘭縣",@"花蓮縣",
                @"台東縣",@"澎湖縣",@"金門縣",@"連江縣",nil];
    [_inventorySwitch setOn:FALSE];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)inventoryFilter:(id)sender {
    //_inventorySwitch.onImage
    //_inventorySwitch.offImage
    if (_inventorySwitch.on) {
        [self reloadShopLists:nil filterType:nil];
    }else{
        NSString *selectedObj=([[_textDistrict currentTitle]isEqualToString:@"全縣市"])? [_textDistrict currentTitle] : @"台北市" ;
        [self reloadShopLists:selectedObj filterType:@"district"];
    }
}

- (IBAction)selectDistrict:(id)sender {
    NSString *selectedObj=([[_textDistrict currentTitle]isEqualToString:@"全縣市"])? [_textDistrict currentTitle] : @"台北市" ;
    [self showPicker:_districts selectedObject:selectedObj filterType:@"district"];
   }

- (IBAction)selectCategory:(id)sender {
//    if ([[_textCategory currentTitle]isEqualToString:@"全部分類"]) {
//        [self showPicker:_categories selectedObject:@"溫馨送餐" filterType:@"category"];
//    }else{
//        [self showPicker:_categories selectedObject:[_textCategory currentTitle] filterType:@"category"];
//    }
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
    return [_demoShopLists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text=[[_demoShopLists objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.detailTextLabel.text=[[_demoShopLists objectAtIndex:indexPath.row]objectForKey:@"address"];
    cell.imageView.image=[UIImage  imageNamed:@"plate"];
    cell.backgroundColor = [UIColor clearColor];
    
    NSInteger quantity=[[[_demoShopLists objectAtIndex:indexPath.row]objectForKey:@"quantity"] integerValue];

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

//    shopDetailViewController *detailView=[[shopDetailViewController alloc]initWithNibName:@"shopDetailViewController" bundle:nil shopDetail:[_shopLists objectAtIndex:indexPath.row] govermentData:nil];
//    [self.navigationController pushViewController:detailView animated:TRUE];
    
    shopDetailViewController *detailView=[[shopDetailViewController alloc]initWithNibName:@"shopDetailViewController" bundle:nil shopDetail:[_demoShopLists objectAtIndex:indexPath.row] govermentData:nil];
    [self.navigationController pushViewController:detailView animated:TRUE];
    
}

#pragma mark - webGetter delegate
-(void)doThingAfterWebJsonIsOKFromDelegate{
//    _shopOriginalLists=(NSMutableArray*)webGetter.webData;
//    _shopLists=[[NSMutableArray alloc]init];
//    
//    for (NSDictionary *list in webGetter.webData) {
//        id districtValue = [list objectForKey:@"district"];
//        if (districtValue != [NSNull null]){
//            NSString *district = (NSString *)districtValue;
//            if ([district isEqualToString:@"台北市"] || [district isEqualToString:@"臺北市"]) {
//                [_shopLists addObject:list];
//            }
//        }
//    }
//    [_tableView reloadData];
}

#pragma mark - private method
-(void)showPicker:(NSArray*)withStrings selectedObject:(NSString*)selectedObject filterType:(NSString*)filterType{
    [MMPickerView showPickerViewInView:self.view
                           withStrings:withStrings
                           withOptions:@{MMbackgroundColor: [UIColor lightTextColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor lightGrayColor],
                                         MMbuttonColor: [UIColor blackColor],
                                         MMfont: [UIFont systemFontOfSize:24],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedObject,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                if ([filterType isEqualToString:@"district"]) {
                                    [_textDistrict setTitle:selectedString forState:UIControlStateNormal];
                                }
                                if ([filterType isEqualToString:@"category"]) {
                                    [_textCategory setTitle:selectedString forState:UIControlStateNormal];
                                }
                                [self reloadShopLists:selectedString filterType:filterType];
                            }];
}

-(void)reloadShopLists:(NSString*)selectString filterType:(NSString*)filterType{
    
    NSMutableArray *tempData=[[NSMutableArray alloc]init];
    if ( selectString == nil &&  filterType == nil ) {
        for (NSDictionary *list in _demoShopOriginalLists) {
            id quantityValue = [list objectForKey:@"quantity"];
            if (quantityValue != [NSNull null]){
                NSString *quantity = (NSMutableString *)quantityValue;
                if ([quantity integerValue] > 0) {
                    [tempData addObject:list];
                }
            }
        }
    }else{
        NSError *error = NULL;
        // regex 用 \ 做跳脫，但是在 C 裡斜線本身也要跳脫，所以寫成 \\( 來跳脫左括號
        NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"[(臺|台)(.*)]" options:NSRegularExpressionCaseInsensitive error:&error];
        NSString *modifiedString = [regex stringByReplacingMatchesInString: selectString options:0 range: NSMakeRange(0, [selectString length]) withTemplate:@"台"];
    
        if (modifiedString == nil || [modifiedString isEqualToString:@""]){
            modifiedString = selectString;
        }

        for (NSDictionary *list in _demoShopOriginalLists) {
            id districtValue = [list objectForKey:filterType];
            if (districtValue != [NSNull null]){
                NSString *category = (NSString *)districtValue;
                if ([category isEqualToString:modifiedString]) {
                    [tempData addObject:list];
                }
            }
        }
    }
    
    if ([tempData count]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"沒有資料" message:@"請重新選擇" delegate:self cancelButtonTitle:@"確定" otherButtonTitles: nil];
        [alert show];
    }else{
        _demoShopLists=tempData;
        [_tableView reloadData];
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"cancel");
            break;
        default:
            break;
    }
}

@end
