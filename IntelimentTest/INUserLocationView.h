//
//  INUserLocationView.h
//  IntelimentTest
//
//  Created by Priti Banodha on 29/03/16.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>

@interface INUserLocationView : UIView

@property (nonatomic, weak) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *latitudeLabel;

- (void)setData:(CLLocation *)location;

@end
