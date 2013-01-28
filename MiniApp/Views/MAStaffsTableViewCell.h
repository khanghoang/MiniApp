//
//  MAStaffsTableViewCell.h
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAPerson.h"

@protocol StaffsTableViewCell <NSObject>

- (NSNumber*)getNumberOfTheMostFamous;
- (NSNumber*)getNumberOfName:(NSString*)name;
- (id)getStaffAtIndex:(NSIndexPath*)index;

@end

@interface MAStaffsTableViewCell : UITableViewCell

@property (nonatomic, assign) NSObject<StaffsTableViewCell>* delegate;

@property (weak, nonatomic) IBOutlet UILabel *textName;

@property (weak, nonatomic) IBOutlet UILabel *textRole;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@property (weak, nonatomic) IBOutlet UIImageView *starImage;

- (MAStaffsTableViewCell*)initStaffTableViewCellWith:(MAPerson*)staff;

@end
