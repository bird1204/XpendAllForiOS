//
//  AppDelegate.m
//  XpendAll
//
//  Created by BirdChiu on 13/9/30.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "shopDetailViewController.h"


@implementation AppDelegate
@synthesize shopOriginalLists=_shopOriginalLists;
@synthesize govermentOriginLists=_govermentOriginLists;
@synthesize currentLocation=_currentLocation;
float _defaultDistance=1000.0f;
float _prevShopDistance=0.0f;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"kmlData.json"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    _shopOriginalLists = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"govermentData.json"];
    str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    data = [str dataUsingEncoding:NSUTF8StringEncoding];
    _govermentOriginLists = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     */
    //台科大
    //coord.latitude=25.018729;
    //coord.longitude=121.535096;
    currentLocation =[[CLLocation alloc]initWithLatitude:25.018729 longitude:121.535096];
    _currentLocation=currentLocation;
    
    
    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *mainViewController =
            (ViewController*)[main instantiateViewControllerWithIdentifier: @"ViewController"];
    
    UINavigationController *mainView = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:mainView];
    [self.window makeKeyAndVisible];
    
    //[self startStandardUpdates];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if(backgroundTask == UIBackgroundTaskInvalid)
    {
        UIApplication* app = [UIApplication sharedApplication];
        
        // 開啟了BackgroundTask就要以令以下的queue在Background/Foreground Task都可以運行
        backgroundTask = [app beginBackgroundTaskWithExpirationHandler:^{
            NSLog(@"System Expiration End Background Task");
            [app endBackgroundTask:backgroundTask];
            backgroundTask = UIBackgroundTaskInvalid;
        }];
        
        // Start the long-running task and return immediately.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            UILocalNotification* notifyAlarm_1 = [[UILocalNotification alloc] init];

            NSArray *coords_1=[[NSArray alloc]initWithObjects:@"25.012539",@"121.535414",nil];
            NSDictionary *userInfo=[[NSDictionary alloc]initWithObjectsAndKeys:@"愛呷麵",@"title",@"100台北市中正區汀州路三段269號",@"address",coords_1,@"coords", nil];
            notifyAlarm_1.timeZone = [NSTimeZone defaultTimeZone];
            notifyAlarm_1.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
            notifyAlarm_1.alertAction = @"Take It";
            notifyAlarm_1.alertBody = [NSString stringWithFormat:@"%@的愛心在你身邊，距離：%d公尺",[userInfo objectForKey:@"title"],700];
            notifyAlarm_1.userInfo=userInfo;
            
            
            NSArray *coords_2=[[NSArray alloc]initWithObjects:@"25.024511",@"121.529091",nil];
            UILocalNotification* notifyAlarm_2 = [[UILocalNotification alloc] init];
            NSDictionary *userInfo_2=[[NSDictionary alloc]initWithObjectsAndKeys:@"阿諾可麗餅",@"title",@"106台北市大安區師大路39巷20號",@"address",coords_2,@"coords", nil];
            notifyAlarm_2.timeZone = [NSTimeZone defaultTimeZone];
            notifyAlarm_2.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
            notifyAlarm_2.alertAction = @"Take It";
            notifyAlarm_2.alertBody = [NSString stringWithFormat:@"%@的愛心在你身邊，距離：%d公尺",[userInfo_2 objectForKey:@"title"],1100];
            notifyAlarm_2.userInfo=userInfo_2;
            
            NSArray *coords_3=[[NSArray alloc]initWithObjects:@"25.025069",@"121.523418",nil];
            UILocalNotification* notifyAlarm_3 = [[UILocalNotification alloc] init];
            NSDictionary *userInfo_3=[[NSDictionary alloc]initWithObjectsAndKeys:@"JSP呷尚寶早餐店",@"title",@"100台北市中正區南昌路2段205號",@"address",coords_3,@"coords", nil];
            notifyAlarm_3.timeZone = [NSTimeZone defaultTimeZone];
            notifyAlarm_3.fireDate = [NSDate dateWithTimeIntervalSinceNow:6];
            notifyAlarm_3.alertAction = @"Take It";
            notifyAlarm_3.alertBody = [NSString stringWithFormat:@"%@的愛心在你身邊，距離：%d公尺",[userInfo_3 objectForKey:@"title"],1200];
            notifyAlarm_3.userInfo=userInfo_3;
        
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm_1];
            app.applicationIconBadgeNumber=app.applicationIconBadgeNumber+1;

            [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm_2];
            app.applicationIconBadgeNumber=app.applicationIconBadgeNumber+1;

            [[UIApplication sharedApplication] scheduleLocalNotification:notifyAlarm_3];
            app.applicationIconBadgeNumber=app.applicationIconBadgeNumber+1;

            NSLog(@"Completed State End Background Task");
            [app endBackgroundTask:backgroundTask]; 
            backgroundTask = UIBackgroundTaskInvalid; 
        }); 
    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    UIApplication* app = [UIApplication sharedApplication];
    app.applicationIconBadgeNumber=0;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *mainViewController =
    (ViewController*)[main instantiateViewControllerWithIdentifier: @"ViewController"];
    UINavigationController *mainView = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:mainView];
    [self.window makeKeyAndVisible];
    
    shopDetailViewController *shopDetail=[[shopDetailViewController alloc] initWithNibName:@"shopDetailViewController" bundle:nil shopDetail:notification.userInfo govermentData:nil];
    
    [mainView pushViewController:shopDetail animated:YES];
}
/*
- (void)startStandardUpdates
{
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"update location err-\n%@", error);
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    UIApplication* app = [UIApplication sharedApplication];
    //coord.latitude=25.018729;
    //coord.longitude=121.535096;
    currentLocation =[locations lastObject];
    _currentLocation=currentLocation;
    
    float distance = [self nearShopDistance];
    if (distance <= _defaultDistance)
    {
        UILocalNotification* notifyAlarm = [[UILocalNotification alloc]init];
        notifyAlarm.timeZone = [NSTimeZone defaultTimeZone];
        notifyAlarm.repeatInterval = 0;
        notifyAlarm.alertAction = @"Take It";
        notifyAlarm.alertBody = [NSString stringWithFormat:@"附近有店家，距離：%d公尺",(int)floor(distance)];
        
        [app presentLocalNotificationNow:notifyAlarm];
        if (_prevShopDistance != distance) {
            _prevShopDistance=distance;
            app.applicationIconBadgeNumber=app.applicationIconBadgeNumber+1;
        }
        
    }

}

-(float)nearShopDistance{
    for (NSDictionary *suspendLocation in _shopOriginalLists) {
        CLLocation *nearShopLocation=[[CLLocation alloc]initWithLatitude:[[[suspendLocation objectForKey:@"coords"] objectAtIndex:0] doubleValue] longitude:[[[suspendLocation objectForKey:@"coords"] objectAtIndex:1] doubleValue]];
        CLLocationDistance meters =[currentLocation distanceFromLocation:nearShopLocation];
        if ((CGFloat)meters <= _defaultDistance) {
            return (CGFloat)meters;
        }
    }
    
    for (NSDictionary *suspendLocation in _govermentOriginLists) {
        CLLocation *nearShopLocation=[[CLLocation alloc]initWithLatitude:[[suspendLocation objectForKey:@"lat"]doubleValue] longitude:[[suspendLocation objectForKey:@"lon"]doubleValue]];
        CLLocationDistance meters =[currentLocation distanceFromLocation:nearShopLocation];
        if ((CGFloat)meters <=_defaultDistance) {
            return (CGFloat)meters;
        }
    }
    
    return _defaultDistance + 100.0f;
}
*/
@end
