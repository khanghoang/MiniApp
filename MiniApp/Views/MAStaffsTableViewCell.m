//
//  MAStaffsTableViewCell.m
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAStaffsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MAStaffsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *textName;

@property (weak, nonatomic) IBOutlet UILabel *textRole;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@property (weak, nonatomic) IBOutlet UIImageView *starImage;

@end

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

- (MAStaffsTableViewCell*)initStaffTableViewCellWith:(MAPerson*)staff isOdd:(BOOL)isOdd
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
    
    if([[self.delegate getNumberOfTheMostFamous] integerValue] == [[self.delegate getNumberOfName:staff.name] integerValue])
    {
//        self.textName.textColor = [UIColor orangeColor];
        self.starImage.hidden = NO;
    }
    
    // Male and Female
    if([[staff.gender uppercaseString] isEqualToString:@"MALE"])
        self.textName.textColor = [UIColor orangeColor];
    else
        self.textName.textColor = [UIColor blueColor];
    
    if(isOdd)
        self.contentView.backgroundColor = [UIColor colorWithRed:(CGFloat)1 green:(CGFloat)0.5 blue:(CGFloat)0.2 alpha:(CGFloat)0.1];

    return self;
}

@end
