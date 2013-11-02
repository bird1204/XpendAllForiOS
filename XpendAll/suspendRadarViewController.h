//
//  suspendRadarViewController.h
//  XpendAll
//
//  Created by BirdChiu on 2013/10/30.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface suspendRadarViewController : UIViewController<MKMapViewDelegate>{
    IBOutlet UILabel *distanceLabel;
    MKRoute *routeDetails;
}
- (IBAction)distanceChanged:(id)sender;
- (IBAction)distanceTouchUp:(id)sender;
- (IBAction)backbtn:(id)sender;


@property (strong,nonatomic) NSString *allSteps;
@property (strong,nonatomic) NSMutableArray *demoShopOriginalLists;
@property (strong,nonatomic) NSMutableArray *govermentOriginData;
@property (strong,nonatomic) NSMutableDictionary *nearShopLists;
@property (nonatomic) float distance;

@property (strong, nonatomic) IBOutlet UITextView *destinationSteps;
@property (strong, nonatomic) IBOutlet UISlider *distanceSlider;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet MKMapView *radarView;
@end
