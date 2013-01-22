//
//  MAStaffsTableViewCell.h
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAStaffsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textName;

@property (weak, nonatomic) IBOutlet UILabel *textRole;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *starImage;

@end
