//
//  MACustomTabBar.h
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MACustomTabBarDelegate <NSObject>

-(void)tabSelected:(NSInteger)tabIndex;

@end

@interface MACustomTabBar : UIView

@property (nonatomic, assign) NSObject<MACustomTabBarDelegate>* delegate;

@property (weak, nonatomic) IBOutlet UIButton *contactButton;

@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end
