//
//  LocationViewController.m
//  Weather
//
//  Created by Anna on 22.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "LocationViewController.h"
#import "MKMapViewExt.h"


@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation MapAnnotation



@end

@interface LocationViewController () <MKMapViewDelegate>

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MapAnnotation* annotation = [MapAnnotation new];
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(self.latCoord, self.lonCoord);
    annotation.coordinate = coords;
    
    [self.mapView addAnnotation:annotation];
    self.mapView.centerCoordinate = coords;
    
    [self.mapView setCenterCoordinate:coords zoomLevel:10 animated:YES];
    
    self.navigationController.title = self.cityName;    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Action

- (IBAction)actionCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
