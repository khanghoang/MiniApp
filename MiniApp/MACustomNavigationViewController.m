//
//  MACustomNavigationViewController.m
//  MiniApp
//
//  Created by Trieu Khang on 1/22/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MACustomNavigationViewController.h"

@interface MACustomNavigationViewController ()

@end

@implementation MACustomNavigationViewController

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
    
    UIColor *background = [[UIColor alloc] initWithRed:(CGFloat)1 green:(CGFloat)0.5 blue:(CGFloat)0.2 alpha:(CGFloat)1];
    
    self.navigationBar.backgroundColor = background;
    self.navigationBar.tintColor = background;
    self.navigationBar.shadowImage = nil;
    
    UIGraphicsBeginImageContext(CGSizeMake(320, 40));
    [background setFill];
    UIRectFill(CGRectMake(0, 0, 320, 40));
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
