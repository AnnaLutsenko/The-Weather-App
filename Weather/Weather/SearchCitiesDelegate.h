//
//  SearchCitiesDelegate.h
//  Weather
//
//  Created by Anna on 15.05.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#ifndef SearchCitiesDelegate_h
#define SearchCitiesDelegate_h

@protocol SearchCitiesDelegate <NSObject>

@required;

-(void) citySelected:(NSDictionary*) city;

@end

#endif /* SearchCitiesDelegate_h */