//
//  INUserLocationView.m
//  IntelimentTest
//
//  Created by Priti Banodha on 29/03/16.
//
//

#import "INUserLocationView.h"

@implementation INUserLocationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

- (void)setData:(CLLocation *)location
{
    self.latitudeLabel.text = [NSString stringWithFormat:@"Latitude : %f", location.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"Longitude : %f", location.coordinate.longitude];
}

@end
