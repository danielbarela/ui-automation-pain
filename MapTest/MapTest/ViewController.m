//
//  ViewController.m
//  MapTest
//
//  Created by Dan Barela on 1/15/15.
//  Copyright (c) 2015 Dan Barela. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) MKPointAnnotation *annotation;
@property (weak, nonatomic) IBOutlet UISwitch *showPinSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.annotation = [[MKPointAnnotation alloc] init];
    self.annotation.coordinate = CLLocationCoordinate2DMake(40.0, -104.0);
    self.annotation.title = @"Test";
    [self.map addAnnotation:self.annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)togglePin:(id)sender {
    [self.map removeAnnotation:self.annotation];
    [self.map addAnnotation:self.annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
            pinView.image = [UIImage imageNamed:@"pin"];
        } else {
            pinView.annotation = annotation;
        }
        pinView.hidden = !self.showPinSwitch.isOn;
        return pinView;
    }
    return nil;
}

@end
