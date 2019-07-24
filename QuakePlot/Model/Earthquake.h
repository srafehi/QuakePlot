#import <Mantle/Mantle.h>
#import <CoreLocation/CoreLocation.h>

/// Model class encapsulating earthquake data.
///
/// A geojson feature as defined by https://earthquake.usgs.gov/data/comcat/data-eventterms.php#mag
/// can be deserialized into an instance of this class.
@interface Earthquake : MTLModel <MTLJSONSerializing>

/// The title of the earthquake event - usually the location of where
/// the earthquake occurred and the distance from a significant place.
@property (nonatomic, copy, readonly) NSString *title;

/// The coordinate representing where the earthquake occurred.
@property (nonatomic, copy, readonly) CLLocation *coordinate;

/// The date and time for when the earthquake occurreed.
@property (nonatomic, copy, readonly) NSDate *timestamp;

/// The type of seismic event - “earthquake" or “quarry”.
@property (nonatomic, copy, readonly) NSString *type;

/// The place or distance to a nearby place to the earthquake's epicenter.
@property (nonatomic, copy, readonly) NSString *place;

/// The magnitude of the earthquake event.
@property (nonatomic, copy, readonly) NSNumber *magnitude;

@end
