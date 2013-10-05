//
//  suspendViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "suspendViewController.h"

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
    _pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(_remark.frame.origin.x+_remark.frame.size.height+10, 0, self.view.frame.size.width, self.view.frame.size.height-_remark.frame.origin.x-_remark.frame.size.height)];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];
    [_pickerView setBackgroundColor:[UIColor clearColor]];
    [_pickerView setShowsSelectionIndicator:YES];
    
//    _title.keyboardType=UIKeyboardTypeAlphabet;
//    _address.keyboardType=UIKeyboardTypeAlphabet;
//    _remark.keyboardType=UIKeyboardTypeAlphabet;
//    
//    _title.returnKeyType=UIReturnKeyDone;
//    _address.returnKeyType=UIReturnKeyDone;
//    _remark.returnKeyType=UIReturnKeyDone;

    _category.inputView.backgroundColor=[UIColor blueColor];
    _category.inputView=_pickerView;
    _quantity.inputView=_pickerView;
    
    _categories=[[NSArray alloc]initWithObjects:@"食品",@"飲品",@"物資",@"特殊狀況", nil];
    _quantities=[[NSArray alloc]initWithObjects:
                     @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
                     @"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",
                     @"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    
    
    //listen tap event
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];

        
    currentLocation = [[CLLocationManager alloc] init];
    currentLocation.delegate = self;
    currentLocation.desiredAccuracy = kCLLocationAccuracyKilometer;
    currentLocation.distanceFilter = kCLDistanceFilterNone;
    [currentLocation startUpdatingLocation];

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
    NSLog(@"title  %@",[_textTitle text]);
    NSLog(@"address  %@",[_address text]);
    NSLog(@"quantity  %@",[_quantity text]);
    NSLog(@"category  %@",[_category text]);
    NSLog(@"remark  %@",[_remark text]);
    
}



#pragma mark -
#pragma mark - pickerView datesource
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count=0;
    if (_workingField==_category) {
        count = [_categories count];
    }
    if (_workingField==_quantity) {
        count = [_quantities count];
    }
    return count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *titleString=@"";
    if (_workingField==_category) {
        titleString= [_categories objectAtIndex:row];
    }
    if (_workingField==_quantity) {
        titleString=  [_quantities objectAtIndex:row];
    }
    
    return titleString;
}


#pragma mark -
#pragma mark - pickerView delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (_workingField==_category) {
        [_category setText:[_categories objectAtIndex:row]];
    }
    if (_workingField==_quantity) {
        [_quantity setText:[_quantities objectAtIndex:row]];
    }
}


#pragma mark -
#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    _workingField=textField;
    [_pickerView reloadAllComponents];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:TRUE];
    return YES;
}


#pragma mark -
#pragma mark - gestureRecognizer delegate
- (void)tapRecognized:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:TRUE];
}


#pragma mark -
#pragma mark - loacation delegate

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
        
        NSString *addressDetail=[NSString stringWithFormat:@"%@%@%@",[place subLocality],[place thoroughfare],[place subThoroughfare]];
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


@end
