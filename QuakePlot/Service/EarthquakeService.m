#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "EarthquakeService.h"
#import "EarthquakeDelegate.h"

@implementation EarthquakeService {
    AFHTTPSessionManager *manager;
    NSMutableArray<EarthquakeDelegate> *listeners;
    NSTimer *timer;
    double interval;
}

-(instancetype) initWithInterval:(double) interval {
    self = [super init];
    self->interval = interval;
    if (self) {
        manager = [AFHTTPSessionManager manager];
        listeners = [[NSMutableArray<EarthquakeDelegate> alloc] init];
    }
    return self;
}

#pragma mark - Listeners

/// Registers a new Earthquake event listener.
///
/// If it's the first listener to be registered, then we immediately
/// trigger a request to fetch the latest earthquake events and start
/// the timer to poll for events.
-(void) addListener: (id<EarthquakeDelegate>)listener {
    [listeners addObject:listener];
    if ([listeners count] == 1) {
        [self fetchEarthquakes];
        [self startTimer];
    }
}

/// Removes an already registered Earthquake event listener.
///
/// If no more event listeners are registered, stop the timer from
/// polling any further.
- (void)removeListener:(id<EarthquakeDelegate>)listener {
    if ([listeners containsObject:listener]) {
        [listeners removeObject:listener];
    }
    if ([listeners count] == 0) {
        [self stopTimer];
    }
}

#pragma mark - Timer

/// Triggers a request to fetch the earthquake events only if we have
/// more than one listener registered.
- (void)timerReady:(NSTimer *) timer {
    if ([listeners count] > 0) {
        [self fetchEarthquakes];
    }
}

/// Starts the timer to poll for earthquake data.
- (void)startTimer {
    [self stopTimer];
    timer = [NSTimer
             scheduledTimerWithTimeInterval: interval
             target: self
             selector: @selector(timerReady:)
             userInfo: nil
             repeats: YES];
}

/// Stops the timer from polling for earthquake data.
-(void) stopTimer {
    if (timer != nil) {
        [timer invalidate];
        timer = nil;
    }
}

/// Fetches the latest earthquake events asynchronously.
-(void)fetchEarthquakes {
    // TODO: move to a config
    NSString* url = @"https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson";
    [manager
     GET: url
     parameters: nil
     progress: nil
     success: ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *earthQuakeGeojson = (NSDictionary *) responseObject;
         NSArray *features = earthQuakeGeojson[@"features"];
         NSError *error;
         NSArray *models = [MTLJSONAdapter modelsOfClass: Earthquake.class fromJSONArray: features error: &error];
         if (error == nil) {
             [self earthQuakesFetched: models];
         } else {
             [self earthQuakesFetchFailed: error];
         }
     }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self earthQuakesFetchFailed: error];
     }];
}

#pragma mark - Delegates

/// Triggers the didReceiveEarthquakes event for all registed listeners.
-(void)earthQuakesFetched: (NSArray<Earthquake *> *) earthquakes {
    for (id<EarthquakeDelegate> listener in listeners) {
        [listener didReceiveEarthquakes: earthquakes];
    }
}

/// Triggers the earthquakeFetchFailed event for all registed listeners.
-(void)earthQuakesFetchFailed: (NSError *) error {
    for (id<EarthquakeDelegate> listener in listeners) {
        [listener earthquakeFetchFailed: error];
    }
}

@end
