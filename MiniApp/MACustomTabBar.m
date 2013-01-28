//
//  MACustomTabBar.m
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MACustomTabBar.h"

@implementation MACustomTabBar

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

//remove the shadow and glossy
- (void)drawRect:(CGRect)rect {

}

- (IBAction)infoSelected:(id)sender {
    NSLog(@"Info selected");
}

- (IBAction)contactSelected:(id)sender {
    NSLog(@"Contact selected");
}
@end
