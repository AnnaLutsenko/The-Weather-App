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

- (NSMutableArray *)filteredContentList {
    
    if (!_filteredContentList) {
        _filteredContentList = [NSMutableArray new];
    }
    
    return _filteredContentList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *Vyshkovo = @{@"_id":@688717,@"name":@"Vyshkovo",@"country":@"UA"};
    NSDictionary *Vylok = @{@"_id":@688749,@"name":@"Vylok",@"country":@"UA"};
    NSDictionary *Vylkove = @{@"_id":@688750,@"name":@"Vylkove",@"country":@"UA"};
    NSDictionary *Vvedenka = @{@"_id":@688805,@"name":@"Vvedenka",@"country":@"UA"};
    NSDictionary *Vradiyivka = @{@"_id":@688846,@"name":@"Vradiyivka",@"country":@"UA"};
    NSDictionary *Voznesenka = @{@"_id":@688865,@"name":@"Voznesenka",@"country":@"UA"};
    NSDictionary *Voykove = @{@"_id":@688904,@"name":@"Voykove",@"country":@"UA"};
    NSDictionary *Voskhod = @{@"_id":@688951,@"name":@"Voskhod",@"country":@"UA"};
    NSDictionary *Vorozhba = @{@"_id":@688961,@"name":@"Vorozhba",@"country":@"UA"};
    
    
    self.cities = [NSMutableArray arrayWithObjects:Vylok, Vylkove, Vvedenka, Vyshkovo, Vradiyivka, Voznesenka, Voykove, Voskhod, Vorozhba, nil];
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.citySearchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Action

- (IBAction)actionCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Search from Dictionary
// firstSection is array which already filled.
// contentList array for value of particular key
// filteredContentList is search array from actual array.

- (void)searchTableList {
    
    //Remove all objects first.
    [self.filteredContentList removeAllObjects];
    
    NSString *searchString = self.citySearchBar.text;
    
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"name beginswith[c] %@", searchString];
    NSArray *filteredArr = [self.cities filteredArrayUsingPredicate:filterPredicate];
    if(self.contentList.count > 0) {
        [self.contentList removeAllObjects];
    }
    [self.filteredContentList addObjectsFromArray:filteredArr];
    
    [self.tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    if ([searchBar.text length] != 0) {
        self.isSearching = YES;
    }
    else {
        self.isSearching = NO;
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d", self.isSearching);
    
    //Remove all objects first.
    [self.filteredContentList removeAllObjects];
    
    if([searchText length] != 0) {
        self.isSearching = YES;
        [self searchTableList];
        
    }
    else {
        self.isSearching = NO;
    }
    
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
/*
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
*/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (self.filteredContentList != nil) ? [self.filteredContentList count] : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.filteredContentList[indexPath.row][@"name"]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* selectedCity = [self.filteredContentList objectAtIndex:indexPath.row];
    
    NSLog(@"%@", selectedCity);
    
    [self.delegate citySelected:selectedCity];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
