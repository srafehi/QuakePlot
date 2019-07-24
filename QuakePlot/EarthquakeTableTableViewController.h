#import <UIKit/UIKit.h>
#import "Service/EarthquakeDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// Displays the list of recently occurring earthquakes
@interface EarthquakeTableTableViewController : UITableViewController <EarthquakeDelegate>

@property (strong, nonatomic) IBOutlet UITableView *earthquakeTableView;

@end

NS_ASSUME_NONNULL_END
