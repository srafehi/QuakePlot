#import <UIKit/UIKit.h>
#import "Service/EarthquakeDelegate.h"
#import "Service/EarthquakeServiceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/// Displays the list of recently occurring earthquakes
@interface EarthquakeTableViewController : UITableViewController <EarthquakeDelegate>

@property (strong, nonatomic) IBOutlet UITableView *earthquakeTableView;
@property (strong, nonatomic) id<EarthquakeServiceProtocol> earthquakeService;
@end

NS_ASSUME_NONNULL_END
