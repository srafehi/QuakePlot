#import "EarthquakeMapViewController.h"

@interface EarthquakeMapViewController ()

@end

@implementation EarthquakeMapViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewTitle];
    [self zoomToEarthquake];
    [self displayEarthquakeAnnotation];
}

#pragma mark - Initializers

/// Sets the nagivation view's title.
- (void) setViewTitle {
    [[self navigationItem] setTitle:[_earthquake place]];
}

/// Centers the map in on the earthquake's epicenter.
- (void) zoomToEarthquake {
    [_mapView setRegion: [EarthquakeMapViewController regionForEarthquake:_earthquake] animated: NO];
}

/// Creates an annotation on the map over the earthquake's epicenter.
- (void) displayEarthquakeAnnotation {
    [_mapView addAnnotation: [EarthquakeMapViewController annotationForEarthquake: _earthquake]];
}

#pragma mark - Helpers

/// Returns a suitable map region for the given earthquake.
///
/// The region is centered on the earthquake's epicentre.
+ (MKCoordinateRegion) regionForEarthquake:(Earthquake *)earthquake {
    MKCoordinateRegion mapRegion;
    mapRegion.center = [[earthquake coordinate] coordinate];
    mapRegion.span.latitudeDelta = 1;
    mapRegion.span.longitudeDelta = 1;
    return mapRegion;
}

/// Returns an annotation for the given earthquake.
///
/// The annotation's coordinate is fixed to the earthquake's coordinates,
/// and the annotation's title is set to the earthquake's title.
+ (MKPointAnnotation *) annotationForEarthquake:(Earthquake *)earthquake {
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate: [[earthquake coordinate] coordinate]];
    [annotation setTitle: [earthquake title]];
    return annotation;
}


@end
