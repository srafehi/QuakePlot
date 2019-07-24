#import "EarthquakeTableViewCell.h"
#import "Model/Earthquake.h"

@implementation EarthquakeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - Setters

-(void)setEarthquake: (Earthquake *) earthquake {
    [self setMagnitudeLabelText: earthquake.magnitude];
    [self setTimeOccurredLabelText: earthquake.timestamp];
    [self setPlaceLabelText: earthquake.place];
    [self setTypeLabelText: earthquake.type];
}

/// Sets the magnitude label to the nearest decimal.
-(void)setMagnitudeLabelText: (NSNumber *) magnitude {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat: @"0.#"];
    self.magnitudeLabel.text = [numberFormatter stringFromNumber: magnitude];
}

/// Set the time at which the earthquake occurred.
-(void)setTimeOccurredLabelText:(NSDate *) timeOccurred {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"E, d MMM yyyy HH:mm:ss"];
    self.timeOccurredLabel.text = [NSString stringWithFormat: @"%@", [dateFormat stringFromDate: timeOccurred]];
}

/// Sets the place for which the earthquake occurred.
-(void)setPlaceLabelText: (NSString *) place {
    self.placeLabel.text = place;
}

/// Sets the type of earthquake event ("earthquake" or "quarry").
-(void)setTypeLabelText: (NSString *) type {
    self.typeLabel.text = type;
}

@end
