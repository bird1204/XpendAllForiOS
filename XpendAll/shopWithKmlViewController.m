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
    
    // Do any additional setup after loading the view from its nib.
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
    cell.detailTextLabel.text=[[_shopLists objectAtIndex:indexPath.row]objectForKey:@"region"];
    cell.imageView.image=[UIImage  imageNamed:@"plate"];
    cell.backgroundColor = [UIColor clearColor];

    NSInteger quantity=[[[_shopLists objectAtIndex:indexPath.row]objectForKey:@"quantity"] integerValue];
    if (quantity > 0) {
        cell.backgroundColor=[UIColor blueColor];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"%@",[_shopLists objectAtIndex:indexPath.row]);
    shopDetailViewController *detailView=[[shopDetailViewController alloc]initWithNibName:@"shopDetailViewController" bundle:nil shopDetail:[_shopLists objectAtIndex:indexPath.row] govermentData:nil];
    [self.navigationController pushViewController:detailView animated:TRUE];

    
}

#pragma mark - webGetter delegate
-(void)doThingAfterWebJsonIsOKFromDelegate{
    _shopLists=webGetter.webData;
    [_tableView reloadData];
}

@end
