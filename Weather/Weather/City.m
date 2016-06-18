//
//  City.m
//  Weather
//
//  Created by Anna on 18.06.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "City.h"

@implementation City

- (id) initWithNameAndId:(NSString*) name idCity:(NSString*) idCity {
    
    self = [super init];
    if (self) {
        self.nameCity = name;
        self.idCity = idCity;
        NSString* url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/city?id=%@&APPID=edc60874e635ded94b5ea2f4101774bc", idCity];
        self.cityURL = [NSURL URLWithString:url];
    }
    return self;
}

@end
