//
//  AppDelegate.h
//  XpendAll
//
//  Created by BirdChiu on 13/9/30.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>{
    CLLocationManager* locationManager;
    CLLocation *currentLocation;    
}

@property (strong,nonatomic) NSMutableArray *shopOriginalLists;
@property (strong,nonatomic) NSMutableArray *govermentOriginLists;
@property (strong,nonatomic) NSMutableDictionary *nearShopLists;

@property (strong, nonatomic) UIWindow *window;
@property (assign)CLLocation *currentLocation;


@end
