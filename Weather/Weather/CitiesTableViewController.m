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

@interface CitiesTableViewController ()

@end

static NSString *kCitiesArray = @"cities";

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
    
    if (self.cities.count == 0) {
        City* lviv = [[City alloc] initWithNameAndId:@"Lviv" idCity:702550];
        City* kiev = [[City alloc] initWithNameAndId:@"Kiev" idCity:703448];
        City* dnipropetrovsk = [[City alloc] initWithNameAndId:@"Dnipropetrovsk" idCity:709930];
        City* ternopil = [[City alloc] initWithNameAndId:@"Ternopil" idCity:691650];
        City* mariupol = [[City alloc] initWithNameAndId:@"Mariupol" idCity:701824];
        City* chernivtsi = [[City alloc] initWithNameAndId:@"Chernivtsi" idCity:710719];
        City* nikopol = [[City alloc] initWithNameAndId:@"Nikopol" idCity:700051];
        City* chornobyl = [[City alloc] initWithNameAndId:@"Chornobyl" idCity:710403];
        City* lutsk = [[City alloc] initWithNameAndId:@"Lutsk" idCity:702569];
        City* kirovohrad = [[City alloc] initWithNameAndId:@"Kirovohrad" idCity:705812];
        City* vinnytsya = [[City alloc] initWithNameAndId:@"Vinnytsya" idCity:689558];
        City* vorokhta = [[City alloc] initWithNameAndId:@"Vorokhta" idCity:689037];
        City* bilhorodDnistrovskyy = [[City alloc] initWithNameAndId:@"Bilhorod-Dnistrovskyy" idCity:712160];
        City* yalta = [[City alloc] initWithNameAndId:@"Yalta" idCity:688533];
        City* donetsk = [[City alloc] initWithNameAndId:@"Donetsk" idCity:709717];
        
        
        self.cities = [NSMutableArray arrayWithObjects:kiev, lviv, vinnytsya, dnipropetrovsk, ternopil, mariupol, chernivtsi, nikopol, chornobyl, lutsk, kirovohrad, vorokhta, bilhorodDnistrovskyy, yalta, donetsk, nil];
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Save and Load

- (void) saveCitiesArray {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *archiveArray = [NSMutableArray new];
    for (City *city in self.cities) {
        NSData *cityEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:city];
        [archiveArray addObject:cityEncodedObject];
    }
    [userDefaults setObject:archiveArray forKey:kCitiesArray];
    
    [userDefaults synchronize];
}

- (void) loadCitiesArray {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *archivedObjects = [userDefaults objectForKey:kCitiesArray];
    
    for (NSData *obj in archivedObjects) {
        City *city = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
        [self.cities addObject:city];
    }
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
    
    City* city = [self.cities objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", city.nameCity];
    
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
    vc.cityName = selectedCity.nameCity;
}

#pragma mark - SearchCitiesDelegate

-(void) citySelected:(NSDictionary*) city {
    
    NSString *nameCity = city[@"name"];
    NSInteger idCity = [city[@"_id"] integerValue];
    
    City *newCity = [[City alloc] initWithNameAndId:nameCity idCity:idCity];
    
    [self.cities addObject:newCity];
    
    [self saveCitiesArray];
    
    [self.tableView reloadData];
}

@end
