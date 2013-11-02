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
#import <QuartzCore/QuartzCore.h>
@interface shopDetailViewController ()

@end

@implementation shopDetailViewController
@synthesize shopDesc=_shopDesc;
@synthesize shopDetail=_shopDetail;
@synthesize govermentData=_govermentData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil shopDetail:(NSDictionary*)shopDetail govermentData:(NSInteger*)govermentData
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _shopDetail=shopDetail;
        _govermentData=govermentData;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_govermentData) {
        [self setMapViewFromGovermentData];
    }else{
        [self setMapViewFromKMLData];
    }
    
    [_mapView.layer setCornerRadius:10.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _shopDetail=nil;

    // Dispose of any resources that can be recreated.
}

- (IBAction)toFullScreen:(id)sender {
    
    fullScreenMapViewController *fullScreen=[[fullScreenMapViewController alloc]initWithNibName:@"fullScreenMapViewController" bundle:nil shopDetail:_shopDetail govermentData:_govermentData];

    
    [self presentViewController:fullScreen animated:YES completion:nil];
    fullScreen.shoptitle.text=self.shopName.text;
    fullScreen.address.text=self.shopAddress.text;
    
}

- (IBAction)showDescription:(id)sender {
    UIImageView *top=(UIImageView *)[self.view viewWithTag:1];
    UIImageView *mid=(UIImageView *)[self.view viewWithTag:2];
    UIImageView *bottom=(UIImageView *)[self.view viewWithTag:3];
    UIButton *fullView=(UIButton*)[self.view viewWithTag:4];
    
    [top setHidden:TRUE];
    [mid setHidden:TRUE];
    [bottom setHidden:TRUE];
    [fullView setHidden:TRUE];
    [_shopAddress setHidden:TRUE];
    [_shopName setHidden:TRUE];
    [_shopTel setHidden:TRUE];
    [_mapView setHidden:TRUE];
    
    if (_shopDesc == nil) {
        _shopDesc =[[UITextView alloc]init];
        _shopDesc.frame=CGRectMake(_mapView.frame.origin.x,_mapView.frame.origin.y,_mapView.frame.size.width,self.view.frame.size.height-_mapView.frame.origin.y);
        [_shopDesc setFont:[UIFont fontWithName:@"system" size:24]];
        _shopDesc.editable=NO;
        _shopDesc.text = [_shopDetail objectForKey:@"description"];
        _shopDesc.backgroundColor=[UIColor lightTextColor];
        [_shopDesc setDataDetectorTypes:UIDataDetectorTypeAll];
        
        UIButton *leaveDesc = [UIButton buttonWithType:UIButtonTypeCustom];
        [leaveDesc addTarget:self
                      action:@selector(leaveDesc:)
            forControlEvents:UIControlEventTouchDown];
        [leaveDesc setTitle:@"" forState:UIControlStateNormal];
        leaveDesc.frame = _shopDesc.frame;
        
        [_shopDesc addSubview:leaveDesc];
        [self.view addSubview:_shopDesc];
    }else{
        [_shopDesc setHidden:FALSE];
    }
}

- (IBAction)leaveDesc:(id)sender {
    [_shopDesc setHidden:TRUE];
    
    UIImageView *top=(UIImageView *)[self.view viewWithTag:1];
    UIImageView *mid=(UIImageView *)[self.view viewWithTag:2];
    UIImageView *bottom=(UIImageView *)[self.view viewWithTag:3];
    UIButton *fullView=(UIButton*)[self.view viewWithTag:4];

    
    [top setHidden:FALSE];
    [mid setHidden:FALSE];
    [bottom setHidden:FALSE];
    [fullView setHidden:FALSE];
    [_shopAddress setHidden:FALSE];
    [_shopName setHidden:FALSE];
    [_shopTel setHidden:FALSE];
    [_mapView setHidden:FALSE];
}

- (IBAction)btnback:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];
}

-(void)setMapViewFromGovermentData{
    //init map view
    CLLocationCoordinate2D coord;
    coord.latitude=[[_shopDetail objectForKey:@"lat"]doubleValue];
    coord.longitude=[[_shopDetail objectForKey:@"lon"]doubleValue];
    
    if (coord.latitude!=0.0 || coord.longitude!=0.0) {
        Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
        [anno setTitle:[_shopDetail objectForKey:@"address"]];
        [anno setSubtitle:[_shopDetail objectForKey:@"SubTitle"]];
        
        [self.mapView addAnnotation:anno];
    }
    
    [self.mapView zoomToFitMapAnnotations];
    
    //init label text
    self.shopName.text=[_shopDetail objectForKey:@"org_name"];
    self.shopAddress.text=[_shopDetail objectForKey:@"address"];
    self.shopTel.text=[_shopDetail objectForKey:@"phone"];
    // Do any additional setup after loading the view from its nib.
}

-(void)setMapViewFromKMLData{
    //init map view
    CLLocationCoordinate2D coord;
    coord.latitude=[[[_shopDetail objectForKey:@"coords"] objectAtIndex:0] doubleValue];
    coord.longitude=[[[_shopDetail objectForKey:@"coords"] objectAtIndex:1] doubleValue];
    
    if (coord.latitude!=0.0 || coord.longitude!=0.0) {
        Annotation *anno=[[Annotation alloc] initWithCoordinate:coord];
        [anno setTitle:[_shopDetail objectForKey:@"title"]];
        [anno setSubtitle:[_shopDetail objectForKey:@"address"]];
        
        [self.mapView addAnnotation:anno];
    }
    
    [self.mapView zoomToFitMapAnnotations];
    
    //init label text
    self.shopName.text=[_shopDetail objectForKey:@"title"];
    self.shopAddress.text=[_shopDetail objectForKey:@"address"];
    self.shopTel.text=[NSString stringWithFormat:@"%@",[_shopDetail objectForKey:@"phoneNumber"]];
    // Do any additional setup after loading the view from its nib.
    
}
@end
