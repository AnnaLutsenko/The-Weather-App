#import "City.h"

@interface City ()

// Private interface goes here.

@end

@implementation City

- (NSURL*) cityURL {
    
    NSString *url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/city?id=%d&APPID=edc60874e635ded94b5ea2f4101774bc", [self.idCity integerValue]];

    return [NSURL URLWithString:url];
}

@end
