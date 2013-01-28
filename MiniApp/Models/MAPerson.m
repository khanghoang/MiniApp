//
//  MAPerson.m
//  MiniApp
//
//  Created by ; Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAPerson.h"

@implementation MAPerson

+(MAPerson*)initWithDictionary:(NSDictionary*)dic
{
    MAPerson* person = [[MAPerson alloc]init];
    
    person.name = [dic valueForKey:@"name"];
    person.role = [dic valueForKey:@"role"];
    person.imageUrl = [dic valueForKey:@"image"];
    person.mail = [dic valueForKey:@"userName"];
    person.phone = [dic valueForKey:@"contact"];
    person.like = [dic valueForKey:@"like"];
    person.dislike = [dic valueForKey:@"dislike"];
    person.gender = [dic valueForKey:@"gender"];
    
    return person;
}

-(NSArray*)getPropertiesFromPerson
{
    return [[NSArray alloc]initWithObjects:@"name", @"role" , @"image", @"userName", nil];
}

@end
