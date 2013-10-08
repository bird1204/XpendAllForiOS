//
//  shopViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/10/2.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "shopViewController.h"
#import "GetJsonURLString.h"
#import "shopDetailViewController.h"
#import "MMPickerView.h"


@interface shopViewController ()

@end

@implementation shopViewController
@synthesize tableView = _tableView;
@synthesize govermentData =_govermentData;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*)url{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        webGetter=[[WebJsonDataGetter alloc]initWithURLString:url];
//        [webGetter setDelegate:self];
        NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"govermentData.json"];
        NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        _govermentOriginData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        _govermentData=_govermentOriginData;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_textDistrict setTitle:@"台北市" forState:UIControlStateNormal];
    [_textCategory setTitle:@"全部分類" forState:UIControlStateNormal];
    _categories=[[NSMutableArray alloc]initWithObjects:@"溫馨送餐",@"老人共餐",@"愛心餐食補給站", nil];
    _districts=[[NSMutableArray alloc]initWithObjects:
                @"台北市",@"新北市",@"台中市",@"台南市",@"高雄市",@"基隆市",
                @"新竹市",@"嘉義市",@"桃園縣",@"新竹縣",@"苗栗縣",@"彰化縣",
                @"南投縣",@"雲林縣",@"嘉義縣",@"屏東縣",@"宜蘭縣",@"花蓮縣",
                @"台東縣",@"澎湖縣",@"金門縣",@"連江縣",nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_govermentData count];
    //    return [webGetter.webData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    self.tableView.backgroundColor = [UIColor clearColor];
    // Configure the cell...
//    cell.textLabel.text=[[webGetter.webData objectAtIndex:indexPath.row]objectForKey:@"org_name"];
//    cell.detailTextLabel.text=[[webGetter.webData objectAtIndex:indexPath.row]objectForKey:@"address"];
//    cell.imageView.image=[UIImage  imageNamed:@"plate"];
//    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text=[[_govermentData objectAtIndex:indexPath.row]objectForKey:@"org_name"];
    cell.detailTextLabel.text=[[_govermentData objectAtIndex:indexPath.row]objectForKey:@"address"];
    cell.imageView.image=[UIImage  imageNamed:@"plate"];
    cell.backgroundColor = [UIColor clearColor];

    
    
    return cell;
}

- (IBAction)selectDistrict:(id)sender {

    if ([[_textCategory currentTitle]isEqualToString:@"全縣市"]) {
        [self showPicker:_categories selectedObject:@"台北市" filterType:@"city"];
    }else{
        [self showPicker:_districts selectedObject:[_textDistrict currentTitle] filterType:@"city"];
    }
}

- (IBAction)selectCategory:(id)sender {
    if ([[_textCategory currentTitle]isEqualToString:@"全部分類"]) {
        [self showPicker:_categories selectedObject:@"溫馨送餐" filterType:@"org_group_name"];
    }else{
        [self showPicker:_categories selectedObject:[_textCategory currentTitle] filterType:@"org_group_name"];
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    shopDetailViewController *detailView=[[shopDetailViewController alloc]initWithNibName:@"shopDetailViewController" bundle:nil shopDetail:[webGetter.webData objectAtIndex:indexPath.row] govermentData:1];
//    [self.navigationController pushViewController:detailView animated:TRUE];
    
    
    shopDetailViewController *detailView=[[shopDetailViewController alloc]initWithNibName:@"shopDetailViewController" bundle:nil shopDetail:[_govermentData objectAtIndex:indexPath.row] govermentData:1];
    [self.navigationController pushViewController:detailView animated:TRUE];
}

#pragma mark - doThingAfterWebJsonIsOKFromDelegate


-(void)doThingAfterWebJsonIsOKFromDelegate{
    [_tableView reloadData];
}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
                                if ([filterType isEqualToString:@"city"]) {
                                    [_textDistrict setTitle:selectedString forState:UIControlStateNormal];
                                }
                                if ([filterType isEqualToString:@"org_group_name"]) {
                                    [_textCategory setTitle:selectedString forState:UIControlStateNormal];
                                    if ([selectedString length]>4) {
                                        [_textCategory setTitle:@"愛心補給站" forState:UIControlStateNormal];
                                    }
                                }
                                [self reloadShopLists:selectedString filterType:filterType];
                            }];
}

-(void)reloadShopLists:(NSString*)selectString filterType:(NSString*)filterType{
    //    [_shopLists removeAllObjects];
    //    for (NSDictionary *list in _shopOriginalLists) {
    //        id districtValue = [list objectForKey:filterType];
    //        if (districtValue != [NSNull null]){
    //            NSString *category = (NSString *)districtValue;
    //            if ([category isEqualToString:selectString]) {
    //                [_shopLists addObject:list];
    //            }
    //        }
    //    }
    NSError *error = NULL;
    // regex 用 \ 做跳脫，但是在 C 裡斜線本身也要跳脫，所以寫成 \\( 來跳脫左括號
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"[(臺|台)(.*)]" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *modifiedString = [regex stringByReplacingMatchesInString: selectString options:0 range: NSMakeRange(0, [selectString length]) withTemplate:@"臺"];

    if (modifiedString == nil || [modifiedString isEqualToString:@""]){
        modifiedString = selectString;
    }
    NSMutableArray *tempData=[[NSMutableArray alloc]init];
    for (NSDictionary *list in _govermentOriginData) {
        id districtValue = [list objectForKey:filterType];
        if (districtValue != [NSNull null]){
            NSString *district = (NSMutableString *)districtValue;
            if ([district isEqualToString:modifiedString]) {
                [tempData addObject:list];
            }
        }
    }
    
    if ([tempData count]<1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"沒有資料" message:@"請重新選擇" delegate:self cancelButtonTitle:@"確定" otherButtonTitles: nil];
        [alert show];
    }
    //[_govermentData removeAllObjects];
    _govermentData=tempData;
    [_tableView reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"cancel");
            break;
        case 1:
            NSLog(@"one");
            break;
        default:
            break;
    }
}


@end
