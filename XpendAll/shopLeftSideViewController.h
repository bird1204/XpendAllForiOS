//
//  shopLeftSideViewController.h
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shopViewController.h"

@interface shopLeftSideViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    shopViewController  *suspendMainView;
}
@property  (nonatomic,strong) NSArray *categoriesList;
@end
