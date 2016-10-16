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

@interface CitiesTableViewController ()

@end

static NSString *kCityID = @"cityID";

@implementation CitiesTableViewController

- (NSMutableArray*)cities {
    
    if (!_cities) {
        _cities = [NSMutableArray new];
    }
    return _cities;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCitiesArray];
    
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Save and Load

- (void) saveCitiesArray {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *idArray = [[NSMutableArray alloc] init];
    
    for (City* obj in self.cities) {
        [idArray addObject:obj.idCity];
    }
    
    [userDefaults setObject:idArray forKey:kCityID];
    
    [userDefaults synchronize];
}

- (void) loadCitiesArray {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *citiesID = [userDefaults objectForKey:kCityID];
    if (citiesID == nil) {
        return;
    }
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"City"
                                                   inManagedObjectContext:appDelegate.managedObjectContext];
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idCity IN %@", citiesID];
    [request setPredicate:predicate];
    
    NSError *requestError = nil;
    NSArray *idArray = [appDelegate.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
      NSLog(@"%@", [requestError localizedDescription]);
    }
      
    [self.cities addObjectsFromArray:idArray];
}


#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
    
    return [NSString stringWithFormat:@"Selected City"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.cities count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    City* city = self.cities[indexPath.row];
    
    cell.textLabel.text = city.name;
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.cities removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
   
    [self saveCitiesArray];
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
    
    City* selectedCity = [self.cities objectAtIndex:indexPath.row];
    vc.cityURL = selectedCity.cityURL;
    vc.cityName = selectedCity.name;
    vc.country = selectedCity.country;
    vc.cityID = selectedCity.idCity;
    
}

#pragma mark - SearchCitiesDelegate

-(void) citySelected:(City*) city {
    
    [self.cities addObject:city];
    
    [self saveCitiesArray];
    
    [self.tableView reloadData];
}

@end
