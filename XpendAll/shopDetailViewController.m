//
//  shopDetailViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "fullScreenMapViewController.h"
#import "shopDetailViewController.h"
#import "Annotation.h"
@interface shopDetailViewController ()

@end

@implementation shopDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil shopDetail:(NSDictionary*)shopDetail
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.shopDetail=shopDetail;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //init map view
    CLLocationCoordinate2D coord;
    coord.latitude=[[self.shopDetail objectForKey:@"lat"]doubleValue];
    coord.longitude=[[self.shopDetail objectForKey:@"lon"]doubleValue];
    
    if (coord.latitude!=0.0 || coord.longitude!=0.0) {
        Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
        [anno setTitle:[self.shopDetail objectForKey:@"address"]];
        [anno setSubtitle:[self.shopDetail objectForKey:@"SubTitle"]];

        [self.mapView addAnnotation:anno];
    }
    
    [self zoomToFitMapAnnotations:self.mapView];

    
    //init label text
    self.shopName.text=[self.shopDetail objectForKey:@"org_name"];
    self.shopAddress.text=[self.shopDetail objectForKey:@"address"];
    self.shopTel.text=[self.shopDetail objectForKey:@"phone"];
    self.shopLatitude.text=[self.shopDetail objectForKey:@"lat"];
    self.shopLongtitue.text=[self.shopDetail objectForKey:@"lon"];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.shopDetail=nil;

    // Dispose of any resources that can be recreated.
}

- (IBAction)toFullScreen:(id)sender {
    fullScreenMapViewController *fullScreen=[[fullScreenMapViewController alloc]initWithNibName:@"fullScreenMapViewController" bundle:nil shopDetail:self.shopDetail];
    [self presentViewController:fullScreen animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark zoom To Fit Map Annotations
-(void)zoomToFitMapAnnotations:(MKMapView*)mapView{
    if([mapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(Annotation* annotation in mapView.annotations)
    {
        //if (annotation != (Annotation*)mapView.userLocation) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
        //}
        
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}

- (IBAction)btnback:(id)sender {
     [self.navigationController popViewControllerAnimated: YES];
}
@end
