//
//  shopLeftSideViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "shopLeftSideViewController.h"
#import "GetJsonURLString.h"
#import "MFSideMenu.h"

@interface shopLeftSideViewController ()

@end

@implementation shopLeftSideViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.categoriesList=[[NSArray alloc]initWithObjects:@"愛心補給站",@"老人共餐",@"溫馨送餐", nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    // Return the number of rows in the section.
    return [self.categoriesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text=[self.categoriesList objectAtIndex:indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *urlList=[[NSArray alloc]initWithObjects:GetGovermentHQ,GetGovermentTogether,GetGovermentDelivery, nil];
//    suspendMainView=[[shopViewController alloc]initWithNibName:@"shopViewController" bundle:nil url:[urlList  objectAtIndex:indexPath.row]];
//    suspendMainView.title=[self.categoriesList objectAtIndex:indexPath.row];
//    
//    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
//    
//    NSArray *controllers = [NSArray arrayWithObject:suspendMainView];
//    navigationController.viewControllers = controllers;
//    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    
    suspendMainView = [[shopViewController alloc]initWithNibName:@"shopViewController" bundle:nil url:[urlList  objectAtIndex:indexPath.row]];
    suspendMainView.title=[self.categoriesList objectAtIndex:indexPath.row];
    
    
    
    UINavigationController *navigationController = (UINavigationController*)self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObject:suspendMainView];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}
 


@end
