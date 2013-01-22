//
//  MAPerson.m
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAPerson.h"

@implementation MAPerson

+(MAPerson*)initWithDictionary:(NSDictionary*)dic
{
    MAPerson* person = [[MAPerson alloc]init];
    
    person.name = [dic valueForKey:@"name"];
    person.role = [dic valueForKey:@"role"];
    
    return person;
}

-(NSArray*)getPropertiesFromPerson
{
    return [[NSArray alloc]initWithObjects:@"name", @"role" , nil];
}

@end
