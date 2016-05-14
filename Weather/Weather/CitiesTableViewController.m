//
//  CitiesTableViewController.m
//  Weather
//
//  Created by Anna on 14.05.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "CitiesTableViewController.h"
#import "SearchTableViewController.h"

@interface CitiesTableViewController ()

@end

@implementation CitiesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cities = [[NSMutableArray alloc] initWithObjects:@"Kiev", @"Vinnytsya", @"Lviv", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.cities objectAtIndex:indexPath.row]];
    
    return cell;
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
/*
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[SearchTableViewController class]]) {
        ((SearchTableViewController *)segue.destinationViewController).delegate = self;
    }
    
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        if ([nc.viewControllers[0] isKindOfClass:[SearchTableViewController class]]) {
            ((SearchTableViewController *)nc.viewControllers[0]).delegate = self;
        }
    }
}

#pragma mark - UITableViewDelegate



#pragma mark - SearchCitiesDelegate

-(void) citySelected:(NSString*) city {
    
    [self.cities addObject:city];
    
    [self.tableView reloadData];
}

@end
