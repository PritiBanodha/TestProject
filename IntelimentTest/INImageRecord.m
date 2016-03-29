//
//  INImageRecord.m
//  IntelimentTest
//
//  Created by Priti Banodha on 29/03/16.
//
//

#import "INImageRecord.h"

@implementation INImageRecord

- (id) initWithJSON:(id)json
{
    self = [self init];
    if (self)
    {
        //set image data
        self.url = [json objectForKey:@"url"];
        self.downloadedImage = nil;
    }

    return self;
}

@end
