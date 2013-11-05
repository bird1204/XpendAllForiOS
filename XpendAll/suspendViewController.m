//
//  suspendViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "suspendViewController.h"
#import "MMPickerView.h"
#import "AppDelegate.h"


@interface suspendViewController ()

@end

@implementation suspendViewController
@synthesize address=_address;
@synthesize remark=_remark;
@synthesize textTitle=_textTitle;
@synthesize category=_category;
@synthesize quantity=_quantity;
@synthesize pickerView=_pickerView;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _categories=[[NSArray alloc]initWithObjects:@"食品",@"飲品",@"物資",@"特殊狀況", nil];
    _quantities=[[NSArray alloc]initWithObjects:
                     @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                     @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",
                     @"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    

    [_category setText:@"食品"];
    [_quantity setText:@"1"];
    [_feedback setHidden:YES];
    
    AppDelegate *appDelgate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    CLGeocoder *geoCoder=[[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:appDelgate.currentLocation completionHandler:^(NSArray *placemarks,NSError *error){
        
        CLPlacemark *place=[[CLPlacemark alloc]initWithPlacemark:[placemarks objectAtIndex:0]];
                NSLog(@"%@",[place locality]);              //桃園縣
                NSLog(@"%@",[place name]);                  //國豐六街 96號
                NSLog(@"%@",[place addressDictionary]);
                NSLog(@"%@",[place ISOcountryCode]);        //TW
                NSLog(@"%@",[place country]);               //台灣
                NSLog(@"%@",[place postalCode]);            //330
                NSLog(@"%@",[place administrativeArea]);    //台灣
                NSLog(@"%@",[place subAdministrativeArea]); //桃園縣
                NSLog(@"%@",[place locality]);              //桃園縣
                NSLog(@"%@",[place subLocality]);           //桃園市
                NSLog(@"%@",[place thoroughfare]);          //國豐六街
                NSLog(@"%@",[place subThoroughfare]);       //96號
                NSLog(@"%@",[place region]);                //
        NSString *sublocality=@"";
        if ([place subLocality]) {
            sublocality=[place subLocality];
        }else{
            sublocality=[place administrativeArea];
        }
        NSString *addressDetail=[NSString stringWithFormat:@"%@%@",sublocality,[place thoroughfare]];
        [_address setText:addressDetail];
        if (error) {
            NSLog(@"%@",error);
        }
    }];

    
//    currentLocation = [[CLLocationManager alloc] init];
//    currentLocation.delegate = self;
//    currentLocation.desiredAccuracy = kCLLocationAccuracyKilometer;
//    currentLocation.distanceFilter = kCLDistanceFilterNone;
//    [currentLocation startUpdatingLocation];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _remark=nil;
    _textTitle=nil;
    _address=nil;
    _category=nil;
    _quantity=nil;
    _pickerView=nil;
    _categories=nil;
    _quantities=nil;
    _workingField=nil;
}

- (IBAction)backbtn:(id)sender {
     [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)reportSuspend:(id)sender {
    [self.view endEditing:TRUE];
    NSLog(@"title  %@",[_textTitle text]);
    NSLog(@"address  %@",[_address text]);
    NSLog(@"quantity  %@",[_quantity text]);
    NSLog(@"category  %@",[_category text]);
    NSLog(@"remark  %@",[_remark text]);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"確認訊息" message:@"感謝你通報待用產品，\n請按下確定送出！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"確定",nil];
    [alert show];

    
}


#pragma mark -
#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    _workingField=textField;
    if (_quantity==textField) {
        [self.view endEditing:TRUE];
        [MMPickerView showPickerViewInView:self.view
                               withStrings:_quantities
                               withOptions:@{MMbackgroundColor: [UIColor lightTextColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor lightGrayColor],
                                             MMbuttonColor: [UIColor blackColor],
                                             MMfont: [UIFont systemFontOfSize:24],
                                             MMvalueY: @3,
                                             MMselectedObject:[_quantity text],
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    [_quantity setText:selectedString];
                                }];
        return NO;
    }
    if (_category==textField) {
        [self.view endEditing:TRUE];
        [MMPickerView showPickerViewInView:self.view
                               withStrings:_categories
                               withOptions:@{MMbackgroundColor: [UIColor lightTextColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor lightGrayColor],
                                             MMbuttonColor: [UIColor blackColor],
                                             MMfont: [UIFont systemFontOfSize:24],
                                             MMvalueY: @3,
                                             MMselectedObject:[_category text],
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    [_category setText:selectedString];
                                }];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:TRUE];
    return YES;
}

#pragma mark -
#pragma mark - loacation delegate
/*
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *loc=(CLLocation*)[locations lastObject];

    CLGeocoder *geoCoder=[[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks,NSError *error){
        
        CLPlacemark *place=[[CLPlacemark alloc]initWithPlacemark:[placemarks objectAtIndex:0]];
//        NSLog(@"%@",[place locality]);              //桃園縣
//        NSLog(@"%@",[place name]);                  //國豐六街 96號
//        NSLog(@"%@",[place addressDictionary]);
//        NSLog(@"%@",[place ISOcountryCode]);        //TW
//        NSLog(@"%@",[place country]);               //台灣
//        NSLog(@"%@",[place postalCode]);            //330
//        NSLog(@"%@",[place administrativeArea]);    //台灣
//        NSLog(@"%@",[place subAdministrativeArea]); //桃園縣
//        NSLog(@"%@",[place locality]);              //桃園縣
//        NSLog(@"%@",[place subLocality]);           //桃園市
//        NSLog(@"%@",[place thoroughfare]);          //國豐六街
//        NSLog(@"%@",[place subThoroughfare]);       //96號
//        NSLog(@"%@",[place region]);                //
        
        NSString *sublocality=@"";
        if ([place subLocality]) {
            sublocality=[place subLocality];
        }else{
            sublocality=[place administrativeArea];
        }
        NSString *addressDetail=[NSString stringWithFormat:@"%@%@%@",sublocality,[place thoroughfare],[place subThoroughfare]];
        [_address setText:addressDetail];
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    [currentLocation stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ( [error code] == kCLErrorDenied ) {
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        
    }
}
*/

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0: //cancel
            [self resetContent];
            [_feedback setText:@"你已取消一筆資料，期待你下次的通報。"];
            break;
        case 1: //confirm
            [self resetContent];
            [_feedback setText:@"你已新增一筆資料，感謝你為takeIt做出的貢獻！"];
            break;
        default:
            break;
    }
}

-(void)resetContent{
    [_textTitle setText:@""];
    [_address setText:@""];
    [_quantity setText:@""];
    [_category setText:@""];
    [_remark setText:@""];
    [_feedback setHidden:NO];
}


@end
