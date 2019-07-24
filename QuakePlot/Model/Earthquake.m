#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Earthquake.h"

@implementation Earthquake

/// Map our class properties to json keys.
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title": @"properties.title",
             @"coordinate": @"geometry.coordinates",
             @"timestamp": @"properties.time",
             @"magnitude": @"properties.mag",
             @"type": @"properties.type",
             @"place": @"properties.place",
             };
}

/// Converts the geojson point geometry into a CLLocation instance.
+ (NSValueTransformer *)coordinateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSArray *coordXyz, BOOL *success, NSError *__autoreleasing *error) {
        double longitude = [coordXyz[0] doubleValue];
        double latitude = [coordXyz[1] doubleValue];
        return [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    }];
}

/// Converts the epoch timestamp number into an NSDate instance.
+ (NSValueTransformer *)timestampJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *timeStamp, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:([timeStamp integerValue] / 1000)];
    }];
}

@end
