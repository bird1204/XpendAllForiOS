//
//  UILabel+AutoFrame.m
//  MyselfProject
//
//  Created by Celtic．F．Tis on 13/6/18.
//  Copyright (c) 2013年 Kyle Tethys. All rights reserved.
//

#import "UILabel+AutoFrame.h"

@implementation UILabel (AutoFrame)
-(id)setTextWithAutoFrame:(NSString*)str{
    if (self) {


        [self setNumberOfLines:0];
        self.lineBreakMode = NSLineBreakByWordWrapping;

        CGSize size = CGSizeMake(100,2000);//設定該lable最大範圍

        CGSize labelsize = [str sizeWithFont:self.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        
        CGRect labelOriginFrame=[self frame];
        labelOriginFrame.size.width=labelsize.width;
        labelOriginFrame.size.height=labelsize.height;
        [self setFrame:labelOriginFrame];
                [self setText:str];
    }

    return self;

}
@end
