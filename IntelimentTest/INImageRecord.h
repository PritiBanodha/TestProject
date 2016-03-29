//
//  INImageRecord.h
//  IntelimentTest
//
//  Created by Priti Banodha on 29/03/16.
//
//

@interface INImageRecord : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) UIImage *downloadedImage;

- (id) initWithJSON:(id)json;

@end
