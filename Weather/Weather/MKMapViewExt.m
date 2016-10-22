//
//  MKMapViewExt.m
//  Weather
//
//  Created by Anna on 22.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "MKMapViewExt.h"


@implementation MKMapView (ZoomLevel)

- (void)setZoomLevel:(NSUInteger)zoomLevel {
    [self setCenterCoordinate:self.centerCoordinate zoomLevel:zoomLevel animated:NO];
}

- (NSUInteger)zoomLevel {
    return log2(360 * ((self.frame.size.width/256) / self.region.span.longitudeDelta)) + 1;
}

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated {
    MKCoordinateSpan span = MKCoordinateSpanMake(0, 360/pow(2, zoomLevel)*self.frame.size.width/256);
    [self setRegion:MKCoordinateRegionMake(centerCoordinate, span) animated:animated];
}

@end
