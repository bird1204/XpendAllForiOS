//
//  Annotation.h
//  MAPTEST
//
//  Created by 偉誠 藍 on 12/5/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (nonatomic,strong)NSNumber *type;

@property (assign) NSInteger tag;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c;
-(id)initWithCoordinate:(CLLocationCoordinate2D)c theCoordinateTitle:(NSString*)title andSubtitle:(NSString*)subtitle;
@end
