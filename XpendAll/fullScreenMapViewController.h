//
//  fullScreenMapViewController.h
//  XpendAll
//
//  Created by BirdChiu on 13/10/1.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface fullScreenMapViewController : UIViewController
- (IBAction)dismissFullScreenMap:(id)sender;

@property (strong, nonatomic) NSDictionary *shopDetail;
@property (strong, nonatomic) IBOutlet MKMapView *fullScreenMapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil shopDetail:(NSDictionary*)shopDetail ;
@end
