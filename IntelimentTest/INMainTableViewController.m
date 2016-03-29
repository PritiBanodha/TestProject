//
//  INMainTableViewController.m
//  IntelimentTest
//
//  Created by Priti Banodha on 26/03/16.
//
//

#import "INMainTableViewController.h"

@interface INMainTableViewController ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation INMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNoOfCells;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *cellIdentifier;
    switch (indexPath.row)
    {
        case kCellTypePushView:
            cellIdentifier = @"pushView";
            break;
        case kCellTypePresentView:
            cellIdentifier = @"presentView";
            break;
        case kCellTypeBulbSwitch:
            cellIdentifier = @"bulbSwitch";
            break;
        case kCellTypeCalendarView:
            cellIdentifier = @"calendarView";
            break;
        case kCellTypeSubtitleView:
            cellIdentifier = @"subtitleView";
        default:
            break;
    }
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    return cell;
}

#pragma mark - Table view delegate source

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // To remove empty space before cell
    if ( [cell respondsToSelector:@selector(setSeparatorInset:)] )
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ( [cell respondsToSelector:@selector(setLayoutMargins:)] )
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((tableView.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - 20) / kNoOfCells);
}


#pragma mark - Action methods

- (void)switchChanged:(id)sender
{
    UITableViewCell *cell = [self getCellObjectForView:kCellTypeBulbSwitch];
    UISwitch *bulbSwitch = (UISwitch *)sender;
    cell.imageView.image = (bulbSwitch.isOn) ? bulbSwitch.onImage : bulbSwitch.offImage;
    cell.textLabel.text = (bulbSwitch.isOn) ? @"ON!" : @"OFF";
}


- (void)dateButtonPressed:(id)sender
{
    if (self.datePicker == nil)
    {
        CGRect frame = [[UIApplication sharedApplication] keyWindow].frame;
        UITableViewCell *cell = [self getCellObjectForView:kCellTypeCalendarView];
        CGFloat yPos = cell.frame.origin.y + cell.frame.size.height + 30;
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, yPos, frame.size.width, frame.size.height - yPos)];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        //Update the date text field as and when the picker value changes
        [self.datePicker addTarget:self action:@selector(setDateTextField:) forControlEvents:UIControlEventValueChanged];
        self.datePicker.backgroundColor = [UIColor whiteColor];
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.datePicker];
    }

    self.datePicker.hidden = NO;
    self.datePicker.date = [NSDate date];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(removeDatePicker)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}


- (void) removeDatePicker
{
    self.datePicker.hidden = YES;
    self.navigationItem.rightBarButtonItem = nil;
}


- (UITableViewCell *) getCellObjectForView:(CellType)cellType
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellType inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}


-(void)setDateTextField:(id)sender
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *date = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:self.datePicker.date]];
    UITableViewCell *cell = [self getCellObjectForView:kCellTypeCalendarView];
    UITextField *dateTextField = [cell.contentView viewWithTag:100];
    dateTextField.text = date;
}

- (IBAction)unwindFromModalView:(UIStoryboardSegue *)segue
{
    
}

@end
