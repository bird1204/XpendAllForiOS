//
//  productViewController.h
//  XpendAll
//
//  Created by BirdChiu on 13/10/2.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebJsonDataGetter.h"
@interface productViewController : UIViewController<WebJsonDataGetFinishDelegater,UITableViewDataSource,UITableViewDelegate>{
    WebJsonDataGetter *webGetter;
}
@property (nonatomic,strong) IBOutlet UITableView *tableView;
- (IBAction)backbtn:(id)sender;

@end
