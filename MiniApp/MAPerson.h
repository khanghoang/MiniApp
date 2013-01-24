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

+(MAPerson*)initWithDictionary:(NSDictionary*)dict;
-(NSArray*)getPropertiesFromPerson;

@end
