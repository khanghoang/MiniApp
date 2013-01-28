//
//  AMDownloader.h
//  About2359Media
//
//  Created by Trieu Khang on 1/17/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock) (id JSON);
typedef void (^FailureBlock) (NSError *error);

@interface AMDownloader : NSObject

@property (strong, nonatomic) NSMutableData  *receiveData;

+(void)getDataFromURL:(NSString *)url success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
