//
//  WeatherViewController.m
//  Weather
//
//  Created by Anna on 19.06.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "WeatherViewController.h"
#import "TemperatureCollectionViewCell.h"
#import "DayWeatherDataSource.h"
#import "LocationViewController.h"

@interface WeatherViewController ()

@property (strong, nonatomic) NSURLSession* session;

@property (strong, nonatomic) NSArray* arrayWithWeater;

@property (strong, nonatomic) DayWeatherDataSource* dayWeatherDataSource;
@property (strong, nonatomic) LocationViewController* locationVC;

@end

@implementation WeatherViewController

- (DayWeatherDataSource*) dayWeatherDataSource {
    if (!_dayWeatherDataSource) {
        _dayWeatherDataSource = [DayWeatherDataSource new];
        _dayWeatherDataSource.dayWeatherTableView = self.dayWeatherTableView;
        _dayWeatherDataSource.dayWeatherTableView.dataSource = _dayWeatherDataSource;
        _dayWeatherDataSource.cityID = self.cityID;
    }
    return _dayWeatherDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cityNameLbl.text = self.cityName;
    self.title = self.country;
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [self.dayWeatherDataSource load];
    self.weatherDetailsView.cityID = self.cityID;
    [self.weatherDetailsView loadWeatherDetails];
    
    
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadDataFromNet];
}

#pragma mark - NSURLSession & NSJSONSerialization

- (void) reloadDataFromNet {
    
    NSURL *url = self.cityURL;
    
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
                             [self.TempCollectionView reloadData];
                         });
                         
                     }
                     
                 }] resume];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (self.arrayWithWeater != nil) ? self.arrayWithWeater.count : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"Cell";
    
    TemperatureCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSInteger temperature = roundf([self.arrayWithWeater[indexPath.item][@"main"][@"temp"] floatValue]) - 273;
    
    //     Функция round округлает значение.
    //     Если мы флоат просто присвоим инту - просто обрежется дробная часть.
    //     -273 это перевод из кельвинов в цельсии
    
    cell.tempLbl.text = [NSString stringWithFormat:@"%li°", (long)temperature];
    
    // cell.tempLabel.text = [NSString stringWithFormat:@"%@", self.arrayWithWeater[indexPath.row][@"main"][@"temp"]];
    
    NSInteger timeinterval = [self.arrayWithWeater[indexPath.item][@"dt"] integerValue];
    NSDate * date = [[NSDate alloc] initWithTimeIntervalSince1970:timeinterval];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"dd.MM.yyyy\nHH:mm";
    cell.dateLbl.text = [formatter stringFromDate:date];
    
    //cell.dateLabel.text = [NSString stringWithFormat:@"%@",self.arrayWithWeater[indexPath.row][@"dt"]];
        
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController* nc = (UINavigationController*)segue.destinationViewController;
    LocationViewController* locationVC = (LocationViewController*)nc.viewControllers[0];
    
    locationVC.latCoord = [self.city latCoordValue];
    locationVC.lonCoord = [self.city lonCoordValue];
    locationVC.title = [self.city name];
    
}

@end
