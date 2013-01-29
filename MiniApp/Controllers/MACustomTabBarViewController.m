//
//  MACustomTabBarViewController.m
//  MiniApp
//
//  Created by Trieu Khang on 1/22/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MACustomTabBarViewController.h"
#import "MAAppDimensions.h"

@interface MACustomTabBarViewController ()

@end

@implementation MACustomTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Hide the origin tabbar
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
        }
    }

    // Loading from xib file
    NSArray* nibObjects = [[NSBundle mainBundle] loadNibNamed:@"MACustomTabBar" owner:self options:nil];
    self.customTabBar = [nibObjects objectAtIndex:0];
    
    self.customTabBar.delegate = self;
    
    CGRect bottomLocation = self.customTabBar.frame;
    
    bottomLocation.origin.y = self.view.frame.size.height - self.customTabBar.frame.size.height;

    [self.customTabBar setFrame:bottomLocation];
    
//    self.customTabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    [self.view addSubview:self.customTabBar];
}

-(void)tabSelected:(NSInteger)tabIndex
{
    NSLog(@"%d", tabIndex);
    UIViewController *selectedVC = [self.viewControllers objectAtIndex:tabIndex];
    selectedVC.view.alpha = 0.0;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         selectedVC.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                     }];
    self.selectedIndex = tabIndex;
}

@end
