//
//  LocationViewController.h
//  Weather
//
//  Created by Anna on 22.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface LocationViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView* mapView;

@property (strong, nonatomic) NSString* cityName;
@property (assign, nonatomic) double lonCoord;
@property (assign, nonatomic) double latCoord;

@end
