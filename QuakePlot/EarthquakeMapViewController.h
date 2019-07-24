#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Model/Earthquake.h"

NS_ASSUME_NONNULL_BEGIN

/// Displays a map centered on where a given earthquake occurred.
@interface EarthquakeMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) Earthquake *earthquake;
@property (strong, nonatomic) MKPointAnnotation *annotation;

@end

NS_ASSUME_NONNULL_END
