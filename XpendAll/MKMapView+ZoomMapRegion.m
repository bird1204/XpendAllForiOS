//
//  MKMapView+ZoomMapRegion.m
//  P1107Map
//
//  Created by BirdChiu on 12/11/9.
//  Copyright (c) 2012年 BirdChiu. All rights reserved.
//

#import "MKMapView+ZoomMapRegion.h"
#import "Annotation.h"
@implementation MKMapView(ZoomMapRegion)

//自動調整畫面到所有標記點都出現
-(void)zoomToFitMapAnnotations{
    if([self.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(Annotation* annotation in self.annotations)
    {
        //if (annotation != (Annotation*)mapView.userLocation) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
        //}
        
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    
    region = [self regionThatFits:region];
    [self setRegion:region animated:YES];
}

@end
