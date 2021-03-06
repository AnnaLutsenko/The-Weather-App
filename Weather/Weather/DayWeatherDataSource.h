//
//  DayWeatherDataSource.h
//  Weather
//
//  Created by Anna on 15.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayWeatherDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) UITableView* dayWeatherTableView;
@property (strong, nonatomic) NSNumber* cityID;

- (void) load;


@end
