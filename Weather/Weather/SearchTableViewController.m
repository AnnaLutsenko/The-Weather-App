//
//  SearchTableViewController.m
//  Weather
//
//  Created by Anna on 14.05.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "SearchTableViewController.h"
#import "AppDelegate.h"
#import "City.h"

@interface SearchTableViewController ()

@end

static NSString *kCityID = @"cityID";

@implementation SearchTableViewController

- (NSMutableArray *)filteredContentList {
    
    if (!_filteredContentList) {
        _filteredContentList = [NSMutableArray new];
    }
    
    return _filteredContentList;
}

#pragma mark - City
/*
 - (void) addCity {
 
 NSError *error = nil;
 
 AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
 
 if (!error) {
 NSLog(@"%@", [error localizedDescription]);
 }
 
 NSInteger countArray = [self.citiesArray count];
 
 for (int i = 0; i < countArray; i++) {
 City *city = [NSEntityDescription insertNewObjectForEntityForName:@"City"
 inManagedObjectContext:appDelegate.managedObjectContext];
 
 city.name = self.citiesArray[i][@"name"];
 city.country = self.citiesArray[i][@"country"];
 city.idCity = self.citiesArray[i][@"_id"];
 city.latCoord = self.citiesArray[i][@"coord"][@"lat"];
 city.lonCoord = self.citiesArray[i][@"coord"][@"lon"];
 }
 
 [appDelegate.managedObjectContext save:&error];
 }
 */

- (NSArray*) allObject {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"City"
                                                   inManagedObjectContext:appDelegate.managedObjectContext];
    
    [request setEntity:description];
    // [request setResultType:NSDictionaryResultType];
    
    NSError *requestError = nil;
    NSArray *resultArray = [appDelegate.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

- (void) printAllObject {
    NSArray *allObject = [self allObject];
    NSLog(@"COUNT = %ld", [allObject count]);
    for (City *obj in allObject) {
        // NSLog(@"City = %@;  country:%@;  idCity:%@;  lat:%@;  lot:%@;", obj.name, obj.country, obj.idCity, obj.latCoord, obj.lonCoord);
    }
}

- (void) deleteAllObject {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *allObject = [self allObject];
    
    for (City *obj in allObject) {
        [appDelegate.managedObjectContext deleteObject:obj];
    }
    [appDelegate.managedObjectContext save:nil];
}

#pragma mark - ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cities = [self allObject];
    
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
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"City"
                                                   inManagedObjectContext:appDelegate.managedObjectContext];
    
    [request setEntity:description];
    // [request setResultType:NSDictionaryResultType];
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *citiesID = [userDefaults objectForKey:kCityID];
    if (citiesID == nil) { return; }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name beginswith[c] %@) AND !(idCity IN %@)", searchString, citiesID];
    [request setPredicate:predicate];
    
    NSError *requestError = nil;
    NSArray *resultArray = [appDelegate.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }   

    if(self.contentList.count > 0) {
        [self.contentList removeAllObjects];
    }
    [self.filteredContentList addObjectsFromArray:resultArray];
   
    [self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
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
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    NSLog(@"Cancel clicked");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
    [searchBar resignFirstResponder];
}

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
    
    City *city = self.filteredContentList[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", city.name];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    City* selectedCity = [self.filteredContentList objectAtIndex:indexPath.row];
    
    NSLog(@"%@", selectedCity);
    
    [self.delegate citySelected:selectedCity];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
