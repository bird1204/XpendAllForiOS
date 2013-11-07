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
            NSDictionary *userInfo=[[NSDictionary alloc]initWithObjectsAndKeys:@"愛呷麵",@"title",@"100台北市中正區汀州路三段269號",@"address",coords_1,@"coords",@"(02)2366-1992",@"phoneNumber",@"\n\t\t\t\t\t\u25ce\u53f0\u5317\u5e02\u4e2d\u6b63\u5340 \u611b\u5477\u9762 \u611b\u5fc3\u5f85\u7528\u9eb5\n100\u53f0\u5317\u5e02\u4e2d\u6b63\u5340\u6c40\u5dde\u8def\u4e09\u6bb5269\u865f\n\u96fb\u8a71(02)2366-1992\n\u71df\u696d\u6642\u959311:30 - 22:30\n\u7db2\u7ad9http:\/\/goo.gl\/bX7Hsj\n\n\u611b\u5477\u9762\u63d0\u4f9b\u514d\u8cbb\u611b\u5fc3\u5f85\u7528\u9eb5\u7d66\u9700\u8981\u5e6b\u5fd9\u7684\u670b\u53cb\u4f86\u5e97\u53d6\u7528\uff0c\u8acb\u544a\u77e5\u60a8\u5468\u906d\u9700\u8981\u7684\u670b\u53cb\uff0c\u9019\u88e1\u6709\u71b1\u9a30\u9a30\u7684\u611b\u5fc3\u5f85\u7528\u9910\uff1b\u656c\u9080\u5927\u5bb6\u4e00\u8d77\u52a0\u5165\u611b\u5fc3\u5f85\u7528\u7684\u884c\u5217\uff0c\u70ba\u793e\u6703\u63d0\u4f9b\u4e00\u5206\u6eab\u6696\u3002\uff08\u7531\u5373\u65e5\u8d77\u81f32013\/12\/25\uff0c\u53ea\u8981\u60a8 \u6bcf\u652f\u6301\u4e8c\u7897\u611b\u5fc3\u5f85\u7528\u9eb5\uff0c\u611b\u5477\u9762\u5c31\u6703\u52a0\u78bc\u7528\u60a8\u7684\u540d\u7fa9\u6350\u8d08\u4e00\u7897\uff09\n\n\u6b61\u8fce\u60a8\u52a0\u5165\u611b\u5fc3\u5e97\u5bb6\u3001\u7fa9\u5de5\u7684\u884c\u5217\uff0c\n\u4e00\u8d77\u70ba\u793e\u6703\u76e1\u5fae\u8584\u4e4b\u529b\u3002\u611f\u8b1d\u5927\u5bb6\u7684\u611b\u5fc3\n\u8acb\u806f\u7d61\u611b\u5fc3\u5f85\u7528 \u516c\u76ca\u5e73\u53f0\nhttps:\/\/www.facebook.com\/Suspended.Love\n\u96fb\u90f5 suspendedfoods@gmail.com\t\t\t\t",@"description",nil];
            notifyAlarm_1.timeZone = [NSTimeZone defaultTimeZone];
            notifyAlarm_1.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
            notifyAlarm_1.alertAction = @"Take It";
            notifyAlarm_1.alertBody = [NSString stringWithFormat:@"%@的愛心在你身邊，距離：%d公尺",[userInfo objectForKey:@"title"],700];
            notifyAlarm_1.userInfo=userInfo;
            
            NSArray *coords_2=[[NSArray alloc]initWithObjects:@"25.024511",@"121.529091",nil];
            UILocalNotification* notifyAlarm_2 = [[UILocalNotification alloc] init];
            NSDictionary *userInfo_2=[[NSDictionary alloc]initWithObjectsAndKeys:@"阿諾可麗餅",@"title",@"106台北市大安區師大路39巷20號",@"address",coords_2,@"coords",@"(02)2396-5151",@"phoneNumber",@"\n\t\t\t\t\t\u25ce\u53f0\u5317\u5e02\u5927\u5b89\u5340 \u963f\u8afe\u53ef\u9e97\u9905 \u611b\u5fc3\u9ede\u5fc3\n106\u53f0\u5317\u5e02\u5927\u5b89\u5340\u5e2b\u5927\u8def39\u5df720\u865f\t\n\u96fb\u8a71(02)2396-5151\u9127\u5c0f\u59d0\t\n\u71df\u696d\u6642\u959312:00 ~ 01:00\t\n\u7db2\u7ad9http:\/\/www.facebook.com\/arnorcrepestaiwan\n\n\u963f\u8afe\u53ef\u9e97\u9905\u63d0\u4f9b\u611b\u5fc3\u9ede\u5fc3\u7d66\u9700\u8981\u7684\u670b\u53cb\u3002\n\u611f\u8b1d\u5f85\u7528\u9910\u9ede,\u53f0\u7063 \u8cc7\u6599\u63d0\u4f9b\n\n\u6b61\u8fce\u60a8\u52a0\u5165\u611b\u5fc3\u5e97\u5bb6\u3001\u7fa9\u5de5\u7684\u884c\u5217\uff0c\n\u4e00\u8d77\u70ba\u793e\u6703\u76e1\u5fae\u8584\u4e4b\u529b\u3002\n\u611f\u8b1d\u5927\u5bb6\u7684\u611b\u5fc3\uff1b\u8acb\u806f\u7d61\u611b\u5fc3\u5f85\u7528 \u516c\u76ca\u5e73\u53f0\nwww.facebook.com\/Suspended.Love\n\u96fb\u90f5 suspendedfoods@gmail.com\t\t\t\t",@"description",nil];
            notifyAlarm_2.timeZone = [NSTimeZone defaultTimeZone];
            notifyAlarm_2.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
            notifyAlarm_2.alertAction = @"Take It";
            notifyAlarm_2.alertBody = [NSString stringWithFormat:@"%@的愛心在你身邊，距離：%d公尺",[userInfo_2 objectForKey:@"title"],1100];
            notifyAlarm_2.userInfo=userInfo_2;
            
            NSArray *coords_3=[[NSArray alloc]initWithObjects:@"25.025069",@"121.523418",nil];
            UILocalNotification* notifyAlarm_3 = [[UILocalNotification alloc] init];
            NSDictionary *userInfo_3=[[NSDictionary alloc]initWithObjectsAndKeys:@"JSP呷尚寶早餐店",@"title",@"100台北市中正區南昌路2段205號",@"address",coords_3,@"coords",@"(02)2366-1992",@"phoneNumber",@"\n\t\t\t\t\t\u25ce\u53f0\u5317\u5e02\u4e2d\u6b63\u5340 JSP\u5477\u5c1a\u5bf6\u65e9\u9910\u5e97(\u5357\u660c\u5e97\uff09\u611b\u5fc3\u65e9\u9910\n100\u53f0\u7063\u53f0\u5317\u5e02\u4e2d\u6b63\u5340\u5357\u660c\u8def\u4e8c\u6bb5205\u865f\n\u96fb\u8a71(02) 2368-1033\n\u71df\u696d\u6642\u9593\uff1a\u9031\u4e00\uff5e\u4e94: 5:30 - 13:00\n\u9031\u516d\uff5e\u9031\u65e5: 6:00 - 13:00\n\u7db2\u7ad9http:\/\/goo.gl\/AApueN\n\n\u611b\u5fc3\u5f85\u7528\u5167\u5bb9\u6b61\u8fce\u89aa\u81ea\u73fe\u5834\u6d3d\u8a62\u6797\u5c0f\u59d0\n\u611f\u8b1d \u5f85\u7528\u9910\u9ede,\u53f0\u7063 \u8cc7\u6599\u63d0\u4f9b\n\n\u6b61\u8fce\u60a8\u52a0\u5165\u611b\u5fc3\u5e97\u5bb6\u3001\u7fa9\u5de5\u7684\u884c\u5217\uff0c\n\u4e00\u8d77\u70ba\u793e\u6703\u76e1\u5fae\u8584\u4e4b\u529b\u3002\n\u611f\u8b1d\u5927\u5bb6\u7684\u611b\u5fc3\uff1b\u8acb\u806f\u7d61\u611b\u5fc3\u5f85\u7528 \u516c\u76ca\u5e73\u53f0\nhttps:\/\/www.facebook.com\/Suspended.Love\n\u96fb\u90f5 suspendedfoods@gmail.com\t\t\t\t",@"description",nil];
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
