//
//  MAPerson.h
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAPerson : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* role;
@property (strong, nonatomic) NSString* imageUrl;
@property (strong, nonatomic) NSString* mail;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* like;
@property (strong, nonatomic) NSString* dislike;
@property (strong, nonatomic) NSString* gender;

+(MAPerson*)initWithDictionary:(NSDictionary*)dict;
-(NSArray*)getPropertiesFromPerson;

@end
