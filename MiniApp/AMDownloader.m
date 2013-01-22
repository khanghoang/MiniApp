//
//  AMDownloader.m
//  About2359Media
//
//  Created by Trieu Khang on 1/17/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "AMDownloader.h"
#import "AFJSONRequestOperation.h"

@implementation AMDownloader

+(void)getDataFromURL:(NSString *)stringUrl success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSURL* url = [[NSURL alloc]initWithString:stringUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        success(JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        failure(error);
    }];
    
    [operation start];
}

@end
