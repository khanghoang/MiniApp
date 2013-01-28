//
//  MAEntry.m
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAEntry.h"

@implementation MAEntry

+(MAEntry*)initWithDictionary:(NSDictionary*)dic
{
    MAEntry* entry = [[MAEntry alloc]init];
    
    entry.title = [dic valueForKey:@"name"];
    entry.title = [dic valueForKey:@"link"];
    entry.title = [dic valueForKey:@"publishedDate"];
    
    return entry;
}

@end
