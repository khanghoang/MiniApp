//
//  MAAppDimensions.h
//  MiniApp
//
//  Created by Trieu Khang on 1/29/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIApplication (AppDimensions)
+(CGSize) currentSize;
+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;
@end
