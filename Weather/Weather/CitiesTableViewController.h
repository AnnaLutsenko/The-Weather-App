//
//  CitiesTableViewController.h
//  Weather
//
//  Created by Anna on 14.05.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableViewController.h"

@interface CitiesTableViewController : UITableViewController <SearchCitiesDelegate>

@property (strong, nonatomic) NSMutableArray* cities;

@end
