//
//  ViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/9/30.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "ViewController.h"
#import "collectionCell.h"
#import "productViewController.h"
#import "suspendViewController.h"
#import "aboutUsViewController.h"
#import "GetJsonURLString.h"
#import "shopViewController.h"
#import "shopWithKmlViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize funtionsList = _funtionsList;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _funtionsList=[[NSArray alloc]initWithObjects:@"Find Shop",@"Find Product",@"Help Someone",@"About Us", nil];
    _imgList=[[NSArray alloc]initWithObjects:@"btn_map",@"btn_food",@"btn_help",@"btn_about", nil];
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
   
    
    cell.titleLabel.text=[NSString stringWithFormat:@"%@",[_funtionsList objectAtIndex:indexPath.row]];
    cell.imageView.image=[UIImage imageNamed:[_imgList objectAtIndex:indexPath.row]];
    //cell.titleLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - select collectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *view=nil;
    switch (indexPath.row) {
        case 0:
            view = (UINavigationController*)[[shopViewController alloc]initWithNibName:@"shopViewController" bundle:nil url:GetGovermentHQ];
            break;
        case 1:
            view = (UINavigationController*)[[productViewController alloc]initWithNibName:@"productViewController" bundle:nil];
            break;
        case 2:
            view = (UINavigationController*)[[suspendViewController alloc]initWithNibName:@"suspendViewController" bundle:nil];
            break;
        case 3:
            view = (UINavigationController*)[[aboutUsViewController alloc]initWithNibName:@"aboutUsViewController" bundle:nil];
            break;
        default:
            break;
    }
    view.title=[_funtionsList objectAtIndex:indexPath.row];
//    [self.navigationController setNavigationBarHidden:FALSE animated:TRUE];
    
    if (indexPath.row==0) {
        shopWithKmlViewController *kml=[[shopWithKmlViewController alloc]initWithNibName:@"shopWithKmlViewController" bundle:nil];
        
        kml.title=@"待用地圖";
        kml.tabBarItem.image=[UIImage imageNamed:@"gamebaby"]; //tab bar item 的 小圖示(30*30 + 60*60)
        view.title=@"政府認證";
        view.tabBarItem.image=[UIImage imageNamed:@"gamebaby"];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        [tabBarController setViewControllers:[NSArray arrayWithObjects:view,kml,nil]];
        
        //backgroundImage 是設定tabBar的背景
        //tabBarController.tabBar.backgroundImage=[UIImage imageNamed:@"icon-googleplus"];
        
        //UIBarStyleDefault 是透明
        //tabBarController.tabBar.barStyle=UIBarStyleDefault;
        
        //取tabBar的高
        //tabBarController.tabBar.frame.size.height
        
        
        [self.navigationController pushViewController:tabBarController animated:TRUE];
    }else{
        [self.navigationController pushViewController:view animated:TRUE];
    }
   
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
}

-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

@end
