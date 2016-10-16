//
//  WeatherDetailsView.h
//  Weather
//
//  Created by Anna on 16.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailsView : UIView

@property (strong, nonatomic) NSNumber* cityID;

@property (weak, nonatomic) IBOutlet UILabel *sunriseLbl;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLbl;
@property (weak, nonatomic) IBOutlet UILabel *speedWindLbl;
@property (weak, nonatomic) IBOutlet UILabel *degLbl;
@property (weak, nonatomic) IBOutlet UILabel *rainLbl;
@property (weak, nonatomic) IBOutlet UILabel *humidityLbl;
@property (weak, nonatomic) IBOutlet UIView *view;

- (void) loadWeatherDetails;
- (void) reloadData:(NSDictionary*)response;

@end
