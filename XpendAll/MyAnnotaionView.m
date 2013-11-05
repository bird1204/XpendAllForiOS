//
//  MyAnnotaionView.m
//  P1107Map
//
//  Created by BirdChiu on 12/11/9.
//  Copyright (c) 2012年 BirdChiu. All rights reserved.
//

#import "MyAnnotaionView.h"
#import "Annotation.h"

@implementation MyAnnotaionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithAnnotation:(Annotation<MKAnnotation>*)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImage *imga;
        switch ([[annotation type] intValue]) {
            case  0:
                imga=[UIImage imageNamed:@"AnnotationImage.png"];
                break;
            case  1:
                imga=[UIImage imageNamed:@"plate.png"];
                break;
            default:
                imga=[UIImage imageNamed:@"gov_map.png"];
                break;
        }
        
        [self setFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
        
        UIImageView *img=[[UIImageView alloc] initWithImage:imga];
        [img setFrame:self.bounds];
        [self addSubview:img];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
