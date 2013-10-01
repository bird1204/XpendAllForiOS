//
//  ViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/9/30.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "MFSideMenu.h"
#import "ViewController.h"
#import "collectionCell.h"
#import "suspendShopViewController.h"
#import "shopLeftSideViewController.h"
#import "productViewController.h"
#import "suspendViewController.h"
#import "aboutUsViewController.h"
#import "GetJsonURLString.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize funtionsList = _funtionsList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Title";
    _funtionsList=[[NSArray alloc]initWithObjects:@"find shop",@"find product",@"help someone",@"about us", nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setup CollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //return [self.array_Collection count];
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Setup cell identifier
    static NSString *cellIdentifier = @"CVcell";
    //抓陣列的值
    collectionCell *cell = (collectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",[_funtionsList objectAtIndex:indexPath.row]];
    cell.imageView.image=[UIImage imageNamed:@"gamebaby"];
    //cell.titleLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - select collectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *view=nil;
    switch (indexPath.row) {
        case 0:
            view = (UIViewController*)[[suspendShopViewController alloc]initWithNibName:@"suspendShopViewController" bundle:nil url:GetGovermentHQ];
            break;
        case 1:
            view = (UIViewController*)[[productViewController alloc]initWithNibName:@"productViewController" bundle:nil];
            break;
        case 2:
            view = (UIViewController*)[[suspendViewController alloc]initWithNibName:@"suspendViewController" bundle:nil];
            break;
        case 3:
            view = (UIViewController*)[[aboutUsViewController alloc]initWithNibName:@"aboutUsViewController" bundle:nil];
            break;
        default:
            break;
    }
    view.title=[_funtionsList objectAtIndex:indexPath.row];
    
    if (indexPath.row==0) {
        shopLeftSideViewController *leftSideView=[[shopLeftSideViewController alloc]initWithNibName:@"shopLeftSideViewController" bundle:nil];
        MFSideMenuContainerViewController *container=[MFSideMenuContainerViewController containerWithCenterViewController:view leftMenuViewController:leftSideView rightMenuViewController:nil];
        self.navigationController.title=@"愛心補給站";
        [self.navigationController pushViewController:container animated:TRUE];
    }else{
        [self.navigationController pushViewController:view animated:TRUE];
    }
   
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5];
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


@end
