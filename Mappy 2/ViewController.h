//
//  ViewController.h
//  Mappy 2
//
//  Created by Clyfford Millet on 6/27/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (IBAction)changeMap:(id)sender;




@end

