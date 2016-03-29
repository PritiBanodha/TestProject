//
//  INMapViewController.m
//  IntelimentTest
//
//  Created by Priti Banodha on 26/03/16.
//
//

#import "INMapViewController.h"
#import "INUserLocationView.h"

@interface INMapViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) INUserLocationView *annotationView;

@end

@implementation INMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.locationManager  = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10.0;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Map view delegates

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 500, 500);
    [self.mapView setRegion:region animated:YES];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    view.canShowCallout = true;
    
    //Add cancel button as right call out accessory view
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0,-20,20,20);
    [button setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    view.rightCalloutAccessoryView = button;

    //Add custom view to show location coordinate
    INUserLocationView *userLocationView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([INUserLocationView class]) owner:self options:nil] objectAtIndex:0];
    [userLocationView setData:self.locationManager.location];
    view.detailCalloutAccessoryView = userLocationView;

    return view;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [mapView deselectAnnotation:view.annotation animated:YES];
}

-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    [mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    ((MKUserLocation *)view.annotation).title = @"Your Location";
    [mapView selectAnnotation:view.annotation animated:NO];
}

#pragma mark - Core location delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"%f   %f", location.coordinate.latitude, location.coordinate.longitude);
    //get location details
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {

            //get locality, sublocality, name, etc information of the current location
            NSLog(@"placemark:%@", placemark);
        }
    }];
}


@end
