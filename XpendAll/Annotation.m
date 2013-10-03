//
//  Annotation.m
//  MAPTEST
//
//  Created by 偉誠 藍 on 12/5/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;
@synthesize tag;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c{
    if (self = [super init]) {
        self.coordinate = c;
    }
    return self;
}
-(id)initWithCoordinate:(CLLocationCoordinate2D)c theCoordinateTitle:(NSString*)theTitle andSubtitle:(NSString*)theSubtitle{
    self=[super init];
    [self setCoordinate:c];
    self.title=theTitle;
    self.subtitle=theSubtitle;
    return self;
}
@end
