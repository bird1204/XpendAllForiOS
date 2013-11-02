//
//  fullScreenMapViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//
#import "Annotation.h"
#import "fullScreenMapViewController.h"
#import "MKMapView+ZoomMapRegion.h"
@interface fullScreenMapViewController ()

@end

@implementation fullScreenMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil shopDetail:(NSDictionary*)shopDetail govermentData:(NSInteger*)govermentData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.shopDetail=shopDetail;
        self.govermentData=govermentData;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.govermentData) {
        [self setMapViewFromGovermentData];
    }else{
        [self setMapViewFromKMLData];
    }
    
//    CLLocationCoordinate2D coord;
//    coord.latitude=[[self.shopDetail objectForKey:@"lat"]doubleValue];
//    coord.longitude=[[self.shopDetail objectForKey:@"lon"]doubleValue];
//
//    
//    if (coord.latitude!=0.0 || coord.longitude!=0.0) {
//        Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
//        [anno setTitle:[self.shopDetail objectForKey:@"address"]];
//        [anno setSubtitle:[self.shopDetail objectForKey:@"SubTitle"]];
//        
//        [self.fullScreenMapView addAnnotation:anno];
//    }
//    [self.fullScreenMapView zoomToFitMapAnnotations];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.shopDetail=nil;
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissFullScreenMap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)setMapViewFromGovermentData{
    //init map view
    CLLocationCoordinate2D coord;
    coord.latitude=[[self.shopDetail objectForKey:@"lat"]doubleValue];
    coord.longitude=[[self.shopDetail objectForKey:@"lon"]doubleValue];
    
    
    if (coord.latitude!=0.0 || coord.longitude!=0.0) {
        Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
        [anno setTitle:[self.shopDetail objectForKey:@"address"]];
        [anno setSubtitle:[self.shopDetail objectForKey:@"SubTitle"]];
        
        [self.fullScreenMapView addAnnotation:anno];
    }
    [self.fullScreenMapView zoomToFitMapAnnotations];
}

-(void)setMapViewFromKMLData{
    //init map view
    CLLocationCoordinate2D coord;
    coord.latitude=[[[self.shopDetail objectForKey:@"coords"] objectAtIndex:0] doubleValue];
    coord.longitude=[[[self.shopDetail objectForKey:@"coords"] objectAtIndex:1] doubleValue];
    
    if (coord.latitude!=0.0 || coord.longitude!=0.0) {
        Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
        [anno setTitle:[self.shopDetail objectForKey:@"title"]];
        [anno setSubtitle:[self.shopDetail objectForKey:@"address"]];
        
        [self.fullScreenMapView addAnnotation:anno];
    }
     [self.fullScreenMapView zoomToFitMapAnnotations];
}
@end
