#import <Mantle/Mantle.h>
#import <AFNetworking.h>
#import "EarthquakeTableViewController.h"
#import "EarthquakeMapViewController.h"
#import "Model/Earthquake.h"
#import "EarthquakeTableViewCell.h"
#import "Service/EarthquakeService.h"


@interface EarthquakeTableViewController ()

@end

@implementation EarthquakeTableViewController
{
    NSArray* earthquakes;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create an instance of EarthquakeService only if one was not
    // injected on initialization
    if (_earthquakeService == nil) {
        // TODO: move interval to a config
        _earthquakeService = [[EarthquakeService alloc] initWithInterval: 10.0];
    }
}

/// Start listening to earthquake events
- (void)viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    [_earthquakeService addListener: self];
}

/// Stop listening to earthquake events
- (void)viewWillDisappear:(BOOL) animated {
    [super viewDidDisappear:animated];
    [_earthquakeService removeListener: self];
}

#pragma mark - Callbacks

/// Callback once a list of earthquake events were received.
///
/// The received earthquakes will be the ones to display on
/// our table view.
- (void)didReceiveEarthquakes:(NSArray *) earthquakes {
    self->earthquakes = earthquakes;
    [[self earthquakeTableView] reloadData];
}

/// Callback if an error occurred while fetching event data.
- (void)earthquakeFetchFailed:(NSError *)error {
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, error);
}

#pragma mark - Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [earthquakes count];
}

/// Create an EarthquakeTableViewCell and pass it the earthquake for rendering.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EarthquakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EarthquakeCell" forIndexPath:indexPath];
    [cell setEarthquake: [self earthquakeAtIndexPath: indexPath]];
    return cell;
}

#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"EarthquakeMapSegue" sender:indexPath];
}

/// Pass the selected earthquake to the EarthquakeMapViewController on transition.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EarthquakeMapViewController *controller = [segue destinationViewController];
    [controller setEarthquake: [self earthquakeAtIndexPath:(NSIndexPath *) sender]];
}

#pragma mark - Helpers

/// Returns an earthquake at the given index path
- (Earthquake *)earthquakeAtIndexPath:(NSIndexPath *)indexPath {
    return [self earthquakeAtIndex: [indexPath row]];
}

/// Returns an earthquake at the given index path
- (Earthquake *)earthquakeAtIndex:(double)index {
    return [earthquakes objectAtIndex: index];
}

@end
