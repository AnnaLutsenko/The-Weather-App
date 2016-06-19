//
//  WeatherViewController.h
//  Weather
//
//  Created by Anna on 19.06.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;

@property (strong, nonatomic) NSString* cityName;
@property (strong, nonatomic) NSURL* cityURL;

@end
