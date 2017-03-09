//
//  WeatherDataProvider.h
//  Weather
//
//  Created by Anna on 23.02.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface WeatherDataProvider : NSObject

@property (strong, nonatomic) NSMutableArray* cities;

+ (id)shared;

- (NSArray*) searchCity:(NSString*) nameCity;
- (City*) cityWithIndex:(NSInteger) indexCity;

- (void) saveCitiesArray;

- (void)deleteCityWithIndex:(NSInteger) index;
- (void)addCity:(City *) city;

@end
