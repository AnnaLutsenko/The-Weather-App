//
//  City.h
//  Weather
//
//  Created by Anna on 18.06.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject


@property (strong, nonatomic) NSString* nameCity;
@property (strong, nonatomic) NSString* idCity;
@property (strong, nonatomic) NSURL* cityURL;

- (id) initWithNameAndId:(NSString*) name idCity:(NSString*) idCity;

@end
