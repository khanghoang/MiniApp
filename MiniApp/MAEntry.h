//
//  MAEntry.h
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAEntry : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* link;
@property (strong, nonatomic) NSString* publishedDate;

+(MAEntry*)initWithDictionary:(NSDictionary*)dic;

@end
