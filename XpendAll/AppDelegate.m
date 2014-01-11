//
//  AppDelegate.m
//  XpendAll
//
//  Created by BirdChiu on 13/9/30.
//  Copyright (c) 2013年 BirdChiu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GetJsonURLString.h"
#import "SVProgressHUD.h"

@implementation AppDelegate
@synthesize shopOriginalLists=_shopOriginalLists;
@synthesize govermentOriginLists=_govermentOriginLists;
@synthesize currentLocation=_currentLocation;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path =[documentsDirectory stringByAppendingPathComponent:@"updateInfo"];
    
    
    if ([fileManager fileExistsAtPath: path]) {
        NSLog(@"here");
        NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
        NSDate *lastUpdateDate = [df dateFromString: str];
        
        NSLog(@"%f",[[NSDate date] timeIntervalSinceDate:lastUpdateDate]);
        // If less than 7-day, do something  60.0f*60.0f*24.0f*7.0f
        if ([[NSDate date] timeIntervalSinceDate:lastUpdateDate] > 60.0f*60.0f*24.0f*7.0f){
            [SVProgressHUD showWithStatus:@"正在更新資料" maskType:SVProgressHUDMaskTypeClear];

            NSURL *url = [NSURL URLWithString:GetKMLDataURL];
            [self updateTakeItDB:url file:@"kmlData"];
        }
    }else{
        [SVProgressHUD showWithStatus:@"正在更新資料" maskType:SVProgressHUDMaskTypeClear];

        NSURL *url = [NSURL URLWithString:GetKMLDataURL];
        [self updateTakeItDB:url file:@"kmlData"];
        NSLog(@"no file");

    }

    
    
    UIStoryboard *main=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *mainViewController =
            (ViewController*)[main instantiateViewControllerWithIdentifier: @"ViewController"];
    
    UINavigationController *mainView = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:mainView];
    [self.window makeKeyAndVisible];
    
    [self startStandardUpdates];
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
    currentLocation =[locations lastObject];
    _currentLocation=currentLocation;

}

-(void)usingBundleData:(NSString*)fileName{
    NSError *error = nil;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filepath =[documentsDirectory stringByAppendingPathComponent:fileName];
    NSString *JSONString = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    if ([JSONString length] < 1) {
        NSString *bundleFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
        NSString *bundleJSONString = [[NSString alloc] initWithContentsOfFile:bundleFilePath encoding:NSUTF8StringEncoding error:&error];
        
        BOOL succeeded = [bundleJSONString writeToFile:filepath atomically:NO encoding:NSUTF8StringEncoding
                                                 error:&error];
        
        if (succeeded) {
            [self logUpdateInfo];
            [SVProgressHUD dismiss];

            NSLog(@"usingBundleData");
        }else{
            NSLog(@"Failed to store the file. Error = %@", error);
        }
    }
}

-(void)logUpdateInfo{
    NSError *error = nil;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path =[documentsDirectory stringByAppendingPathComponent:@"updateInfo"];
    
    NSString *date=[NSString stringWithFormat:@"%@",[NSDate date]];
    BOOL succeeded = [date writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:&error];
    
    if (succeeded) {
        [SVProgressHUD dismiss];

        NSLog(@"logging successfully");
        
    }else{
        NSLog(@"Failed to store the log. Error = %@", error);
    }

}

-(void)updateTakeItDB:(NSURL*)url file:(NSString*)fileName{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response,
                                                                                        NSData *data,
                                                                                        NSError *error) {
        if ([data length] >0 && error == nil){
            NSError *error = nil;
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *path =[documentsDirectory stringByAppendingPathComponent:fileName];
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            BOOL succeeded = [jsonString writeToFile:path atomically:NO encoding:NSUTF8StringEncoding
                                             error:&error];
            BOOL isvaild=[NSJSONSerialization isValidJSONObject:json];

            if (succeeded && isvaild) {
                NSLog(@"updated successfully");
                [self logUpdateInfo];
            }else{
                NSLog(@"Failed to store the JSON. isVaild %d , Error = %@",isvaild, error);
                [self usingBundleData:fileName];
            }
        }else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded.");
            [self usingBundleData:fileName];
        }else if (error != nil){
            NSLog(@"Error happened = %@", error);
            [self usingBundleData:fileName];
        }
    }];
}

@end
