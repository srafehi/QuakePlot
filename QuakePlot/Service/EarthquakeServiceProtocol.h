#import <Foundation/Foundation.h>
#import "../Model/Earthquake.h"
#import "EarthquakeDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// Earthquake Service protocol - delegates can register for new earthquake
/// data once it's ready.
@protocol EarthquakeServiceProtocol <NSObject>

/// Adds a new EarthquakeDelegate instance.
-(void) addListener: (id<EarthquakeDelegate>) listener;

/// Stop a registerede EarthquakeDelegate instance from receiving further
/// earthquake events.
-(void) removeListener: (id<EarthquakeDelegate>) listener;

@end

NS_ASSUME_NONNULL_END
