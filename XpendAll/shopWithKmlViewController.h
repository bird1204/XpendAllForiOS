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

@interface shopWithKmlViewController : UIViewController<WebJsonDataGetFinishDelegater,UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    WebJsonDataGetter *webGetter;
}

@property (strong,nonatomic) NSMutableArray *shopLists;
@property (strong,nonatomic) NSMutableArray *categories;
@property (strong,nonatomic) NSMutableArray *districts;

@property (retain, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldDistrict;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldCategory;
@property (strong,nonatomic) UITextField *workingField;


- (IBAction)backbtn:(id)sender;

@end
