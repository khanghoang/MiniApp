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

- (void)resetBackgroundButton
{
    [self.infoButton setImage:[UIImage imageNamed:@"icon_info.png"] forState:UIControlStateNormal];
    [self.contactButton setImage:[UIImage imageNamed:@"icon_contacts.png"] forState:UIControlStateNormal];
}

- (IBAction)infoSelected:(id)sender {
    NSLog(@"Info selected");
    [self resetBackgroundButton];
    [self.delegate tabSelected:1];    
    [self.infoButton setImage:[UIImage imageNamed:@"icon_info_selected.png"] forState:UIControlStateNormal];
}

- (IBAction)contactSelected:(id)sender {
    NSLog(@"Contact selected");
    [self resetBackgroundButton];
    [self.delegate tabSelected:0];
    [self.contactButton setImage:[UIImage imageNamed:@"icon_contacts_selected.png"] forState:UIControlStateNormal];
}
@end
