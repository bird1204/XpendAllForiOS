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
- (IBAction)selectDistrict:(id)sender;
- (IBAction)selectCategory:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *textDistrict;
@property (strong, nonatomic) IBOutlet UIButton *textCategory;
@property (nonatomic ,strong) IBOutlet UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray *govermentData;
@property (strong,nonatomic) NSMutableArray *govermentOriginData;
@property (strong,nonatomic) NSMutableArray *categories;
@property (strong,nonatomic) NSMutableArray *districts;

@end
