//
//  WeatherViewController.h
//  Weather
//
//  Created by Anna on 19.06.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDetailsView.h"

@interface WeatherViewController : UITableViewController <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dayWeatherTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *TempCollectionView;
@property (weak, nonatomic) IBOutlet WeatherDetailsView *weatherDetailsView;

@property (strong, nonatomic) NSString* cityName;
@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSURL* cityURL;
@property (strong, nonatomic) NSNumber* cityID;


@property (weak, nonatomic) IBOutlet UILabel* cityNameLbl;

@end
