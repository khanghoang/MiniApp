//
//  MAStaffsTableViewCell.m
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAStaffsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation MAStaffsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (MAStaffsTableViewCell*)initStaffTableViewCellWith:(MAPerson*)staff
{
    // Configure the cell...
    self.textName.text = staff.name;
    self.textName.textColor = [UIColor blackColor];
    self.textRole.text = staff.role;
    
    [self.avatarImage setImageWithURL:[NSURL URLWithString:(NSString*)staff.imageUrl] placeholderImage:[UIImage imageNamed:@"icon_profile.png"]];
    
    self.avatarImage.layer.cornerRadius = 30;
    self.avatarImage.clipsToBounds = YES;
    
    self.avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImage.layer.borderWidth = 3;
    
    self.starImage.hidden = YES;
    
//    if([[self.delegate getNumberOfTheMostFamous] integerValue] == [[self.delegate getNumberOfName:staff.name] integerValue])
//    {
////        self.textName.textColor = [UIColor orangeColor];
//        self.starImage.hidden = NO;
//    }
    
    // Male and Female
    if([[staff.gender uppercaseString] isEqualToString:@"MALE"])
        self.textName.textColor = [UIColor orangeColor];
    else
        self.textName.textColor = [UIColor blueColor];

    return self;
}

@end
