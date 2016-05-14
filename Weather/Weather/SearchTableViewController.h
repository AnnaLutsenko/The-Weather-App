//
//  SearchTableViewController.h
//  Weather
//
//  Created by Anna on 14.05.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SearchCitiesDelegate.h"

@interface SearchTableViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray* cities;
@property (weak, nonatomic) id <SearchCitiesDelegate> delegate;

- (IBAction)actionCancel:(id)sender;

@end
