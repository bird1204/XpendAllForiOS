//
//  suspendShopViewController.h
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebJsonDataGetter.h"


@interface suspendShopViewController : UITableViewController<WebJsonDataGetFinishDelegater>{
    WebJsonDataGetter *webGetter;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil url:(NSString*)url;
@end
