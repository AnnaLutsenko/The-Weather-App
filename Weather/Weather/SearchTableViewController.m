//
//  SearchTableViewController.m
//  Weather
//
//  Created by Anna on 14.05.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)cities {
    if (!_cities) {
        _cities = [NSMutableArray new];
    }
return _cities;
}

#pragma mark - Action

- (IBAction)actionCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.cities count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.cities objectAtIndex:indexPath.row]];
    
    return cell;
}



#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.cities removeAllObjects];
    
    CLGeocoder *geo = [CLGeocoder new];
    [geo geocodeAddressString:searchBar.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *mark in placemarks) {
            [self.cities addObject:mark.locality];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [searchBar resignFirstResponder];
    
    searchBar.text = @"";
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* selectedCity = [self.cities objectAtIndex:indexPath.row];
    
    [self.delegate citySelected:selectedCity];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}


@end
