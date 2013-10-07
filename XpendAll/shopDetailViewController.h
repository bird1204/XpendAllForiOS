//
//  shopDetailViewController.h
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface shopDetailViewController : UIViewController<MKMapViewDelegate>



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil shopDetail:(NSDictionary*)shopDetail govermentData:(NSInteger*)govermentData;
- (IBAction)toFullScreen:(id)sender;

@property (strong, nonatomic) NSDictionary *shopDetail;
@property (nonatomic) NSInteger *govermentData;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *shopName;
@property (strong, nonatomic) IBOutlet UILabel *shopTel;
@property (strong,nonatomic )IBOutlet UITextView *shopDesc;

- (IBAction)showDescription:(id)sender;
- (IBAction)btnback:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *shopAddress;

@end
