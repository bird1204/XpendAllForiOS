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
@synthesize TextFieldCategory =_TextFieldCategory;
@synthesize TextFieldDistrict=_TextFieldDistrict;
@synthesize workingField=_workingField;
@synthesize districts=_districts;
@synthesize categories=_categories;


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
    
    _pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(_tableView.frame.origin.x+_tableView.frame.size.height+10, 0, self.view.frame.size.width, self.view.frame.size.height-_tableView.frame.origin.x-_tableView.frame.size.height)];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];
    [_pickerView setBackgroundColor:[UIColor clearColor]];
    [_pickerView setShowsSelectionIndicator:YES];
    
    _TextFieldCategory.inputView=_pickerView;
    _TextFieldDistrict.inputView=_pickerView;
    
    _categories=[[NSMutableArray alloc]init];
    _districts=[[NSMutableArray alloc]init];
    
    //listen tap event
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //_shopLists=webGetter.webData;
    //先只裝台北市
    _shopLists=[[NSMutableArray alloc]init];
    for (NSDictionary *list in webGetter.webData) {
        id districtValue = [list objectForKey:@"district"];
        if (districtValue != [NSNull null]){
            NSString *district = (NSString *)districtValue;
            if ([district isEqualToString:@"台北市"] || [district isEqualToString:@"臺北市"]  ) {
                [_shopLists addObject:list];
            }
        }
    }
    [_tableView reloadData];
}


#pragma mark -
#pragma mark - pickerView datesource
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count=0;
    if (_workingField==_TextFieldCategory) {
        count = [_categories count];
    }
    if (_workingField==_TextFieldDistrict) {
        count = [_districts count];
    }
    return count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *titleString=@"";
    if (_workingField==_TextFieldCategory) {
        _TextFieldCategory= [_categories objectAtIndex:row];
    }
    if (_workingField==_TextFieldDistrict) {
        _TextFieldDistrict=  [_districts objectAtIndex:row];
    }
    
    return titleString;
}


#pragma mark -
#pragma mark - pickerView delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_workingField==_TextFieldCategory) {
        [_TextFieldCategory setText:[_categories objectAtIndex:row]];
    }
    if (_workingField==_TextFieldDistrict) {
        [_TextFieldDistrict setText:[_districts objectAtIndex:row]];
    }
}


#pragma mark -
#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _workingField=textField;
    [_pickerView reloadAllComponents];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:TRUE];
    return YES;
}


#pragma mark -
#pragma mark - gestureRecognizer delegate
- (void)tapRecognized:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:TRUE];
}
@end
