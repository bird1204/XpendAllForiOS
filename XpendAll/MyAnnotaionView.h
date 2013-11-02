//
//  MyAnnotaionView.h
//  P1107Map
//
//  Created by BirdChiu on 12/11/9.
//  Copyright (c) 2012年 BirdChiu. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface MyAnnotaionView : MKAnnotationView
-(id)initWithAnnotation:(Annotation<MKAnnotation>*)annotation reuseIdentifier:(NSString *)reuseIdentifier;
@end
