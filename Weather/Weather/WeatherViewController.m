//
//  WeatherViewController.m
//  Weather
//
//  Created by Anna on 19.06.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "WeatherViewController.h"
#import "TemperatureCollectionViewCell.h"

@interface WeatherViewController ()

@property (strong, nonatomic) NSURLSession* session;

@property (strong, nonatomic) NSArray* arrayWithWeater;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadDataFromNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - UITableViewDataSource

//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    return [NSString stringWithFormat:@"Weather in %@ in %@", self.cityName, self.country];
//}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return (self.arrayWithWeater != nil) ? self.arrayWithWeater.count : 0;
//}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"Cell";
    WeatherCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WeatherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSInteger temperature = roundf([self.arrayWithWeater[indexPath.row][@"main"][@"temp"] floatValue]) - 273;
 
//     Функция round округлает значение.
//     Если мы флоат просто присвоим инту - просто обрежется дробная часть.
//     -273 это перевод из кельвинов в цельсии
 
    cell.tempLabel.text = [NSString stringWithFormat:@"%li", (long)temperature];
    
    // cell.tempLabel.text = [NSString stringWithFormat:@"%@", self.arrayWithWeater[indexPath.row][@"main"][@"temp"]];
    
    NSInteger timeinterval = [self.arrayWithWeater[indexPath.row][@"dt"] integerValue];
    NSDate * date = [[NSDate alloc] initWithTimeIntervalSince1970:timeinterval];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"dd.MM.yyyy HH:mm";
    cell.dateLabel.text = [formatter stringFromDate:date];
    
    //cell.dateLabel.text = [NSString stringWithFormat:@"%@",self.arrayWithWeater[indexPath.row][@"dt"]];
    
    return cell;
}
*/
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
    
    cell.tempLbl.text = [NSString stringWithFormat:@"%li", (long)temperature];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
