//
//  MAAppDimensions.m
//  MiniApp
//
//  Created by Trieu Khang on 1/29/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAAppDimensions.h"

@implementation UIApplication (AppDimensions)
+(CGSize) currentSize
{
    return [UIApplication sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        size = CGSizeMake(size.height, size.width);
    }
    if (application.statusBarHidden == NO)
    {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    return size;
}
@end
