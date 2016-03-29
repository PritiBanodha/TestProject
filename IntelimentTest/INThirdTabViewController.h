//
//  INThirdTabViewController.h
//  IntelimentTest
//
//  Created by Priti Banodha on 26/03/16.
//
//

#import <UIKit/UIKit.h>

@interface INThirdTabViewController : UIViewController<UIScrollViewDelegate, UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

/**
 * This method will scroll to respective page/image using page control.
 */
- (IBAction)pageControlClicked:(id)sender;

@end
