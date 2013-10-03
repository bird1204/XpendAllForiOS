//
//  shopViewController.h
//  XpendAll
//
//  Created by BirdChiu on 13/10/2.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebJsonDataGetter.h"


@interface shopViewController : UIViewController<WebJsonDataGetFinishDelegater,UITableViewDataSource,UITableViewDelegate>{
    WebJsonDataGetter *webGetter;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*)url;
- (IBAction)backbtn:(id)sender;

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@end
