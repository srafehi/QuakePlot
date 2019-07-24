#import <Foundation/Foundation.h>
#import "../Model/Earthquake.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EarthquakeDelegate <NSObject>

/// Callback for when new earthquake data is received and ready to be consumed.
-(void) didReceiveEarthquakes: (NSArray<Earthquake *> *) earthquakes;

/// Callback for when an error was encountered while retrieving the earthquake data.
-(void) earthquakeFetchFailed: (NSError *) error;

@end

NS_ASSUME_NONNULL_END
