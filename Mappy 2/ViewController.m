//
//  ViewController.m
//  Mappy 2
//
//  Created by Clyfford Millet on 6/27/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MapPin.h"
#import "WebViewController.h"

@interface ViewController ()

@property(nonatomic, strong)MKPointAnnotation *ann4;
@property(nonatomic, strong)MKPointAnnotation *ann3;
@property(nonatomic, strong)MKPointAnnotation *ann2;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Display the zoomed in coordinates with MKCoordinationRegion
    // www.gps-coordinates.net for longitude latitude
    
    self.mapView.delegate = self;
//    self.locationManager = [[CLLocationManager alloc]init];
//    self.locationManager.delegate = self;
//    
//    [self.locationManager requestWhenInUseAuthorization];
//    [self.locationManager requestAlwaysAuthorization];
//    [self.locationManager startUpdatingLocation];
    
    self.searchBar.delegate = self;
    
    
    //hardcode restaurants
    self.ann4 = [[MKPointAnnotation alloc] init];
    self.ann4.coordinate = CLLocationCoordinate2DMake(40.73959860000001, -73.98836460000001);
    self.ann4.title = @"Cosme";
    self.ann4.subtitle = @"";
    [self.mapView addAnnotation:self.ann4];

    self.ann3 = [[MKPointAnnotation alloc] init];
    self.ann3.coordinate = CLLocationCoordinate2DMake(40.740156, -73.99336599999998);
    self.ann3.title = @"Burger and Lobster";
    self.ann3.subtitle = @"";
    [self.mapView addAnnotation:self.ann3];
    
    self.ann2 = [[MKPointAnnotation alloc] init];
    self.ann2.coordinate = CLLocationCoordinate2DMake(40.7421643, -73.98989360000002);
    self.ann2.title = @"La Pizza La Pasta";
    self.ann2.subtitle = @"";
    [self.mapView addAnnotation:self.ann2];


    
    // this was a struct thats why no initializer!
    MKCoordinateRegion region = {{0.0, 0.0}, {0.0, 0.0}};
    region.center.latitude = 40.7414344;
    region.center.longitude = -73.99003859999999;
    //control zoom
    region.span.latitudeDelta = 0.01f;
    region.span.longitudeDelta = 0.01f;
    [self.mapView setRegion:region animated:YES];
    
    MapPin *ann = [[MapPin alloc]initWithLocation:region.center];
    ann.title = @"TURN TO TECH";
    ann.subtitle = @"for learning computer equipment/mobile";
    [self.mapView addAnnotation:ann];
    
    //Make search bar text color black
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}];

    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
        if (annotationView == nil)
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
        
        annotationView.canShowCallout = YES;
        
        UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = disclosureButton;
        
        if (self.ann4 == annotation){
        
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cosme.jpg"]];
                                  
            [imageView setFrame:CGRectMake(0, 0, 30 , 30)];

        
            annotationView.leftCalloutAccessoryView = imageView;
        
            return annotationView;
        }
        
        if (self.ann3 == annotation){
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"burgerLobster.jpg"]];
            
            [imageView setFrame:CGRectMake(0, 0, 30 , 30)];
            
            
            annotationView.leftCalloutAccessoryView = imageView;
            
            return annotationView;
        }
        
        if (self.ann2 == annotation){
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"laPizza.jpg"]];
            
            [imageView setFrame:CGRectMake(0, 0, 30 , 30)];
            
            
            annotationView.leftCalloutAccessoryView = imageView;
            
            return annotationView;
        }
    }

    return nil;
}

- (void)mapView:(MKMapView *)aMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    WebViewController *wvc = [[WebViewController alloc] initWithNibName:nil bundle:nil];
    
    
    
    if ([view.annotation.title  isEqual: @"La Pizza La Pasta"]){
        wvc.url = @"https://www.eataly.com/us_en/stores/new-york/nyc-la-pizza-la-pasta/";
    }
    
    if ([view.annotation.title  isEqual: @"Burger and Lobster"]){
        wvc.url = @"http://www.burgerandlobster.com/home/";
    }
    
    if ([view.annotation.title  isEqual: @"Cosme"]){
        wvc.url = @"http://cosmenyc.com/";
    }
    
    
    
    // Push the view controller.
    [self.navigationController pushViewController:wvc animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    MKLocalSearchRequest* request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchBar.text;
    request.region = self.mapView.region;
    
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            for (MKMapItem *mapItem in [response mapItems]) {
                NSLog(@"Name: %@, MKAnnotation title: %@", [mapItem name], [[mapItem placemark] title]);
                NSLog(@"Coordinate: %f %f", [[mapItem placemark] coordinate].latitude, [[mapItem placemark] coordinate].longitude);
                // Should use a weak copy of self
                [self.mapView addAnnotation:[mapItem placemark]];
            }
        } else {
            NSLog(@"Search Request Error: %@", [error localizedDescription]);
        }
    }];
    


}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeMap:(id)sender {
    
    if (self.segmentControl.selectedSegmentIndex == 0){
        self.mapView.mapType = MKMapTypeStandard;
    }
    if (self.segmentControl.selectedSegmentIndex == 1){
        self.mapView.mapType = MKMapTypeHybrid;
    }
    if (self.segmentControl.selectedSegmentIndex == 2){
        self.mapView.mapType = MKMapTypeSatellite;

    }
}
@end
