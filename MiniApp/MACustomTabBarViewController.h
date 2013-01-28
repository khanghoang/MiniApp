//
//  MACustomTabBarViewController.h
//  MiniApp
//
//  Created by Trieu Khang on 1/22/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MACustomTabBar.h"

@interface MACustomTabBarViewController : UITabBarController <MACustomTabBarDelegate>

@property (weak, nonatomic) IBOutlet MACustomTabBar *tabBar;

@end
