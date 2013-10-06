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

@property (strong,nonatomic) NSArray *shopLists;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)backbtn:(id)sender;

@end
