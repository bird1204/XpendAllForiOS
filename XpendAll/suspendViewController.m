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
    self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(self.remark.frame.origin.x+self.remark.frame.size.height+10, 0, self.view.frame.size.width, self.view.frame.size.height-self.remark.frame.origin.x-self.remark.frame.size.height)];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView setBackgroundColor:[UIColor clearColor]];
    [self.pickerView setShowsSelectionIndicator:YES];
    
    self.category.inputView.backgroundColor=[UIColor blueColor];
    self.category.inputView=self.pickerView;
    self.quantity.inputView=self.pickerView;
    
    self.categories=[[NSArray alloc]initWithObjects:@"食品",@"飲品",@"物資",@"特殊狀況", nil];
    self.quantities=[[NSArray alloc]initWithObjects:
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
    self.remark=nil;
    self.title=nil;
    self.address=nil;
    self.category=nil;
    self.quantity=nil;
    self.pickerView=nil;
    self.categories=nil;
    self.quantities=nil;
    self.workingField=nil;
}

- (IBAction)backbtn:(id)sender {
     [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)reportSuspend:(id)sender {
//    NSString *title=[self.title text];
    NSLog(@"title  ");
//    NSLog(@"address  %@",self.address.text);
//    NSLog(@"quantity  %@",self.quantity.text);
//    NSLog(@"category  %@",self.category.text);
//    NSLog(@"remark  %@",self.remark.text);
    
}



#pragma mark -
#pragma mark - pickerView datesource
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count=0;
    if (self.workingField==self.category) {
        count = [self.categories count];
    }
    if (self.workingField==self.quantity) {
        count = [self.quantities count];
    }
    return count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *titleString=@"";
    if (self.workingField==self.category) {
        titleString= [self.categories objectAtIndex:row];
    }
    if (self.workingField==self.quantity) {
        titleString=  [self.quantities objectAtIndex:row];
    }
    
    return titleString;
}


#pragma mark -
#pragma mark - pickerView delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (self.workingField==self.category) {
        [self.category setText:[self.categories objectAtIndex:row]];
    }
    if (self.workingField==self.quantity) {
        [self.quantity setText:[self.quantities objectAtIndex:row]];
    }
}


#pragma mark -
#pragma mark - textField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.workingField=textField;
    [self.pickerView reloadAllComponents];
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

    geoCoder=[[CLGeocoder alloc]init];
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
        
        NSString *address=[NSString stringWithFormat:@"%@%@%@",[place subLocality],[place thoroughfare],[place subThoroughfare]];
        [self.address setText:address];
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
