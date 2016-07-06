// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to City.m instead.

#import "_City.h"

@implementation CityID
@end

@implementation _City

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"City";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"City" inManagedObjectContext:moc_];
}

- (CityID*)objectID {
	return (CityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"idCityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"idCity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"latCoordValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"latCoord"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"lonCoordValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lonCoord"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic country;

@dynamic idCity;

- (int32_t)idCityValue {
	NSNumber *result = [self idCity];
	return [result intValue];
}

- (void)setIdCityValue:(int32_t)value_ {
	[self setIdCity:@(value_)];
}

- (int32_t)primitiveIdCityValue {
	NSNumber *result = [self primitiveIdCity];
	return [result intValue];
}

- (void)setPrimitiveIdCityValue:(int32_t)value_ {
	[self setPrimitiveIdCity:@(value_)];
}

@dynamic latCoord;

- (double)latCoordValue {
	NSNumber *result = [self latCoord];
	return [result doubleValue];
}

- (void)setLatCoordValue:(double)value_ {
	[self setLatCoord:@(value_)];
}

- (double)primitiveLatCoordValue {
	NSNumber *result = [self primitiveLatCoord];
	return [result doubleValue];
}

- (void)setPrimitiveLatCoordValue:(double)value_ {
	[self setPrimitiveLatCoord:@(value_)];
}

@dynamic lonCoord;

- (double)lonCoordValue {
	NSNumber *result = [self lonCoord];
	return [result doubleValue];
}

- (void)setLonCoordValue:(double)value_ {
	[self setLonCoord:@(value_)];
}

- (double)primitiveLonCoordValue {
	NSNumber *result = [self primitiveLonCoord];
	return [result doubleValue];
}

- (void)setPrimitiveLonCoordValue:(double)value_ {
	[self setPrimitiveLonCoord:@(value_)];
}

@dynamic name;

@end

@implementation CityAttributes 
+ (NSString *)country {
	return @"country";
}
+ (NSString *)idCity {
	return @"idCity";
}
+ (NSString *)latCoord {
	return @"latCoord";
}
+ (NSString *)lonCoord {
	return @"lonCoord";
}
+ (NSString *)name {
	return @"name";
}
@end

