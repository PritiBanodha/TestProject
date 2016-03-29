//
//  INThirdTabViewController.m
//  IntelimentTest
//
//  Created by Priti Banodha on 26/03/16.
//
//

#import "INThirdTabViewController.h"

@interface INThirdTabViewController ()

@end

@implementation INThirdTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self displayPaginationData];
}

- (void) displayPaginationData
{
    NSArray *arrImages = [NSArray arrayWithObjects:@"applelogo1", @"applelogo2", @"applelogo3", nil];
    for (int index = 0 ; index < arrImages.count ; index++)
    {
        CGRect frame = self.scrollView.frame;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[arrImages objectAtIndex:index]]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(frame.size.width * index, 0.0, frame.size.width, frame.size.height);
        [self.scrollView addSubview:imageView];
    }
    
    self.pageControl.numberOfPages = [arrImages count];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * [arrImages count], self.scrollView.frame.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action methods

- (void) pageControlClicked:(id)sender
{
    CGFloat x = self.pageControl.currentPage * self.scrollView.frame.size.width;
    [self.scrollView scrollRectToVisible:CGRectMake(x, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
}


#pragma mark - Scroll view delegates

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    float fractionalPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    //This will make sure that the current page gets updated only when user has scrolled through most of its view.
    NSInteger page = lround(fractionalPage);
    //Update to current page
    self.pageControl.currentPage = page;
}

@end
