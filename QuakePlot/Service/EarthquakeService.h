#import "EarthquakeServiceProtocol.h"

/// Earthquake service which polls for new earthquake event data
/// are regular intervals.
@interface EarthquakeService : NSObject <EarthquakeServiceProtocol>

-(instancetype) initWithInterval: (double) interval;

@end

