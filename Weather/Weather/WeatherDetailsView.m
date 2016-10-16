
//
//  WeatherDetailsView.m
//  Weather
//
//  Created by Anna on 16.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "WeatherDetailsView.h"

@interface WeatherDetailsView()

@property (strong, nonatomic) NSURLSession* session;

@end

@implementation WeatherDetailsView

- (NSURLSession*) session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _session;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addCotentView];
}

- (void)addCotentView {
    if ([[NSBundle mainBundle] loadNibNamed:@"WeatherDetailsView" owner:self options:nil]) {
        self.view.frame = self.bounds;
        [self addSubview:self.view];
    }
}

- (void) loadWeatherDetails {
    
    NSString *urla = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?id=%ld&APPID=edc60874e635ded94b5ea2f4101774bc", [self.cityID integerValue]];
    
    NSURL *url =  [NSURL URLWithString:urla];
    
    [[self.session dataTaskWithURL:url
                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     if (error) {
                         NSLog(@"ERROR!!!%@", error);
                     } else {
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:nil];
                         
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [self reloadData:dic];
                         });
                         
                     }
                     
                 }] resume];
}

- (void) reloadData:(NSDictionary *)response {
    
    NSInteger timeintervalSunrise = [response[@"sys"][@"sunrise"] integerValue];
    NSDate * dateSunrise = [[NSDate alloc] initWithTimeIntervalSince1970:timeintervalSunrise];
    
    NSInteger timeintervalSunset = [response[@"sys"][@"sunset"] integerValue];
    NSDate * dateSunset = [[NSDate alloc] initWithTimeIntervalSince1970:timeintervalSunset];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH:mm";
    
    self.sunriseLbl.text = [formatter stringFromDate:dateSunrise];
    self.sunsetLbl.text = [formatter stringFromDate:dateSunset];
    
    
    self.speedWindLbl.text = [NSString stringWithFormat:@"%li m/s", [response[@"wind"][@"speed"] integerValue]];
    
    NSInteger deg = [response[@"wind"][@"deg"] integerValue];
    self.degLbl.text = [NSString stringWithFormat:@"%@ (%li°)", [self degToWorldSide:deg],deg];
    
    self.rainLbl.text = [NSString stringWithFormat:@"%li \%%", [response[@"rain"][@"3h"] integerValue]];
    self.humidityLbl.text = [NSString stringWithFormat:@"%li \%%", [response[@"main"][@"humidity"] integerValue]];

    
}

- (NSString*) degToWorldSide:(float) deg {
    
    NSArray* worldSide = @[@"N", @"NNE", @"NE", @"ENE",
                           @"E", @"ESE", @"SE", @"SSE",
                           @"S", @"SSW", @"SW", @"WSW",
                           @"W", @"WNW", @"NW",@"NNW"];
    
    NSInteger side = deg/22.5;
    
    return worldSide[side];
}

@end
