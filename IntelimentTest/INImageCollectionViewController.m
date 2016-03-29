//
//  INImageCollectionViewController.m
//  IntelimentTest
//
//  Created by Priti Banodha on 27/03/16.
//
//

#import "INImageCollectionViewController.h"
#import "INImageRecord.h"
#define kImageView 99

@interface INImageCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *displayData;
@property (nonatomic, strong) NSURLSessionDataTask *urlSessionDataTask;

@end

@implementation INImageCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;

    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"List View";
    [self fetchImages];
}


- (void) fetchImages
{
    self.displayData = [[NSMutableArray alloc] init];
    NSError *error = nil;
    //Using sample json data to get the image urls
    NSString *sampleJsonPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SampleImages" ofType:@"json"];
    NSData *imageData = [[NSFileManager defaultManager] contentsAtPath:sampleJsonPath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:imageData options:0 error:&error];
    for (NSDictionary *imageData in [json objectForKey:@"images"])
    {
        INImageRecord *imageRecord = [[INImageRecord alloc] initWithJSON:imageData];
        [self.displayData addObject:imageRecord];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.displayData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];

    UIImageView *cellImage = (UIImageView *)[cell viewWithTag:kImageView];
    INImageRecord *imageRecord = (INImageRecord *)[self.displayData objectAtIndex:indexPath.row];

    if (imageRecord.downloadedImage)
    {
        //Use image if already downloaded
        cellImage.image = imageRecord.downloadedImage;
    }
    else
    {
        //Start image download
        __weak typeof(self) me = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
        {
            NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageRecord.url]];
            me.urlSessionDataTask = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                //Switch to main queue for UI update
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    if (error)
                    {
                        [me handleError:[error localizedDescription]];
                    }
                    else
                    {
                        UIImage *image = [[UIImage alloc] initWithData:data];
                        cellImage.image = image;
                        imageRecord.downloadedImage = image;
                    }
                });
            }];

            [me.urlSessionDataTask resume];
        });

    }
    return cell;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [self.urlSessionDataTask cancel];
}


- (void) handleError:(NSString *)errorMessage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:errorMessage
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         // dissmissal of alert
                                                     }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
