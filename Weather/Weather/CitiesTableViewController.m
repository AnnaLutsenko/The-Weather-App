//
//  CitiesTableViewController.m
//  Weather
//
//  Created by Anna on 14.05.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "SearchTableViewController.h"
#import "WeatherViewController.h"
#import "City.h"
#import "AppDelegate.h"
#import "WeatherDataProvider.h"

@interface CitiesTableViewController ()

@end

static NSString *kCityID = @"cityID";

@implementation CitiesTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView reloadData];
    
}


#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
    
    return [NSString stringWithFormat:@"Selected City"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[WeatherDataProvider shared] cities] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    City* city = [[WeatherDataProvider shared] cityWithIndex:indexPath.row];
//    [[WeatherDataProvider shared] cities][indexPath.row];
    
    cell.textLabel.text = city.name;
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [[[WeatherDataProvider shared] cities] removeObjectAtIndex:indexPath.row];
    
    [[WeatherDataProvider shared] deleteCityWithIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        if ([nc.viewControllers[0] isKindOfClass:[SearchTableViewController class]]) {
            ((SearchTableViewController *)nc.viewControllers[0]).delegate = self;
        }
    }
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    WeatherViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    City* selectedCity = [[[WeatherDataProvider shared] cities] objectAtIndex:indexPath.row];
    vc.cityURL = selectedCity.cityURL;
    vc.cityName = selectedCity.name;
    vc.country = selectedCity.country;
    vc.cityID = selectedCity.idCity;
    
    vc.city = selectedCity;    
}

#pragma mark - SearchCitiesDelegate

-(void) citySelected:(City*) city {
    
//    [[[WeatherDataProvider shared] cities] addObject:city];
    
    [[WeatherDataProvider shared] addCity:city];
    
    [self.tableView reloadData];
}

@end
