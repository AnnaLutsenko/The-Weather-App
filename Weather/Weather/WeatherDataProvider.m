//
//  WeatherDataProvider.m
//  Weather
//
//  Created by Anna on 23.02.17.
//  Copyright © 2017 Anna Lutsenko. All rights reserved.
//

#import "WeatherDataProvider.h"
#import "AppDelegate.h"

static NSString *kCityID = @"cityID";

@implementation WeatherDataProvider

+ (id)shared {
    static WeatherDataProvider *weatherDataProvider = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weatherDataProvider = [[self alloc] init];
    });
    return weatherDataProvider;
}

- (NSMutableArray*)cities {
    
    if (!_cities) {
        _cities = [NSMutableArray new];
    }
    return _cities;
}

- (instancetype) init {
    
    if (self = [super init]) {
        
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *citiesID = [userDefaults objectForKey:kCityID];
        if (citiesID == nil) {
            return self;
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
    return self;
}

- (NSArray*) searchCity:(NSString*) nameCity {

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"City"
                                                   inManagedObjectContext:appDelegate.managedObjectContext];
    
    [request setEntity:description];
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *citiesID = [userDefaults objectForKey:kCityID];
    
    NSPredicate *predicate;
    if (citiesID == nil) {
        predicate = [NSPredicate predicateWithFormat:@"name beginswith[c] %@", nameCity];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"(name beginswith[c] %@) AND !(idCity IN %@)", nameCity, citiesID];
    }
    
    [request setPredicate:predicate];
    
    NSError *requestError = nil;
    NSArray *resultArray = [appDelegate.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    return resultArray;
}

- (City*) cityWithIndex:(NSInteger) indexCity {
    return self.cities[indexCity];
}

- (void)deleteCityWithIndex:(NSInteger) index {
    [self.cities removeObjectAtIndex:index];
    [self saveCitiesArray];
}

- (void)addCity:(City *) city {
    [self.cities addObject:city];
    [self saveCitiesArray];
}

#pragma mark - Save and Load

- (void) saveCitiesArray {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *idArray = [[NSMutableArray alloc] init];
    
    for (City* obj in [[WeatherDataProvider shared] cities]) {
        [idArray addObject:obj.idCity];
    }
    
    [userDefaults setObject:idArray forKey:kCityID];
    
    [userDefaults synchronize];
}

@end
