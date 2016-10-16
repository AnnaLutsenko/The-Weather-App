//
//  DayWeatherDataSource.m
//  Weather
//
//  Created by Anna on 15.10.16.
//  Copyright © 2016 Anna Lutsenko. All rights reserved.
//

#import "DayWeatherDataSource.h"
#import "DayCellTableViewCell.h"

@implementation DayWeatherDataSource

- (void) load {
    [self.dayWeatherTableView reloadData];
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
    
    cell.dayLabel.text = [NSString stringWithFormat:@"%@", @"monday"];
    
    return cell;
}

@end
