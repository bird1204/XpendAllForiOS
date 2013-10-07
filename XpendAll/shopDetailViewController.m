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
@synthesize shopDesc=_shopDesc;


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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.shopDetail=nil;

    // Dispose of any resources that can be recreated.
}

- (IBAction)toFullScreen:(id)sender {
    
    
    fullScreenMapViewController *fullScreen=[[fullScreenMapViewController alloc]initWithNibName:@"fullScreenMapViewController" bundle:nil shopDetail:self.shopDetail govermentData:self.govermentData];

    
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
        _shopDesc.text = [self.shopDetail objectForKey:@"description"];
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
    NSLog(@"jiji");
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
    // Do any additional setup after loading the view from its nib.
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
        
        [self.mapView addAnnotation:anno];
    }
    
    [self.mapView zoomToFitMapAnnotations];
    
    //init label text
    self.shopName.text=[self.shopDetail objectForKey:@"title"];
    self.shopAddress.text=[self.shopDetail objectForKey:@"address"];
    self.shopTel.text=[NSString stringWithFormat:@"%@",[self.shopDetail objectForKey:@"phoneNumber"]];
    // Do any additional setup after loading the view from its nib.
    
}
@end
