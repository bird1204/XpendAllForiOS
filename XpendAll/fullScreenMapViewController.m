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
@end
