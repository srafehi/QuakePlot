#import <UIKit/UIKit.h>
#import "Model/Earthquake.h"

NS_ASSUME_NONNULL_BEGIN

/// Displays a map centered on where a given earthquake occurred.
@interface EarthquakeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *magnitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeOccurredLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

/// Updates the table view cell for the given earthquake.
-(void)setEarthquake: (Earthquake *) earthquake;

@end

NS_ASSUME_NONNULL_END
