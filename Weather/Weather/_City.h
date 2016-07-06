// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface CityID : NSManagedObjectID {}
@end

@interface _City : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CityID *objectID;

@property (nonatomic, strong, nullable) NSString* country;

@property (nonatomic, strong, nullable) NSNumber* idCity;

@property (atomic) int32_t idCityValue;
- (int32_t)idCityValue;
- (void)setIdCityValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* latCoord;

@property (atomic) double latCoordValue;
- (double)latCoordValue;
- (void)setLatCoordValue:(double)value_;

@property (nonatomic, strong, nullable) NSNumber* lonCoord;

@property (atomic) double lonCoordValue;
- (double)lonCoordValue;
- (void)setLonCoordValue:(double)value_;

@property (nonatomic, strong, nullable) NSString* name;

@end

@interface _City (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;

- (NSNumber*)primitiveIdCity;
- (void)setPrimitiveIdCity:(NSNumber*)value;

- (int32_t)primitiveIdCityValue;
- (void)setPrimitiveIdCityValue:(int32_t)value_;

- (NSNumber*)primitiveLatCoord;
- (void)setPrimitiveLatCoord:(NSNumber*)value;

- (double)primitiveLatCoordValue;
- (void)setPrimitiveLatCoordValue:(double)value_;

- (NSNumber*)primitiveLonCoord;
- (void)setPrimitiveLonCoord:(NSNumber*)value;

- (double)primitiveLonCoordValue;
- (void)setPrimitiveLonCoordValue:(double)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

@interface CityAttributes: NSObject 
+ (NSString *)country;
+ (NSString *)idCity;
+ (NSString *)latCoord;
+ (NSString *)lonCoord;
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END
