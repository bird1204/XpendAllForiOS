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
    UIBackgroundTaskIdentifier backgroundTask;
    CLLocationManager* locationManager;
    BOOL isNotifationPushed;
}

@property (strong, nonatomic) UIWindow *window;

@end
