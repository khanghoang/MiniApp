//
//  MACustomTabBarViewController.m
//  MiniApp
//
//  Created by Trieu Khang on 1/22/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MACustomTabBarViewController.h"

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
    
//    [super viewWillAppear:animated];
    
	// Do any additional setup after loading the view.
    
//    //add 2359media button
//    UIImage *buttonImage = [UIImage imageNamed:@"middle_button.png"];
//    
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
////    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    
//    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
//    if (heightDifference < 0)
//        button.center = self.tabBar.center;
//    else
//    {
//        CGPoint center = self.tabBar.center;
//        center.y = center.y - heightDifference/2.0;
//        button.center = center;
//    }
//    
//    [self.view addSubview:button];
//    
//    UIColor *background = [[UIColor alloc] initWithRed:(CGFloat)1 green:(CGFloat)0.5 blue:(CGFloat)0.2 alpha:(CGFloat)1];
//    
//    
//    self.tabBar.tintColor = background;
//    
//    self.tabBar.backgroundColor = background;
//    
//    self.tabBar.selectedImageTintColor = [UIColor whiteColor];
//    
//    //remove the white gloosy of tabbar
//    [self.tabBar setSelectionIndicatorImage:[[UIImage alloc] init]];
    
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
    
    [self.view addSubview:self.customTabBar];
}

-(void)tabSelected:(NSInteger)tabIndex
{
    NSLog(@"%d", tabIndex);
}

@end
