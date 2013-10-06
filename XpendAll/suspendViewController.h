//
//  suspendViewController.h
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKReverseGeocoder.h>

@interface suspendViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *currentLocation;
    IBOutlet UITextField *quantity;
    IBOutlet UITextField *category;
    IBOutlet UITextField *address;
    IBOutlet UITextField *textTitle;
    IBOutlet UITextField *remark;
    
}

- (IBAction)backbtn:(id)sender;
- (IBAction)reportSuspend:(id)sender;

@property (retain, nonatomic) IBOutlet UIPickerView *pickerView;
@property (retain, nonatomic) IBOutlet UITextField *quantity;
@property (retain, nonatomic) IBOutlet UITextField *category;
@property (retain, nonatomic) IBOutlet UITextField *address;
@property (retain, nonatomic) IBOutlet UITextField *textTitle;
@property (retain, nonatomic) IBOutlet UITextField *remark;

@property (strong,nonatomic) NSArray *categories;
@property (strong,nonatomic) NSArray *quantities;
@property (strong,nonatomic) UITextField *workingField;


@end
