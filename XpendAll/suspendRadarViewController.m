//
//  suspendRadarViewController.m
//  XpendAll
//
//  Created by BirdChiu on 2013/10/30.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "suspendRadarViewController.h"
#import "Annotation.h"
#import "MyAnnotaionView.h"
#import "MKMapView+ZoomMapRegion.h"



@interface suspendRadarViewController ()

@end

@implementation suspendRadarViewController
@synthesize radarView = _radarView;
@synthesize demoShopOriginalLists=_demoShopOriginalLists;
@synthesize nearShopLists=_nearShopLists;
@synthesize govermentOriginData=_govermentOriginData;
@synthesize distanceLabel=_distanceLabel;
@synthesize distanceSlider=_distanceSlider;
@synthesize distance=_distance;

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
    
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"kmlData.json"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    _demoShopOriginalLists = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"govermentData.json"];
    str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    data = [str dataUsingEncoding:NSUTF8StringEncoding];
    _govermentOriginData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    _distanceSlider.maximumValue=10000;
    _distanceSlider.minimumValue=1;
    _distanceSlider.value=3000;
    
    _distanceLabel.textAlignment=NSTextAlignmentCenter;
    [_distanceLabel setText:[NSString stringWithFormat:@"%d 公尺",(int)floor(_distanceSlider.value)]];
    
    _distance=_distanceSlider.value;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)distanceChanged:(id)sender {
    _distanceLabel.textAlignment=NSTextAlignmentCenter;
    [_distanceLabel setText:[NSString stringWithFormat:@"%d 公尺",(int)floor(_distanceSlider.value)]];
}

- (IBAction)distanceTouchUp:(id)sender {
    if (_distanceSlider.value < _distance ) {
        [_radarView removeAnnotations:_radarView.annotations];
    }
    _distance=_distanceSlider.value;
    [locationManager startUpdatingLocation];
}

#pragma mark -
#pragma mark - loacation delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    currentLocation=(CLLocation*)[locations lastObject];
    [self setMapView:nil GovermentData:FALSE onlySelfLocation:TRUE];

    for (NSDictionary *suspendLocation in _demoShopOriginalLists) {
        CLLocation *nearShopLocation=[[CLLocation alloc]initWithLatitude:[[[suspendLocation objectForKey:@"coords"] objectAtIndex:0] doubleValue] longitude:[[[suspendLocation objectForKey:@"coords"] objectAtIndex:1] doubleValue]];
        CLLocationDistance meters =[currentLocation distanceFromLocation:nearShopLocation];
        if ((CGFloat)meters < _distanceSlider.value) {
            [self setMapView:suspendLocation GovermentData:FALSE onlySelfLocation:FALSE];
        }
    }
    
    for (NSDictionary *suspendLocation in _govermentOriginData) {
        CLLocation *nearShopLocation=[[CLLocation alloc]initWithLatitude:[[suspendLocation objectForKey:@"lat"]doubleValue] longitude:[[suspendLocation objectForKey:@"lon"]doubleValue]];
        CLLocationDistance meters =[currentLocation distanceFromLocation:nearShopLocation];
        if ((CGFloat)meters < _distanceSlider.value) {
            [self setMapView:suspendLocation GovermentData:TRUE onlySelfLocation:FALSE];
        }
    }

    [_radarView zoomToFitMapAnnotations];
    [locationManager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ( [error code] == kCLErrorDenied ) {
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        
    }
}

#pragma mark - MKMap View Delegate

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MyAnnotaionView *pin=[[MyAnnotaionView alloc] initWithAnnotation:annotation reuseIdentifier:@"anno"];
    [pin setCanShowCallout:YES];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [pin setRightCalloutAccessoryView:btn];
    return pin ;
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"%@",view);
//    LocationDetailViewController *detailView=[[LocationDetailViewController alloc] initWithNibName:@"LocationDetailViewController" bundle:nil];
//    detailView.anno=(Annotation*)view.annotation;
//    [self.navigationController pushViewController:detailView animated:YES];
    //[self presentViewController:detailView animated:YES completion:nil];
}

#pragma mark - private method

-(void)setMapView:(NSDictionary*)shopDetail GovermentData:(BOOL)isGovermentDataOrNot onlySelfLocation:(BOOL)onlySelfOrNot{
    //init map view
    
    CLLocationCoordinate2D coord;
    if (onlySelfOrNot) {
        coord=currentLocation.coordinate;
        //coord.latitude=25.018729;
        //coord.longitude=121.535096;
        if (coord.latitude!=0.0 || coord.longitude!=0.0) {
            Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
            [anno setTitle:@"我在這裡"];
            [anno setType:[NSNumber numberWithInt:0]];

            [_radarView addAnnotation:anno];
        }
    }else{
        if (isGovermentDataOrNot) {
            coord.latitude=[[shopDetail objectForKey:@"lat"]doubleValue];
            coord.longitude=[[shopDetail objectForKey:@"lon"]doubleValue];
            if (coord.latitude!=0.0 || coord.longitude!=0.0) {
                Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
                [anno setTitle:[shopDetail objectForKey:@"org_name"]];
                [anno setSubtitle:[shopDetail objectForKey:@"address"]];
                [anno setType:[NSNumber numberWithInt:2]];
                
                [_radarView addAnnotation:anno];
            }
        }else{
            coord.latitude=[[[shopDetail objectForKey:@"coords"] objectAtIndex:0] doubleValue];
            coord.longitude=[[[shopDetail objectForKey:@"coords"] objectAtIndex:1] doubleValue];
            if (coord.latitude!=0.0 || coord.longitude!=0.0) {
                Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
                [anno setTitle:[shopDetail objectForKey:@"title"]];
                [anno setSubtitle:[shopDetail objectForKey:@"address"]];
                [anno setType:[NSNumber numberWithInt:1]];
                
                [_radarView addAnnotation:anno];
            }
        }
    }
}
@end
