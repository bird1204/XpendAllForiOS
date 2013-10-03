//
//  shopDetailViewController.m
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "MKMapView+ZoomMapRegion.h"
#import "fullScreenMapViewController.h"
#import "shopDetailViewController.h"
#import "Annotation.h"
#import "fullScreenMapViewController.h"
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
    
    [self.mapView zoomToFitMapAnnotations];
    
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
    fullScreen.shoptitle.text=self.shopName.text;
    fullScreen.address.text=self.shopAddress.text;
    
}

- (IBAction)btnback:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}
@end
