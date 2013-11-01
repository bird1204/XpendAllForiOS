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
#import "UILabel+AutoFrame.h"



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
@synthesize destinationSteps=_destinationSteps;
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
    _radarView=nil;
    _demoShopOriginalLists=nil;
    _nearShopLists=nil;
    _govermentOriginData=nil;
    _distanceLabel=nil;
    _distanceSlider=nil;

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
    if (currentLocation) {
        currentLocation=(CLLocation*)[locations lastObject];
        [self setMapView:nil GovermentData:FALSE onlySelfLocation:TRUE];
    }else{
        NSLog(@"%@",currentLocation);
        currentLocation=(CLLocation*)[locations lastObject];
    }

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
    Annotation *anno=(Annotation*)view.annotation;
    
    CLGeocoder *geoCoder=[[CLGeocoder alloc]init];
    [geoCoder geocodeAddressString:anno.subtitle completionHandler:^(NSArray *placemarks,NSError *error){
        if (error) {
            NSLog(@"error == %@",error.localizedDescription);
        } else {
            CLPlacemark *CLPlaceMark=[[CLPlacemark alloc]initWithPlacemark:[placemarks objectAtIndex:0]];
            MKPlacemark *placemark=[[MKPlacemark alloc]initWithPlacemark:CLPlaceMark];
            
            MKDirectionsRequest *directionsRequest=[[MKDirectionsRequest alloc]init];
            [directionsRequest setDestination:[MKMapItem mapItemForCurrentLocation]];
            [directionsRequest setSource:[[MKMapItem alloc] initWithPlacemark:placemark]];
            directionsRequest.transportType = MKDirectionsTransportTypeWalking;
            MKDirections *direction=[[MKDirections alloc]initWithRequest:directionsRequest];
            [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (error) {
                    NSLog(@"Error %@", error.description);
                } else {
                    routeDetails = response.routes.lastObject;
                    [_destinationSteps removeFromSuperview];
                    [_radarView removeOverlays:_radarView.overlays];
                    [_radarView addOverlay:routeDetails.polyline];
                    
                    _destinationSteps =[[UITextView alloc]init];
                    _destinationSteps.frame=CGRectMake(0, self.view.frame.size.height-100, _radarView.frame.size.width, 20);
                    _destinationSteps.textAlignment=NSTextAlignmentCenter;
                    [_destinationSteps setFont:[UIFont fontWithName:@"system" size:12]];
                    _destinationSteps.editable=NO;
                    _destinationSteps.dataDetectorTypes=UIDataDetectorTypeAll;
                    _destinationSteps.text = [NSString stringWithFormat:@"%@",anno.subtitle];
                    _destinationSteps.backgroundColor=[UIColor lightTextColor];
                    [_radarView addSubview:_destinationSteps];
                    [_destinationSteps setHidden:FALSE];
                }
            }];
        }
    }];
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 5;
    return routeLineRenderer;
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
