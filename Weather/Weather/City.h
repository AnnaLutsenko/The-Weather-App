//
//  City.h
//  Weather
//
//  Created by Anna on 18.06.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject <NSCoding>

@property (strong, nonatomic) NSString* nameCity;
@property (assign, nonatomic) NSInteger idCity;
@property (strong, nonatomic) NSURL* cityURL;

- (id) initWithNameAndId:(NSString*) name idCity:(NSInteger) idCity;

@end
