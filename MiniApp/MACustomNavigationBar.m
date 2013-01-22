//
//  MACustomNavigationBar.m
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MACustomNavigationBar.h"

@implementation MACustomNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect {
	UIImage *image = [UIImage imageNamed:@"CustomNavigation.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}



@end
