//
//  DayWeatherDataSource.m
//  Weather
//
//  Created by Anna on 15.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "DayWeatherDataSource.h"
#import "DayCellTableViewCell.h"

@interface DayWeatherDataSource()

@property (strong, nonatomic) NSURLSession* session;
@property (strong, nonatomic) NSArray* arrayWithWeater;

@end

@implementation DayWeatherDataSource

- (NSURLSession*) session {
    if (!_session) {
       _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _session;
}

- (void) load {
    
    NSString *urla = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?id=%ld&APPID=edc60874e635ded94b5ea2f4101774bc", [self.cityID integerValue]];
    
    NSURL *url =  [NSURL URLWithString:urla];
    
    [[self.session dataTaskWithURL:url
                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                     
                     if (error) {
                         NSLog(@"ERROR!!!%@", error);
                     } else {
                         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:nil];
                         self.arrayWithWeater = dic[@"list"];
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [self.dayWeatherTableView reloadData];
                         });
                         
                     }
                     
                 }] resume];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"dayCell";
    DayCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[DayCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.dayTimeLbl.text = [NSString stringWithFormat:@"%li", (long)roundf([self.arrayWithWeater[indexPath.row][@"temp"][@"max"] floatValue]) - 273];
    cell.nightTimeLbl.text = [NSString stringWithFormat:@"%li", (long)(roundf([self.arrayWithWeater[indexPath.row][@"temp"][@"min"] floatValue]) - 273)];

    
    NSInteger timeinterval = [self.arrayWithWeater[indexPath.row][@"dt"] integerValue];
    NSDate * date = [[NSDate alloc] initWithTimeIntervalSince1970:timeinterval];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"EEEE";
    cell.dayLabel.text = [formatter stringFromDate:date];
    
    return cell;
}

@end
