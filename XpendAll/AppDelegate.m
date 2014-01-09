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


@implementation AppDelegate
@synthesize shopOriginalLists=_shopOriginalLists;
@synthesize govermentOriginLists=_govermentOriginLists;
@synthesize currentLocation=_currentLocation;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSURL *url = [NSURL URLWithString:GetKMLDataURL];
    [self updateTakeItDB:url file:@"kmlData"];
    
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
            BOOL succeeded = [jsonString writeToFile:path atomically:NO encoding:NSUTF8StringEncoding
                                             error:&error];
            if (succeeded) {
                NSLog(@"Successfully");
            }else{
                NSLog(@"Failed to store the file. Error = %@", error);
            }
        }
        else if ([data length] == 0 && error == nil){ NSLog(@"Nothing was downloaded.");}
        else if (error != nil){ NSLog(@"Error happened = %@", error); }
    }];
}

@end
