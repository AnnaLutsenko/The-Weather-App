//
//  MKMapViewExt.h
//  Weather
//
//  Created by Anna on 22.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

@property (assign, nonatomic) NSUInteger zoomLevel;

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;


@end
