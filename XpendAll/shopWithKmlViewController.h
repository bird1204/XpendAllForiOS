//
//  shopWithKmlViewController.h
//  XpendAll
//
//  Created by BirdChiu on 13/10/5.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KML/KML.h>
#import "WebJsonDataGetter.h"


@interface shopWithKmlViewController : UIViewController<WebJsonDataGetFinishDelegater,UITableViewDataSource,UITableViewDelegate>{
    WebJsonDataGetter *webGetter;
}

@property (strong,nonatomic) NSMutableArray *shopLists;
@property (strong,nonatomic) NSMutableArray *shopOriginalLists;
@property (strong,nonatomic) NSMutableArray *categories;
@property (strong,nonatomic) NSMutableArray *districts;
//demo
@property (strong,nonatomic) NSMutableArray *demoShopLists;
@property (strong,nonatomic) NSMutableArray *demoShopOriginalLists;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *textDistrict;
@property (strong, nonatomic) IBOutlet UIButton *textCategory;


- (IBAction)selectDistrict:(id)sender;
- (IBAction)selectCategory:(id)sender;
- (IBAction)backbtn:(id)sender;

@end
