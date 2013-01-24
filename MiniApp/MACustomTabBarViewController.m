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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //add 2359media button
    UIImage *buttonImage = [UIImage imageNamed:@"middle_button.png"];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    [self.view addSubview:button];
    
    UIColor *background = [[UIColor alloc] initWithRed:(CGFloat)1 green:(CGFloat)0.5 blue:(CGFloat)0.2 alpha:(CGFloat)1];
    
    
    self.tabBar.tintColor = background;
    
    self.tabBar.backgroundColor = background;
    
    self.tabBar.selectedImageTintColor = [UIColor whiteColor];
    
    //remove the white gloosy of tabbar
    [self.tabBar setSelectionIndicatorImage:[[UIImage alloc] init]];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
