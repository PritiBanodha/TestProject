//
//  INMainTableViewController.h
//  IntelimentTest
//
//  Created by Priti Banodha on 26/03/16.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    kCellTypePushView,
    kCellTypePresentView,
    kCellTypeBulbSwitch,
    kCellTypeCalendarView,
    kCellTypeSubtitleView,
    kNoOfCells
} CellType;

@interface INMainTableViewController : UITableViewController

/**
 * This method will update the bulb images on switch on/off
 */
- (IBAction)switchChanged:(id)sender;

/**
 * This method will let user choose a particular date using Date Picker and display the date in format 'mm/dd/yyyy' for e.g 01/15/2016
 **/
- (IBAction)dateButtonPressed:(id)sender;
@end
